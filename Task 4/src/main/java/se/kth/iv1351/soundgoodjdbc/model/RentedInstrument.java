package se.kth.iv1351.soundgoodjdbc.model;

import java.sql.Date;

/**
 *
 * @author Daniel
 */
public class RentedInstrument implements RentedInstrumentDTO
{

    private final double monthly_cost;
    private final int rentalInstrumentID;
    private final String firstName;
    private final String lastName;
    private final String instrumentName;
    private final String brand;
    private final String description;
    private int studentID;
    private Date startOfLease;

    /** Constructor
     * @param lastName
     * @param firstName
     * @param instrumentName
     * @param brand
     * @param description
     * @param monthly_cost
     * @param rentalInstrumentID
     */
    public RentedInstrument(String lastName, String firstName, String instrumentName, String brand, String description, double monthly_cost, int rentalInstrumentID)
    {
        this.firstName = firstName;
        this.lastName = lastName;
        this.instrumentName = instrumentName;
        this.brand = brand;
        this.description = description;
        this.monthly_cost = monthly_cost;
        this.rentalInstrumentID = rentalInstrumentID;
        this.studentID = 0;
        this.startOfLease = null;
    }

    /**
     * @return A string representation of all fields in this object.
     */
    @Override
    public String toString()
    {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("FirstName: ");
        stringRepresentation.append(firstName);
        stringRepresentation.append(", LastName: ");
        stringRepresentation.append(lastName);
        stringRepresentation.append(", InstrumentName: ");
        stringRepresentation.append(instrumentName);
        stringRepresentation.append(", Brand: ");
        stringRepresentation.append(brand);
        stringRepresentation.append(", Description: ");
        stringRepresentation.append(description);
        stringRepresentation.append(", Price: ");
        stringRepresentation.append(monthly_cost);
        stringRepresentation.append(", RentalInstrumentID: ");
        stringRepresentation.append(rentalInstrumentID);

        return stringRepresentation.toString();
    }

    @Override
    public String getFirstName()
    {
        return this.firstName;
    }

    @Override
    public String getLastName()
    {
        return this.lastName;
    }

    @Override
    public String getInstrumentName()
    {
        return this.instrumentName;
    }

    @Override
    public String getBrand()
    {
        return this.brand;
    }

    @Override
    public double getMonthly_cost()
    {
        return this.monthly_cost;
    }

    @Override
    public String getDescription()
    {
        return this.description;
    }

    @Override
    public int getRentalInstrumentID()
    {
        return this.rentalInstrumentID;
    }

    @Override
    public int getStudentID()
    {
        return this.studentID;
    }

    @Override
    public Date getStartOfLease()
    {
        return this.startOfLease;
    }

    public void setStartOfLease(Date date)
    {
        this.startOfLease = date;
    }

    public void setStudentID(int id)
    {
        this.studentID = id;
    }

}
