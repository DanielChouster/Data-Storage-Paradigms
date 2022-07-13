package se.kth.iv1351.soundgoodjdbc.model;

import java.sql.Date;

/**
 *
 * @author Daniel
 */

public interface RentedInstrumentDTO {
    public String getFirstName();
    public String getLastName();
    public String getInstrumentName();
    public String getBrand();
    public double getMonthly_cost();
    public String getDescription();
    public int getRentalInstrumentID();
    public int getStudentID();
    public Date getStartOfLease();
}

