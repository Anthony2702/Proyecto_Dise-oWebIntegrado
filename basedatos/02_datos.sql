-- ============================================================
-- Datos de prueba - autodev_db
-- ============================================================

USE autodev_db;

-- Usuarios del portal
INSERT INTO usuario (nombres, correo, clave, rol, estado, fecha_registro) VALUES
('Anthony Flores',  'admin@autodev.pe',   'admin123', 'ADMINISTRADOR', 'A', '2026-01-15'),
('Lucia Ramirez',   'ventas@autodev.pe',  'ventas123','VENDEDOR',      'A', '2026-03-02');

-- Catalogo de productos AUTODEV
INSERT INTO producto (codigo, nombre, descripcion, precio_anual, estado) VALUES
('AUTOSIRE',      'AutoSire',      'Descarga masiva de comprobantes de pago de ventas y compras en formato Excel, PDF, XML y CDR', 1200.00, 'A'),
('AUTOGUIAS',     'AutoGuias',     'Descarga masiva de guias de remision emitidas, recibidas y de transportista en PDF, XML y Excel', 950.00, 'A'),
('AUTORHE',       'AutoRHE',       'Descarga masiva de recibos por honorarios electronicos en formato PDF', 700.00, 'A'),
('AUTOVALIDADOR', 'AutoValidador', 'Validacion masiva de comprobantes de pago, numeros de RUC y tipo de cambio', 850.00, 'A'),
('AUTOBUZON',     'AutoBuzon',     'Gestion centralizada del buzon electronico de SUNAT y SUNAFIL', 1100.00, 'A');

-- Clientes
INSERT INTO cliente (ruc, razon_social, contacto, correo, telefono, fecha_registro, estado) VALUES
('20512345678', 'Estudio Contable Perez SAC',        'Marco Perez',    'mperez@ecperez.pe',      '958471203', '2026-02-10', 'A'),
('20604827391', 'Consultora Tributaria Andina EIRL', 'Rosa Quispe',    'rquispe@ctandina.pe',    '947118250', '2026-03-05', 'A'),
('20487213904', 'Corporacion Logistica del Sur SAC', 'Julio Mamani',   'jmamani@clsur.com.pe',   '981205774', '2026-04-18', 'A'),
('10428917355', 'Contadores Asociados Arequipa',     'Elena Ticona',   'eticona@caqp.pe',        '953662418', '2026-05-22', 'A'),
('20539104772', 'Transportes Vega Hermanos SAC',     'Diego Vega',     'dvega@tvega.com.pe',     '964330871', '2026-06-30', 'A');

-- Licencias contratadas (venta anual)
INSERT INTO licencia (id_cliente, id_producto, fecha_inicio, fecha_fin, monto_contrato, estado) VALUES
(1, 1, '2026-02-15', '2027-02-15', 1200.00, 'VIGENTE'),
(1, 4, '2026-02-15', '2027-02-15',  850.00, 'VIGENTE'),
(2, 1, '2026-03-10', '2027-03-10', 1200.00, 'VIGENTE'),
(2, 3, '2026-03-10', '2027-03-10',  700.00, 'VIGENTE'),
(3, 2, '2026-04-20', '2027-04-20',  950.00, 'VIGENTE'),
(3, 5, '2026-04-20', '2027-04-20', 1100.00, 'VIGENTE'),
(4, 1, '2025-09-01', '2026-09-01', 1200.00, 'VENCIDA'),
(4, 3, '2026-05-25', '2027-05-25',  700.00, 'VIGENTE'),
(5, 2, '2026-07-01', '2027-07-01',  950.00, 'VIGENTE');

-- Pagos registrados
INSERT INTO pago (id_licencia, monto, fecha_pago, medio_pago, nro_operacion) VALUES
(1, 1200.00, '2026-02-15', 'TRANSFERENCIA', 'OP-884213'),
(2,  850.00, '2026-02-15', 'TRANSFERENCIA', 'OP-884214'),
(3, 1200.00, '2026-03-10', 'YAPE',          'YP-119045'),
(4,  700.00, '2026-03-12', 'YAPE',          'YP-119312'),
(5,  950.00, '2026-04-20', 'DEPOSITO',      'DP-556718'),
(6, 1100.00, '2026-04-22', 'TRANSFERENCIA', 'OP-901544'),
(7, 1200.00, '2025-09-01', 'EFECTIVO',      'EF-000317'),
(8,  700.00, '2026-05-25', 'PLIN',          'PL-447290'),
(9,  950.00, '2026-07-01', 'TRANSFERENCIA', 'OP-978123');
