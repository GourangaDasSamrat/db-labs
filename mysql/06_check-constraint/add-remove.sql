-- 1. Remove constraint
ALTER TABLE contacts
DROP CHECK num_no_less_than_10digits;

-- 2. Add constraint
-- Note: In MySQL, checking for NULL is done via IS NOT NULL
ALTER TABLE contacts
ADD CONSTRAINT contacts_num_not_null CHECK (num IS NOT NULL);