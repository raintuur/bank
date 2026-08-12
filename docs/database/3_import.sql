INSERT INTO role (id, name) VALUES (default, 'admin');
INSERT INTO role (id, name) VALUES (default, 'customer');

INSERT INTO "user" (id, role_id, username, password, status) VALUES (default, 1, 'admin', '123', 'A');
INSERT INTO "user" (id, role_id, username, password, status) VALUES (default, 2, 'rain', '123', 'A');
INSERT INTO "user" (id, role_id, username, password, status) VALUES (default, 2, 'mitteaktiivne', '123', 'D');


INSERT INTO city (id, name) VALUES (default, 'Tartu');
INSERT INTO city (id, name) VALUES (default, 'Tallinn');
INSERT INTO city (id, name) VALUES (default, 'Pärnu');


INSERT INTO location (id, city_id, name, number_of_atms, status, lng, lat) VALUES (default, 2, 'Sikupilli Prisma', 5, 'A', 24.7795000, 59.4369000);
INSERT INTO location (id, city_id, name, number_of_atms, status, lng, lat) VALUES (default, 2, 'Tondi Selver', 3, 'A', 24.7120000, 59.4136000);


INSERT INTO transaction_type (id, name) VALUES (default, 'raha sisse');
INSERT INTO transaction_type (id, name) VALUES (default, 'raha välja');
INSERT INTO transaction_type (id, name) VALUES (default, 'maksed');


INSERT INTO location_transaction_type (id, location_id, transaction_type_id) VALUES (default, 1, 1);
INSERT INTO location_transaction_type (id, location_id, transaction_type_id) VALUES (default, 1, 2);
INSERT INTO location_transaction_type (id, location_id, transaction_type_id) VALUES (default, 1, 3);
INSERT INTO location_transaction_type (id, location_id, transaction_type_id) VALUES (default, 2, 2);

