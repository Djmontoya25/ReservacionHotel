UsE hotel;

CREATE TABLE huespedes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fecha_nacimiento DATE
);

CREATE TABLE habitaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    capacidad INT NOT NULL,
    estado ENUM('disponible', 'ocupada', 'mantenimiento') DEFAULT 'disponible'
);

select * from habitaciones;
CREATE TABLE reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_huesped INT NOT NULL,
    id_habitacion INT NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    estado ENUM('pendiente', 'confirmada', 'cancelada') DEFAULT 'pendiente',
    FOREIGN KEY (id_huesped) REFERENCES huespedes(id),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id)
);


CREATE TABLE pagos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    metodo_pago ENUM('efectivo', 'tarjeta', 'transferencia') NOT NULL,
    fecha_pago DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id)
);


INSERT INTO huespedes (nombre, apellido, email, telefono, fecha_nacimiento) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '555-1234', '1990-05-10'),
('María', 'Gómez', 'maria.gomez@email.com', '555-5678', '1985-08-22'),
('Carlos', 'López', 'carlos.lopez@email.com', '555-7890', '1992-11-15');


INSERT INTO habitaciones (tipo, precio, capacidad, estado) VALUES
('Individual', 50.00, 1, 'disponible'),
('Doble', 80.00, 2, 'ocupada'),
('Suite', 150.00, 4, 'disponible');


INSERT INTO reservas (id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado) VALUES
(1, 2, '2025-03-20', '2025-03-25', 'confirmada'),
(2, 3, '2025-04-01', '2025-04-05', 'pendiente');

INSERT INTO pagos (id_reserva, monto, metodo_pago) VALUES
(1, 400.00, 'tarjeta'),
(2, 600.00, 'transferencia');


SELECT r.id AS reserva_id, h.nombre, h.apellido, hab.tipo AS tipo_habitacion, r.fecha_entrada, r.fecha_salida, r.estado
FROM reservas r
INNER JOIN huespedes h ON r.id_huesped = h.id
INNER JOIN habitaciones hab ON r.id_habitacion = hab.i

/*Habitaciones ocupadas*/
SELECT hab.tipo AS tipo_habitacion, hab.capacidad, h.nombre, h.apellido, r.fecha_entrada, r.fecha_salida
FROM habitaciones hab
INNER JOIN reservas r ON hab.id = r.id_habitacion
INNER JOIN huespedes h ON r.id_huesped = h.id
WHERE r.estado = 'confirmada';
