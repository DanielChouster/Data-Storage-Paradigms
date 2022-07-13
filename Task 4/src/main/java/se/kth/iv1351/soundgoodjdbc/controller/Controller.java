package se.kth.iv1351.soundgoodjdbc.controller;

import java.sql.SQLException;
import java.util.List;
import se.kth.iv1351.soundgoodjdbc.integration.SoundgoodDAO;
import se.kth.iv1351.soundgoodjdbc.integration.SoundgoodDBException;
import se.kth.iv1351.soundgoodjdbc.model.DbException;
import se.kth.iv1351.soundgoodjdbc.model.RentedInstrument;
import se.kth.iv1351.soundgoodjdbc.model.AvailableInstrumentDTO;
import se.kth.iv1351.soundgoodjdbc.model.RentedInstrumentDTO;

public class Controller
{

    private final SoundgoodDAO soundgoodDb;

    /**
     * Creates a new instance, and retrieves a connection to the database.
     *
     * @throws SoundgoodDBException If unable to connect to the database.
     */
    public Controller() throws SoundgoodDBException
    {
        soundgoodDb = new SoundgoodDAO();
    }

    /**
     * Gets a list of available instruments of a specific type
     *
     * @param instrument
     * @return list of available instruments
     * @throws DbException
     */
    public List<? extends AvailableInstrumentDTO> getInstrumentList(String instrument) throws DbException
    {
        try
        {
            return soundgoodDb.findInstruments(instrument);
        } catch (SQLException | SoundgoodDBException e)
        {
            throw new DbException("Unable to get list.", e);
        }

    }

    /**
     * Gets a list of all rented instruments
     *
     * @return
     * @throws DbException
     */
    public List<? extends RentedInstrumentDTO> getRentedInstrumentList() throws DbException
    {
        try
        {
            return soundgoodDb.findRentedInstruments();
        } catch (SQLException | SoundgoodDBException e)
        {
            throw new DbException("Unable to get list.", e);
        }

    }

    /**
     * Terminates a lease
     *
     * @param id
     * @return Message that confirms the operation
     * @throws DbException
     */
    public String terminateLease(int id) throws DbException
    {

        try
        {
            String msg = "";
            RentedInstrument rentedInstrument = soundgoodDb.getRentedInstrumentByID(id);
            if (rentedInstrument == null)
            {
                msg = "Could not find instrument with ID " + id;
            } else
            {
                int student_id = rentedInstrument.getStudentID();
                if (student_id == 0)
                {
                    msg = "Selected instrument is not rented out.";
                } else
                {
                    //insert to archive
                    soundgoodDb.insertToRentalArchive(rentedInstrument);
                    //Set student_id and start_of_lease in rental_instrument to null 
                    soundgoodDb.updateRentList(rentedInstrument.getRentalInstrumentID());
                    msg = "Lease for instrument with ID " + id + " is terminated.";

                }
            }
            return msg;

        } catch (SQLException | SoundgoodDBException e)
        {
            throw new DbException("Unable to terminate lease.", e);
        }
    }

    /**
     * Rents an instrument.
     *
     * @param rental_id
     * @param student_id
     * @throws SoundgoodDBException
     * @throws SQLException
     */
    public void rentInstrument(int rental_id, int student_id) throws SoundgoodDBException, SQLException
    {
        soundgoodDb.addNewRental(rental_id, student_id);
    }
}
