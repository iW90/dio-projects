-- cria o banco de dados caso ainda não exista
CREATE DATABASE IF NOT EXISTS Ecommerce;
USE Ecommerce;

-- criação das tabelas (removendo as tabelas "order" e "storage" que já foram criadas anteriormente)
-- drop table clients, product, payment, order, storage;
-- drop database Ecommerce;

-- cria a tabela de clientes
CREATE TABLE clients(
	idClient INT auto_increment PRIMARY KEY,
	firstName VARCHAR(15) NOT NULL,
	middleNameAbr CHAR(3),
	lastName VARCHAR(30) NOT NULL,
	cpf CHAR(11),
	cnpj CHAR(15),
	fullAddress VARCHAR(50) NOT NULL,
	clientType ENUM('PF', 'PJ') NOT NULL,
	CONSTRAINT unique_cpf_client UNIQUE (cpf),
	CONSTRAINT unique_cnpj_client UNIQUE (cnpj)
);
DESC clients;

-- cria a tabela de produtos
CREATE TABLE product(
	idProduct INT auto_increment PRIMARY KEY,
	product_name VARCHAR(50) NOT NULL,
	kidsSafe BOOL,
	category ENUM('Eletrônicos', 'Vestuário', 'Brinquedos', 'Alimentos') NOT NULL,
	price FLOAT NOT NULL,
	rating FLOAT DEFAULT 0,
	size VARCHAR(10),
	available ENUM('Disponivel', 'Indisponível') DEFAULT ('Indisponível')
);
DESC product;

-- cria a tabela de pagamento
CREATE TABLE payments(
	idPayment INT,
	idClient INT,
	paymentType ENUM('Boleto', 'Cartão', 'Pix'),
	limitAvaliable FLOAT,
	CONSTRAINT fk_payment_client FOREIGN KEY (idClient) REFERENCES clients(idClient),
	PRIMARY KEY (idPayment, idClient)
);
DESC payments;

-- cria a tabela de pedidos
CREATE TABLE orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
	idClient INT,
	idPayment INT,
	orderStatus ENUM('Processando', 'Cancelado', 'Confirmado') DEFAULT 'Processando',
	shortDescription VARCHAR(255),
	freight FLOAT DEFAULT (10),
	paymentCash BOOL DEFAULT false,
	CONSTRAINT fk_order_client FOREIGN KEY(idClient) REFERENCES clients(idClient)
);
DESC orders;

-- cria o relacionamento N:M pedido/pagamento
CREATE TABLE order_payments(
	idOrder INT NOT NULL,
	idPayment INT NOT NULL,
	idClient INT NOT NULL,
	PRIMARY KEY (idOrder, idPayment, idClient),
	CONSTRAINT fk_order_payments_order FOREIGN KEY(idOrder) REFERENCES orders(idOrder),
	CONSTRAINT fk_order_payments_payment FOREIGN KEY(idPayment, idClient) REFERENCES payments(idPayment, idClient)
);
DESC order_payments;

-- cria a tabela de estoque
CREATE TABLE storage(
	idProductStorage INT PRIMARY KEY,
	localization VARCHAR(255),
	quantity INT DEFAULT 0
);
DESC storage;

-- cria a tabela de fornecedores
CREATE TABLE supplier(
	idSupplier INT PRIMARY KEY,
	cnpj CHAR(15) NOT NULL,
	socialName VARCHAR(255) NOT NULL,
	contact CHAR(11) NOT NULL,
	CONSTRAINT unique_supplier UNIQUE (cnpj)
);
DESC supplier;

-- cria a tabela de vendedores
CREATE TABLE seller(
	idSeller INT PRIMARY KEY,
	cnpj CHAR(15),
	cpf CHAR(9),
	socialName VARCHAR(255) NOT NULL,
	absName VARCHAR(255),
	contact CHAR(11) NOT NULL,
	fullAddress VARCHAR(255),
	CONSTRAINT unique_cpf_seller UNIQUE (cpf),
	CONSTRAINT unique_cnpj_seller UNIQUE (cnpj)
);
DESC seller;

-- criar relacionamento produto_vendedor
CREATE TABLE product_seller(
	idProduct INT,
	idSeller INT,
	quantity INT DEFAULT 1,
	PRIMARY KEY(idProduct, idSeller),
	CONSTRAINT fk_product_seller FOREIGN KEY(idSeller) REFERENCES seller(idSeller),
	CONSTRAINT fk_product_product FOREIGN KEY(idProduct) REFERENCES product(idProduct)
);

-- criar tabela de relacionamento produto_pedido
CREATE TABLE product_order(
	idProduct INT,
	idOrder INT,
	quantity INT,
	orderStatus ENUM('Processando', 'Cancelado', 'Confirmado') DEFAULT 'Processando',
	PRIMARY KEY(idProduct, idOrder),
	CONSTRAINT fk_product_order FOREIGN KEY(idProduct) REFERENCES product(idProduct),
	CONSTRAINT fk_order_product FOREIGN KEY(idOrder) REFERENCES orders(idOrder)
);

-- criar tabela estoque
CREATE TABLE storage_location(
	idProduct INT,
	idStorage INT,
	localization VARCHAR(255) NOT NULL,
	PRIMARY KEY (idProduct, idStorage),
	CONSTRAINT fk_storage_location_product FOREIGN KEY(idProduct) REFERENCES product(idProduct),
	CONSTRAINT fk_storage_product FOREIGN KEY(idStorage) REFERENCES storage(idProductStorage)
);

-- criar tabela de relacionamento produto/fornecedor
CREATE TABLE product_supplier(
	idSupplier INT,
	idProduct INT,
	quantity INT NOT NULL,
	PRIMARY KEY (idSupplier, idProduct),
	CONSTRAINT fk_product_supplier_supplier FOREIGN KEY(idSupplier) REFERENCES supplier(idSupplier),
	CONSTRAINT fk_product_supplier_product FOREIGN KEY(idProduct) REFERENCES product(idProduct)
);

-- criar tabela entrega
CREATE TABLE delivery(
	idDelivery INT,
	trackingCode VARCHAR(20),
	idOrder INT,
	STATUS ENUM('Processando', 'Em trânsito', 'Entregue', 'Devolvido'),
	CONSTRAINT fk_delivery_order FOREIGN KEY(idOrder) REFERENCES orders(idOrder)
);