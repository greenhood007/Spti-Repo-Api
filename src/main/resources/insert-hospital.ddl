-- Insert into login table (without hashing the password)
INSERT INTO `hospital`.`login` (`username`, `password`, `role`)
VALUES ('riya@yopmail.com', 'Demo_1234', 'Receptionist');

-- Insert into branch table
INSERT INTO `hospital`.`branch` (`name`, `address`)
VALUES ('Bhadgaon', 'Jalgaon');
