SELECT rental_instrument.rental_instrument_id,
    rental_instrument.instrument_id,
    rental_instrument.monthly_cost,
    rental_instrument.brand,
    rental_instrument.description,
    rental_instrument.start_of_lease,
    rental_instrument.student_id,
    instrument.name_of_instrument
   FROM rental_instrument
     JOIN instrument ON instrument.instrument_id = rental_instrument.instrument_id;
