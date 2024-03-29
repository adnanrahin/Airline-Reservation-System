CREATE TABLE customer_info(
	customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_first_name VARCHAR(30) NOT NULL,
    customer_last_name varchar(30),
    customer_email varchar(30) NOT NULL UNIQUE
);

CREATE TABLE airline_info(
	airline_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_name VARCHAR(30) NOT NULL
);

CREATE TABLE airport_info(
	airport_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_name VARCHAR(100) NOT NULL
);

CREATE TABLE source_info(
	source_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_id INT NOT NULL,
    FOREIGN KEY (airport_id) REFERENCES airport_info(airport_id) ON DELETE CASCADE
);

CREATE TABLE destination_info(
	destination_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_id INT NOT NULL,
    FOREIGN KEY (airport_id) REFERENCES airport_info(airport_id) ON DELETE CASCADE
);
CREATE TABLE customer_login(
	custlogin_id INT PRIMARY KEY AUTO_INCREMENT,
    cust_username VARCHAR(60) NOT NULL,
    cust_password VARCHAR(60) NOT NULL,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id) ON DELETE CASCADE
);

CREATE TABLE airline_flight_info(
	airline_flight_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_flight_name VARCHAR(60) NOT NULL,
    airline_id INT,
    fare DECIMAL(13, 4),
    flight_max_capacity INT NOT NULL,
    flight_current_capacity INT,
    FOREIGN KEY (airline_id) REFERENCES airline_info(airline_id) ON DELETE CASCADE
);

CREATE TABLE airline_admin(
	airline_admin_id INT PRIMARY KEY AUTO_INCREMENT,
	airline_admin_fname VARCHAR(60),
	airline_admin_lname VARCHAR(60),
    airline_id INT,
    FOREIGN KEY (airline_id) REFERENCES airline_info(airline_id) ON DELETE CASCADE
);

CREATE TABLE airline_admin_login(
	airline_admin_login_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_admin_id INT,
    admin_username VARCHAR(60) NOT NULL UNIQUE,
    admin_password VARCHAR(60) NOT NULL,
    FOREIGN KEY(airline_admin_id) REFERENCES airline_admin(airline_admin_id) ON DELETE CASCADE
);

CREATE TABLE available_flight(
	available_flight_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_flight_id INT,
    available_date DATE NOT NULL,
    FOREIGN KEY(airline_flight_id) REFERENCES airline_flight_info(airline_flight_id) ON DELETE CASCADE
);

CREATE TABLE flight_status(
	flight_status_id INT PRIMARY KEY AUTO_INCREMENT,
    airline_flight_id INT,
    flight_status_info VARCHAR(20) NOT NULL,
	FOREIGN KEY(airline_flight_id) REFERENCES airline_flight_info(airline_flight_id) ON DELETE CASCADE
);

CREATE TABLE reservation_info(
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    reservation_by VARCHAR(60) NOT NULL,
    reservation_date DATE NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customer_info(customer_id) ON DELETE CASCADE
);

CREATE TABLE reservation_status(
	reservation_status_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT NOT NULL,
    res_status VARCHAR(60),
    FOREIGN KEY (reservation_id) REFERENCES reservation_info(reservation_id) ON DELETE CASCADE
);

CREATE TABLE arrival_info(
	arrival_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_id INT NOT NULL,
    airline_flight_id INT NOT NULL,
    flight_status_id INT NOT NULL,
    FOREIGN KEY(airline_flight_id) REFERENCES airline_flight_info(airline_flight_id) ON DELETE CASCADE,
    FOREIGN KEY (airport_id) REFERENCES airport_info(airport_id) ON DELETE CASCADE,
    FOREIGN KEY (flight_status_id) REFERENCES flight_status(flight_status_id) ON DELETE CASCADE
);

CREATE TABLE departures_info(
	departures_id INT PRIMARY KEY AUTO_INCREMENT,
    airport_id INT NOT NULL,
    airline_flight_id INT NOT NULL,
    flight_status_id INT NOT NULL,
    FOREIGN KEY(airline_flight_id) REFERENCES airline_flight_info(airline_flight_id) ON DELETE CASCADE,
    FOREIGN KEY (airport_id) REFERENCES airport_info(airport_id) ON DELETE CASCADE,
    FOREIGN KEY (flight_status_id) REFERENCES flight_status(flight_status_id) ON DELETE CASCADE
);

CREATE TABLE flight_info(
	flight_info_id INT PRIMARY KEY AUTO_INCREMENT,
    reservation_id INT,
    airline_flight_id INT NOT NULL,
    flight_source_date DATE NOT NULL,
    flight_dest_date DATE NOT NULL,
    flight_fly_time TIME NOT NULL,
    flight_land_time TIME NOT NULL,
    source_name VARCHAR(100),
    destination_name VARCHAR(100),
    FOREIGN KEY (reservation_id) REFERENCES reservation_info(reservation_id) ON DELETE CASCADE,
    FOREIGN KEY (airline_flight_id) REFERENCES airline_flight_info(airline_flight_id) ON DELETE CASCADE
);