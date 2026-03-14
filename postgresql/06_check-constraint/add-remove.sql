-- remove constrain
ALTER TABLE contacts
DROP CONSTRAINT contacts_num_check;

-- add constrain
ALTER TABLE contacts ADD CONSTRAINT contacts_num_not_null CHECK (num != NULL);