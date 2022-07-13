package se.kth.iv1351.soundgoodjdbc.integration;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import se.kth.iv1351.soundgoodjdbc.model.AvailableInstrument;
import se.kth.iv1351.soundgoodjdbc.model.RentedInstrument;

/**
 * The data access object (DAO) encapsulates all database calls in the Soundgood
 * application. No code outside this class should have any knowledge of the
 * database.
 */
public class SoundgoodDAO
{

    private Connection connection;
    private PreparedStatement getInstrumentListStmt;
    private PreparedStatement getRentListStmt;
    private PreparedStatement getRentalInstrumentByIDStmt;
    private PreparedStatement insertToRentalArchiveStmt;
    private PreparedStatement updateRentListStmt;
    private PreparedStatement getNumberOfRentalsStmt;

    /**
     * Constructs a new DAO object connected to the soundgood database.
     *
     * @throws se.kth.iv1351.soundgoodjdbc.integration.SoundgoodDBException if
     * connection fails
     */
    public SoundgoodDAO() throws SoundgoodDBException
    {
        try
        {
            connectToSoundgoodDB();
            prepareStatements();
        } catch (ClassNotFoundException | SQLException exception)
        {
            throw new SoundgoodDBException("Could not connect to datasource.", exception);
        }
    }

    /**
     * Commits the current transaction.
     *
     * @throws SoundgoodDBException If unable to commit the current transaction.
     * @throws java.sql.SQLException
     */
    public void commit() throws SoundgoodDBException, SQLException
    {
        try
        {
            connection.commit();
        } catch (SQLException e)
        {
            handleException("Failed to commit", e);
        }
    }

