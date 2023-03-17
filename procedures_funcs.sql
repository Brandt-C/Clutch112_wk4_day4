-- let's make a procedure

-- looks like python:
CREATE OR REPLACE procedure late_fee_c112(
    pay_id INTEGER,
    late_fee_amount NUMERIC(7, 2) --refresher, 5 digits total and two places are decimals, 00,000.00
)
LANGUAGE plpgsql  -- Programming Language PostGreSQL
AS 
$$
BEGIN
    --this is where our code block goes
    --add late fee to the payment (payment table)
    UPDATE payment
    SET amount = amount + late_fee_amount
    where payment_id = pay_id;
    -- commit the code block inside of a transaction
    COMMIT;
END
$$
;

-- CREATE OR REPLACE procedure();

CALL late_fee_c112()

select * 
from payment
where amount < 0;

SELECT * FROM payment WHERE payment_id=22686;

CALL late_fee_c112(22686, 447.56);


-- let's store a function!

-- CALL OR REPLACE FUNCTION add_actor_c112()

select * from actor;

-- let's look at id's b/c I don't want to overwrite data!

select * 
from actor
ORDER BY actor_id DESC;


CREATE OR REPLACE FUNCTION add_actor_c112(
    a_id INTEGER,
    f_name VARCHAR(50),
    l_name VARCHAR(50)
)
RETURNS VOID

LANGUAGE plpgsql
AS
$MAIN$
BEGIN
    -- insert into actor table
    INSERT INTO actor(actor_id, first_name, last_name, last_update)

    VALUES (a_id, f_name, l_name, NOW()::TIMESTAMP);
    
END
$MAIN$
;


select * 
from actor
where actor_id = 5003;
ORDER BY actor_id DESC;


-- DON'T use call here!  use select
SELECT add_actor_c112(5003, 'Pedro', 'Pascal') 

DROP procedure add_actor_c112()