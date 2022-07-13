/*
 * The MIT License
 *
 * Copyright 2017 Leif Lindbäck <leifl@kth.se>.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package se.kth.iv1351.soundgoodjdbc.view;

import java.util.HashMap;
import java.util.List;
import java.util.Scanner;
import se.kth.iv1351.soundgoodjdbc.controller.Controller;
import se.kth.iv1351.soundgoodjdbc.integration.SoundgoodDBException;
import se.kth.iv1351.soundgoodjdbc.model.AvailableInstrumentDTO;
import se.kth.iv1351.soundgoodjdbc.model.DbException;
import se.kth.iv1351.soundgoodjdbc.model.RentedInstrumentDTO;

/**
 * Reads and interprets user commands. This command interpreter is blocking, the
 * user interface does not react to user input while a command is being
 * executed.
 */
public class BlockingInterpreter
{

    private static final String PROMPT = "";
    private final Scanner console = new Scanner(System.in);
    private final Controller ctrl;
    private boolean keepReceivingCmds = false;

    /**
     * Creates a new instance that will use the specified controller for all
     * operations.
     *
     * @param ctrl The controller used by this instance.
     */
    public BlockingInterpreter(Controller ctrl)
    {
        this.ctrl = ctrl;
    }

    /**
     * Stops the commend interpreter.
     */
    public void stop()
    {
        keepReceivingCmds = false;
    }

    /**
     * Interprets and performs user commands. This method will not return until
     * the UI has been stopped. The UI is stopped either when the user gives the
     * "quit" command, or when the method <code>stop()</code> is called.
     */
    public void handleCmds()
    {
        keepReceivingCmds = true;
        while (keepReceivingCmds)
        {
            try
            {
                CmdLine cmdLine = new CmdLine(readNextLine());
                switch (cmdLine.getCmd())
                {
                    case EMPTY_COMMAND:
                        break;
                    case HELP:
                        for (Command command : Command.values())
                        {
                            if (command == Command.ILLEGAL_COMMAND || command == Command.EMPTY_COMMAND)
                            {
                                continue;
                            }
                            System.out.println(command.toString().toLowerCase());
                        }
                        break;
                    case QUIT:
                        keepReceivingCmds = false;
                        break;
                    case LIST:
                        checkIfInstrumentExistsAndPrintList();
                        break;
                    case RENTED:
                        List<? extends RentedInstrumentDTO> rentList = ctrl.getRentedInstrumentList();
                        if (rentList.isEmpty())
                        {
                            System.out.println("No instruments are currently being leased.");
                        } else
                        {
                            HashMap<String, Integer> rentalCount = new HashMap<>();
                            String previousName = "";
                            int count = 0;
                            for (RentedInstrumentDTO element : rentList)
                            {
                                String currentName = element.getLastName() + " " + element.getFirstName();
                                if (!"".equals(previousName) && !currentName.equals(previousName))
                                {
                                    rentalCount.put(previousName, count);
                                    count = 0;
                                }
                                previousName = currentName;
                                count++;
                            }
                            rentalCount.put(previousName, count); //For the last iteration

                            System.out.println("");
                            previousName = "";
                            boolean limitExceeded = false;
                            for (RentedInstrumentDTO element : rentList)
                            {
                                String currentName = element.getLastName() + " " + element.getFirstName();
                                if (!currentName.equals(previousName))
                                {
                                    Integer rentCount = rentalCount.get(currentName);
                                    if (rentCount > 2)
                                    {
                                        limitExceeded = true;
                                    }
                                    System.out.println("Student: " + String.format("%-50s", currentName) + "\tNumber of instruments rented:" + rentCount);
                                    previousName = currentName;
                                }
                                System.out.println("\t\t\tInstrument: " + element.getInstrumentName() + "\tBrand: " + element.getBrand() + "\tDescription: " + String.format("%-50s", element.getDescription()) + "\tPrice: " + element.getMonthly_cost() + "\tID: " + element.getRentalInstrumentID());
                            }
                            if (limitExceeded)
                            {
                                System.out.println("\nStudents who have rented more than two instruments: ");
                                for (String name : rentalCount.keySet())
                                {
                                    int numberOfInstruments = rentalCount.get(name);
                                    if (numberOfInstruments > 2)
                                    {
                                        System.out.println("Student " + name + " has rented " + numberOfInstruments + " instruments!");
                                    }
                                }
                            } else
                            {
                                System.out.println("\nNo student has rented more than two instruments.");
                            }
                        }

                        break;

                    case TERMINATE:
                        System.out.println("Input instrument ID:");
                        String instrumentID = console.nextLine();
                        String msg = ctrl.terminateLease(Integer.parseInt(instrumentID));
                        System.out.println(msg);
                        break;

                    case RENT:
                        if (checkIfInstrumentExistsAndPrintList())
                        {

                            int rental_id = readInt("\nEnter the ID of the instrument you would like to rent.");
                            int student_id = readInt("\nEnter student ID.");
                            try
                            {
                                ctrl.rentInstrument(rental_id, student_id);
                            } catch (SoundgoodDBException ex)
                            {
                                System.out.println(ex.getMessage() + "\n" + ex.getCause().getMessage());
                            }
                        }
                        break;

                    default:
                        System.out.println("illegal command");
                }
            } catch (Exception e)
            {
                System.out.println("Operation failed");
                System.out.println(e.getMessage());
                e.printStackTrace();
            }
        }
    }

    private int readInt(String msg)
    {
        int id;
        while (true)
        {
            System.out.println(msg);
            try
            {
                String next = console.next();
                id = Integer.parseInt(next);
                break;
            } catch (java.lang.NumberFormatException ex)
            {
                System.out.println("Incorrect input");
            }
        }
        return id;
    }

    private boolean checkIfInstrumentExistsAndPrintList() throws DbException
    {
        System.out.println("Input instrument name:");
        String instrument = console.nextLine();
        List<? extends AvailableInstrumentDTO> list = ctrl.getInstrumentList(instrument);

        if (list.isEmpty())
        {
            System.out.println("No matches were found for the specified instrument.");
            return false;
        } else
        {
            for (AvailableInstrumentDTO element : list)
            {
                System.out.println(element.toString());
            }
        }
        return true;
    }

    private String readNextLine()
    {
        System.out.print(PROMPT);
        return console.nextLine();
    }
}
