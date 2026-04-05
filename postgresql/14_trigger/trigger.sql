-- update yearly earnings
UPDATE players
SET
    yearly_earnings = -3000000
WHERE
    NAME = 'Katie Ledecky';

-- check yearly earnings func
CREATE
OR REPLACE FUNCTION check_yearly_earnings () RETURNS TRIGGER LANGUAGE plpgsql AS $function$
BEGIN
    IF NEW.yearly_earnings < 0 THEN
        NEW.yearly_earnings := 0;
    END IF;

    RETURN NEW;
END;
$function$;

-- trigger before create or update
CREATE TRIGGER before_update_yearly_earnings BEFORE INSERT
OR
UPDATE ON players FOR EACH ROW
EXECUTE FUNCTION check_yearly_earnings ();