package se.kth.iv1351.soundgoodjdbc.model;

/**
 *
 * @author Daniel
 */
public class AvailableInstrument implements AvailableInstrumentDTO
{

    private final int monthly_cost;
    private final String brand;
    private final String description;
    private final int rental_instrument_id;

    /**
     * Constructor
     *
     * @param brand
     * @param description
     * @param monthly_cost
     * @param rental_instrument_id
     */
    public AvailableInstrument(String brand, String description, int monthly_cost, int rental_instrument_id)
    {
        this.brand = brand;
        this.description = description;
        this.monthly_cost = monthly_cost;
        this.rental_instrument_id = rental_instrument_id;
    }

    /**
     * @return A string representation of all fields in this object.
     */
    @Override
    public String toString()
    {
        StringBuilder stringRepresentation = new StringBuilder();
        stringRepresentation.append("Brand: ");
        stringRepresentation.append(brand);
        stringRepresentation.append(", Description: ");
        stringRepresentation.append(description);
        stringRepresentation.append(", Price: ");
        stringRepresentation.append(monthly_cost);
        stringRepresentation.append(", Rental ID: ");
        stringRepresentation.append(rental_instrument_id);

        return stringRepresentation.toString();
    }

    /**
     * Get the brand of the instrument
     *
     * @return the brand
     */
    @Override
    public String getBrand()
    {
        return this.brand;
    }

    /**
     * Get the monthly cost of the instrument.
     *
     * @return the cost
     */
    @Override
    public int getMonthly_cost()
    {
        return this.monthly_cost;
    }

    /**
     * Get the description of the instrument.
     *
     * @return description
     */
    @Override
    public String getDescription()
    {
        return this.description;
    }

    /**
     * Get the ID of the instrument.
     *
     * @return instrument_id
     */
    @Override
    public int get_rental_instrument_id()
    {
        return this.rental_instrument_id;
    }
}
