CREATE USER user1 WITH SUPERUSER PASSWORD 'password';
CREATE DATABASE connect_data WITH OWNER user1;

/* Source table */
CREATE TABLE source (
  user_id serial PRIMARY KEY,
  username VARCHAR(20) NOT NULL,
  password VARCHAR(20) NOT NULL,
  email VARCHAR(30) UNIQUE NOT NULL,
  created_on TIMESTAMP NOT NULL
);

INSERT INTO source (username, password, email, created_on)
VALUES
('user1', 'password', 'user1@example.com', '2019-01-01 12:00:00')