    private void connectToSoundgoodDB() throws ClassNotFoundException, SQLException
    {
        connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/Task2new",
                "postgres", "postgres");
        connection.setAutoCommit(false);
    }

    private void prepareStatements() throws SQLException
    {
        getInstrumentListStmt = connection.prepareStatement("SELECT brand,description,monthly_cost,rental_instrument_id FROM rental_instrument_view "
                + "WHERE student_id IS NULL AND name_of_instrument=?"
        );

        getRentListStmt = connection.prepareStatement("SELECT student_view.last_name,student_view.first_name,name_of_instrument,brand,description,monthly_cost,"
                + "rental_instrument_view.rental_instrument_id FROM rental_instrument_view "
                + "INNER JOIN student_view ON student_view.student_id=rental_instrument_view.student_id "
                + "ORDER BY student_view.last_name,student_view.first_name"
        );

        getRentalInstrumentByIDStmt = connection.prepareStatement("SELECT * FROM rental_instrument_view "
                + "WHERE rental_instrument_id=?"
        );

        insertToRentalArchiveStmt = connection.prepareStatement("INSERT INTO public.rented_instrument_archive("
                + "rental_instrument_id, monthly_cost, brand, description, start_of_lease, end_of_lease, student_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)"
        );

        updateRentListStmt = connection.prepareStatement("UPDATE rental_instrument "
                + "SET start_of_lease=?, student_id=? "
                + "WHERE rental_instrument_id=?"
        );

        getNumberOfRentalsStmt = connection.prepareStatement("SELECT COUNT (*) from rental_instrument where student_id = ?");

    }

    /**
     * Gives a list of all instruments of a specific type that are available to
     * rent.
     *
     * @param instrument The instrument searched for
     * @return a list of instruments that are available to rent
     * @throws SQLException
     * @throws SoundgoodDBException
     */
    public List<AvailableInstrument> findInstruments(String instrument) throws SQLException, SoundgoodDBException
    {
        String failureMsg = "No matches were found for the specified instrument.";
        ResultSet result = null;
        List<AvailableInstrument> list = new ArrayList<>();
        try
        {
            getInstrumentListStmt.setString(1, instrument);
            result = getInstrumentListStmt.executeQuery();
            while (result.next())
            {
                list.add(new AvailableInstrument(result.getString("brand"),
                        result.getString("description"),
                        result.getInt("monthly_cost"),
                        result.getInt("rental_instrument_id")));
            }
            connection.commit();
        } catch (SQLException sqle)
        {
            handleException(failureMsg, sqle);
        } finally
        {
            closeResultSet(failureMsg, result);
        }
        return list;
    }

    /**
     * Gives a list of all rented instruments.
     *
     * @return @throws SQLException
     * @throws SoundgoodDBException
     */
    public List<RentedInstrument> findRentedInstruments() throws SQLException, SoundgoodDBException
    {
        String failureMsg = "No instruments are currently being leased.";
        ResultSet result = null;
        List<RentedInstrument> list = new ArrayList<>();
        try
        {
            result = getRentListStmt.executeQuery();
            while (result.next())
            {
                list.add(new RentedInstrument(result.getString("last_name"),
                        result.getString("first_name"),
                        result.getString("name_of_instrument"),
                        result.getString("brand"),
                        result.getString("description"),
                        result.getDouble("monthly_cost"),
                        result.getInt("rental_instrument_id")
                ));
            }
            connection.commit();
        } catch (SQLException sqle)
        {
            handleException(failureMsg, sqle);
        } finally
        {
            closeResultSet(failureMsg, result);
        }
        return list;

    }

    /**
     * Get a rented instrument
     *
     * @param id of the instrument
     * @return instrument
     * @throws SQLException
     * @throws SoundgoodDBException
     */
    public RentedInstrument getRentedInstrumentByID(int id) throws SQLException, SoundgoodDBException
    {
        RentedInstrument rentedInstrument = null;
        String failureMsg = "Cannot find  instrument with id: " + id;
        ResultSet result = null;
        try
        {
            getRentalInstrumentByIDStmt.setInt(1, id);
            result = getRentalInstrumentByIDStmt.executeQuery();
            if (result.next())
            {
                rentedInstrument = new RentedInstrument("", "", "", result.getString("brand"), result.getString("description"), result.getDouble("monthly_cost"), result.getInt("rental_instrument_id"));
                rentedInstrument.setStartOfLease(result.getDate("start_of_lease"));
                rentedInstrument.setStudentID(result.getInt("student_id"));
            }
            connection.commit();
        } catch (SQLException sqle)
        {
            handleException(failureMsg, sqle);
        } finally
        {
            closeResultSet(failureMsg, result);
        }

        return rentedInstrument;
    }

    /**
     * Rent an instrument.
     *
     * @param rental_id
     * @param student_id
     * @throws SoundgoodDBException
     * @throws SQLException
     */
    public void addNewRental(int rental_id, int student_id) throws SoundgoodDBException, SQLException
    {

        String failureMsg = "Student with ID " + student_id + " cannot rent instrument with ID " + rental_id + ".";
        try
        {
            if (!limitIsExceeded(student_id))
            {
                updateRentListStmt.setDate(1, Date.valueOf(LocalDate.now()));
                updateRentListStmt.setInt(2, student_id);
                updateRentListStmt.setInt(3, rental_id);
                updateRentListStmt.execute();
                connection.commit();
                System.out.println("Thank you! You (ID: " + student_id + ") have now rented the instrument (ID: " + rental_id + ").");
            } else
            {
                System.out.println("You must not rent more than two instruments!");

            }
        } catch (SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
    }

    /**
     * Insert an instrument to rental archive when a rental is terminated
     *
     * @param rentedInstrument
     * @throws SQLException
     * @throws SoundgoodDBException
     */
    public void insertToRentalArchive(RentedInstrument rentedInstrument) throws SQLException, SoundgoodDBException
    {
        String failureMsg = "Cannot insert to rental archive";
        try
        {
            Date date = new Date(System.currentTimeMillis());
            insertToRentalArchiveStmt.setInt(1, rentedInstrument.getRentalInstrumentID());
            insertToRentalArchiveStmt.setDouble(2, rentedInstrument.getMonthly_cost());
            insertToRentalArchiveStmt.setString(3, rentedInstrument.getBrand());
            insertToRentalArchiveStmt.setString(4, rentedInstrument.getDescription());
            insertToRentalArchiveStmt.setDate(5, rentedInstrument.getStartOfLease());
            insertToRentalArchiveStmt.setDate(6, date);
            insertToRentalArchiveStmt.setInt(7, rentedInstrument.getStudentID());
            insertToRentalArchiveStmt.execute();
            connection.commit();
        } catch (SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
    }

    /**
     * Remove student_id and start_of_lease from rental when a lease is
     * terminated
     *
     * @param rental_instrument_id
     * @throws SQLException
     * @throws SoundgoodDBException
     */
    public void updateRentList(int rental_instrument_id) throws SQLException, SoundgoodDBException
    {
        String failureMsg = "Cannot update rental list";
        try
        {
            updateRentListStmt.setDate(1, null);
            updateRentListStmt.setNull(2, java.sql.Types.INTEGER);
            updateRentListStmt.setInt(3, rental_instrument_id);
            updateRentListStmt.execute();
            connection.commit();
        } catch (SQLException sqle)
        {
            handleException(failureMsg, sqle);
        }
    }

    private void handleException(String failureMsg, Exception cause) throws SoundgoodDBException, SQLException
    {
        connection.rollback();

        if (cause != null)
        {
            throw new SoundgoodDBException(failureMsg, cause);
        } else
        {
            throw new SoundgoodDBException(failureMsg);
        }
    }

    private void closeResultSet(String failureMsg, ResultSet result) throws SoundgoodDBException
    {
        try
        {
            result.close();
        } catch (SQLException e)
        {
            throw new SoundgoodDBException(failureMsg + " Could not close result set.", e);
        }
    }

    private boolean limitIsExceeded(int student_id) throws SQLException
    {
        int numberOfRentals = 0;
        getNumberOfRentalsStmt.setInt(1, student_id);
        ResultSet result = getNumberOfRentalsStmt.executeQuery();

        if (result.next())
        {
            numberOfRentals = result.getInt(1);
        }

        return numberOfRentals > 1;
    }
}
