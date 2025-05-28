select * from users;

CREATE TABLE users (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT
);

INSERT INTO users (id, name, age) VALUES (1, 'Alice', 25), (2, 'Bob', 30);
