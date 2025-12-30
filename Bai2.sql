create database db_k24_cntt04_QuangVinh;
use db_k24_cntt04_QuangVinh ;
CREATE TABLE Reader (
    reader_id     INT AUTO_INCREMENT,
    reader_name   VARCHAR(100) NOT NULL,
    phone         VARCHAR(15) UNIQUE,
    register_date DATE DEFAULT (CURRENT_DATE),

    CONSTRAINT pk_reader PRIMARY KEY (reader_id)
);

alter table Reader
add column email varchar(100) unique;

CREATE TABLE Book (
    book_id      INT,
    book_title   VARCHAR(150) NOT NULL,
    author       VARCHAR(100),
    publish_year INT,

    CONSTRAINT pk_book PRIMARY KEY (book_id),
    CONSTRAINT ck_publish_year CHECK (publish_year >= 1900)
);

alter table Book
modify column author varchar(150);

CREATE TABLE Borrow (
    reader_id   INT,
    book_id     INT,
    borrow_date DATE DEFAULT (CURRENT_DATE),
    return_date DATE,

    CONSTRAINT pk_borrow PRIMARY KEY (reader_id, book_id, borrow_date),

    CONSTRAINT fk_borrow_reader
        FOREIGN KEY (reader_id)
        REFERENCES Reader(reader_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CONSTRAINT fk_borrow_book
        FOREIGN KEY (book_id)
        REFERENCES Book(book_id)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);
alter table Borrow
add constraint ck_return_date
check (return_data is null or return_date >= borrow_date);

