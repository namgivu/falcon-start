DROP TABLE IF EXISTS customers;

CREATE TABLE customers(
    id serial PRIMARY KEY,
    name text,
    dob date,
    updated_at timestamp
);


INSERT INTO customers
    (name, dob, updated_at)
VALUES
    ('Name01', '2018-01-02', '2019-08-12 04:05:01'),
    ('Name02', '2018-02-03', '2019-08-13 05:06:01'),
    ('Name03', '2018-03-04', '2019-08-14 06:07:01'),
    ('Name04', '2018-04-05', '2019-08-15 07:08:01'),
    ('Name05', '2018-05-06', '2019-08-16 08:09:01');
