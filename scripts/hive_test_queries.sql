CREATE DATABASE atlas_test;

USE atlas_test;

CREATE TABLE test_table(id INT);

CREATE TABLE test_table_2 AS
SELECT id FROM test_table;
