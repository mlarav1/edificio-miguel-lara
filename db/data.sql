-- Datos de prueba para el ejercicio 13 (Edificio)
-- Se ejecuta despues de schema.sql, dentro de la misma base de datos.

-- Usuarios de prueba (claves en texto plano indicadas en el README y en PENDIENTES.md,
-- aqui se guardan con hash BCrypt, costo 12)
INSERT INTO usuario (id, clave, nombre, rol) VALUES
('admin@correo.com', '$2a$12$gYkPJvQKzxJ.UcLsiX92m.s.sXrVpZUqeUKe9ma9/S7R83jEB.KOC', 'Miguel Lara (Administrador)', 'ADMINISTRADOR'),
('supervisor@correo.com', '$2a$12$xv/72h8aACOaQKqL/i1FhOJaZ9F7/uKQZVGmuWRCvs.v7H5EAtqvm', 'Laura Gomez', 'USUARIO'),
('residente@correo.com', '$2a$12$/eEe3axYqNbeVkzG0B4RnOfibiWLSdijpAkrYHFmJYc5SlHWegjHq', 'Carlos Perez', 'USUARIO');

-- Edificios de ciudades colombianas
INSERT INTO edificio (nombre, metros_cuadrados, altura, num_pisos, num_apartamentos, num_oficinas,
    nombre_parqueadero, num_piscinas, pais, departamento, ciudad, tiene_ascensor, valor_administracion, tiene_zona_social) VALUES
('Torre Bocagrande', 4500.00, 78.50, 22, 88, 0, 'Parqueadero Bocagrande', 1, 'Colombia', 'Bolivar', 'Cartagena', TRUE, 850000.00, TRUE),
('Edificio Manga Real', 3200.00, 45.00, 14, 56, 4, 'Parqueadero Manga', 0, 'Colombia', 'Bolivar', 'Cartagena', TRUE, 620000.00, TRUE),
('Centro Empresarial Poblado', 6000.00, 95.00, 28, 0, 120, 'Sotano Poblado', 0, 'Colombia', 'Antioquia', 'Medellin', TRUE, 1200000.00, FALSE),
('Reserva del Parque', 2800.00, 38.00, 12, 48, 0, 'Parqueadero Reserva', 1, 'Colombia', 'Antioquia', 'Medellin', TRUE, 540000.00, TRUE),
('Torres de la 93', 5200.00, 82.00, 24, 96, 6, 'Parqueadero 93', 1, 'Colombia', 'Bogota D.C.', 'Bogota', TRUE, 980000.00, TRUE),
('Edificio Chapinero Alto', 2100.00, 30.00, 9, 36, 0, 'Sin parqueadero', 0, 'Colombia', 'Bogota D.C.', 'Bogota', FALSE, 410000.00, FALSE),
('Mirador de Cali', 3300.00, 50.00, 16, 64, 2, 'Parqueadero Mirador', 1, 'Colombia', 'Valle del Cauca', 'Cali', TRUE, 700000.00, TRUE),
('Bosques del Sur', 1800.00, 24.00, 7, 28, 0, 'Sin parqueadero', 0, 'Colombia', 'Valle del Cauca', 'Cali', FALSE, 300000.00, FALSE),
('Alto de Riomar', 4000.00, 60.00, 18, 72, 3, 'Parqueadero Riomar', 1, 'Colombia', 'Atlantico', 'Barranquilla', TRUE, 760000.00, TRUE),
('Villa Country Norte', 2600.00, 34.00, 11, 44, 0, 'Parqueadero Villa Country', 0, 'Colombia', 'Atlantico', 'Barranquilla', TRUE, 480000.00, FALSE);
