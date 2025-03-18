-- Insert into login table (without specifying ID)
INSERT INTO `hospital`.`login` (`username`, `password`, `role`)
VALUES ('riya@yopmail.com', SHA2('Demo_1234', 256), 'Receptionist');

-- Insert into branch table (without specifying ID)
INSERT INTO `hospital`.`branch` (`name`, `address`)
VALUES ('Bhadgaon', 'Jalgaon');
