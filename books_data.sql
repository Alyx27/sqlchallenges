create database books

--

create table authors
(author_id serial primary key
	, full_name varchar(50)
, first_name varchar (50)
, last_name varchar(50))

create table publishers
(publisher_id serial primary key
, publisher varchar(50))

create table metadata
(
book_id serial primary key
, title varchar(50)
, author_id int references authors(author_id)
, full_name varchar(50)
, no_of_pages int
, genre varchar(100)
, date_published date
, publisher_id int references publisher_id(publishers)
, publisher varchar(50)
 )

SELECT conname FROM pg_constraint
WHERE conrelid = 'metadata'::regclass
AND contype = 'f';
 
 --
--/ 
insert into authors
(full_name, first_name, last_name)
values
('Claire Keegan', 'Claire', 'Keegan')
, ('Shirley Jackson', 'Shirley', 'Jackson')
, ('Mikki Brammer', 'Mikki', 'Brammer')
, ('Sohn Won-Pyung', 'Won-Pyung', 'Sohn')
, ('Gabrielle Zevin', 'Gabrielle', 'Zevin')
, ('Khaled Hosseini', 'Khaled', 'Hosseini')
, ('Emily Henry', 'Emily', 'Henry')
, ('Suzanne Collins', 'Suzanne', 'Collins')
, ('Sally Rooney', 'Sally', 'Rooney')
, ('Jennette McCurdy', 'Jennette', 'McCurdy')
, ('Chandler Morrison', 'Chandler', 'Morrison')
, ('Paul Kalanithi', 'Paul', 'Kalanithi') 
, ('Samantha Shannon', 'Samantha', 'Shanon') 
, ('Penelope Douglas', 'Penelope', 'Douglas') 
, ('Andy Weir', 'Andy', 'Weir')
, ('George Orwell', 'George', 'Orwell') 
, ('Taylor Jenkins Reid', 'Taylor Jenkins',	'Reid')
, ('Verity Lowell', 'Verity', 'Lowell')
, ('Alice Oseman', 'Alice', 'Oseman')
, ('Olivia Waite', 'Olivia', 'Waite') 
, ('Carol Wyer', 'Carol', 'Wyer')
, ('Svetlana Chmakova', 'Svetlana', 'Chmakova')
, ('Katherine Faulkner', 'Katherine', 'Faulkner')
, ('Brandy Colbert', 'Brandy', 'Colbert')
, ('Morgan Housel', 'Morgan', 'Housel')
, ('Jaigirda Adiba', 'Jaigirda', 'Adiba')
, ('Tara Westover', 'Tara', 'Westover')
, ('Brynne Rebele-Henry', 'Brynne', 'Rebele-Henry')
, ('Nio Nakatani', 'Nio', 'Nakatani')
, ('Kate Elizabeth Russell', 'Kate Elizabeth', 'Russell',)
, ('Alexandria Bellefleur', 'Alexandria', 'Bellefleur')
, ('Leigh Bardugo', 'Leigh', 'Bardugo')
, ('Silvia Moreno-Garcia', 'Silvia', 'Moreno-Garcia')
, ('Nancy Garden', 'Nancy', 'Garden')
, ('Casey McQuiston', 'Casey', 'McQuiston')
, ('Ciara Smyth', 'Ciara', 'Smyth')
, ('Iain Reid', 'Iain', 'Reid')
, ('Amanda Lovelace', 'Amanda', 'Lovelace')
, ('James Clear', 'James', 'Clear')
, ('Rupi Kaur', 'Rupi', 'Kaur')
, ('Madeline Miller', 'Madeline', 'Miller')
, ('Hector Garcia Puigcerver', 'Hector', 'Garcia Puigcerver')
, ('Kelly Quindlen', 'Kelly', 'Quindlen')
, ('Taylor Adams', 'Taylor', 'Adams')
, ('Nina Varela', 'Nina', 'Varela')
, ('Agustina Bazterrica', 'Agustina', 'Bazterrica')
, ('Katrina Leno', 'Katrina', 'Leno')
, ('Rachel Hawkins', 'Rachel', 'Hawkins')
, ('Chanel Miller', 'Chanel', 'Miller')
, ('Siera Maley', 'Siera', 'Maley')
, ('Colleen Hoover', 'Colleen', 'Hoover')
, ('Dorothy Allison', 'Dorothy', 'Allison')

 ---
 
 select *
 from authors
 
 select *
 from metadata