USE Ecommerce;

-- Populando a tabela clients
INSERT INTO clients (firstName, middleNameAbr, lastName, cpf, fullAddress, clientType)
VALUES ('Cleiton', 'A.', 'Silva', '12345678900', 'Rua das Flores, 123', 'PF'),
       ('Jucilene', 'C.', 'Santos', '98765432100', 'Avenida Central, 456', 'PF'),
       ('Empresa StarDucks', NULL, 'Ltda', '98761234567890', 'Rua Comercial, 789', 'PJ');

-- Populando a tabela product
INSERT INTO product (product_name, kidsSafe, category, price, rating, size, available)
VALUES ('Smartphone', 1, 'Eletrônicos', 1500.00, 4.5, 'Grande', 'Disponivel'),
       ('Camiseta', 1, 'Vestuário', 50.00, 4.2, 'M', 'Disponivel'),
       ('Boneca', 1, 'Brinquedos', 30.00, 4.0, NULL, 'Indisponível'),
       ('Chocolate', 1, 'Alimentos', 5.00, 3.8, NULL, 'Disponivel');

-- Populando a tabela payments
INSERT INTO payments (idPayment, idClient, paymentType, limitAvaliable)
VALUES (1, 1, 'Cartão', 1000.00),
       (2, 1, 'Boleto', 500.00),
       (3, 2, 'Pix', 800.00);

-- Populando a tabela orders
INSERT INTO orders (idClient, idPayment, shortDescription, freight, paymentCash)
VALUES (1, 1, 'Pedido de Cleiton', 10.00, false),
       (2, 2, 'Pedido de Jucilene', 15.00, true);

-- Populando a tabela storage
INSERT INTO storage (idProductStorage, localization, quantity)
VALUES (1, 'Prateleira A', 50),
       (2, 'Prateleira B', 100),
       (3, 'Prateleira C', 0);

-- Populando a tabela supplier
INSERT INTO supplier (idSupplier, cnpj, socialName, contact)
VALUES (1, '12345678901234', 'Fornecedor ABC', '98765432101'),
       (2, '56789012345678', 'Fornecedor XYZ', '01234567890');

-- Populando a tabela seller
INSERT INTO seller (idSeller, cnpj, cpf, socialName, absName, contact, fullAddress)
VALUES (1, NULL, '987654321', 'Vendedor João', 'João Souza', '98765432102', 'Rua do Comércio, 123'),
       (2, '01234567890123', NULL, 'Vendedor Maria', 'Maria Silva', '98765432103', 'Avenida das Vendas, 456');

-- Populando a tabela product_seller
INSERT INTO product_seller (idProduct, idSeller, quantity)
VALUES (1, 1, 20),
       (2, 1, 50),
       (3, 2, 100);

-- Populando a tabela product_supplier
INSERT INTO product_supplier (idSupplier, idProduct, quantity)
VALUES (1, 1, 100),
       (2, 2, 200),
       (1, 3, 50);

-- Populando a tabela product_order
INSERT INTO product_order (idProduct, idOrder, quantity)
VALUES (1, 1, 2),
       (2, 1, 1),
       (3, 2, 3);

-- Populando a tabela storage_location
INSERT INTO storage_location (idProduct, idStorage, localization)
VALUES (1, 1, 'Prateleira A, Caixa 1'),
       (2, 2, 'Prateleira B, Caixa 2'),
       (3, 3, 'Prateleira C, Caixa 3');

-- Populando a tabela delivery
INSERT INTO delivery (idDelivery, trackingCode, idOrder, STATUS)
VALUES (1, 'ABC123', 1, 'Em trânsito'),
       (2, 'XYZ456', 2, 'Entregue');