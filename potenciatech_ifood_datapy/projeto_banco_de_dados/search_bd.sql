USE Ecommerce;

-- Quantidade de Produtos do Vendedor:
SELECT s.socialName AS 'Nome do Vendedor', COUNT(ps.idProduct) AS 'Quantidade de Produtos'
FROM seller s
LEFT JOIN product_seller ps ON s.idSeller = ps.idSeller
GROUP BY s.idSeller, s.socialName;

-- Quantidade de Clientes:
SELECT COUNT(*) AS 'Quantidade de Clientes'
FROM clients;

-- Mesclagem das tabelas Clients e Orders concatenando o nome e truncando valores:
SELECT CONCAT(LEFT(firstName, 1), '.', LEFT(lastName, 3), '.') AS 'Nome Cliente', LEFT(shortDescription, 20) AS 'Descrição Pedido'
FROM clients
JOIN orders ON clients.idClient = orders.idClient;

-- Colunas das tabelas Clients e Orders:
SELECT c.*, o.*
FROM clients c
JOIN orders o ON c.idClient = o.idClient;

-- Informações dos produtos e das compras:
SELECT p.product_name AS 'Produto', o.shortDescription AS 'Descrição Pedido'
FROM product p
JOIN product_order po ON p.idProduct = po.idProduct
JOIN orders o ON po.idOrder = o.idOrder;

-- Informações dos produtos e das compras ordenando pelo Frete:
SELECT p.product_name AS 'Produto', o.shortDescription AS 'Descrição Pedido', o.freight AS 'Frete'
FROM product p
JOIN product_order po ON p.idProduct = po.idProduct
JOIN orders o ON po.idOrder = o.idOrder
ORDER BY o.freight;

-- Quantidade de pedidos feitos por cliente:
SELECT c.firstName, c.lastName, COUNT(o.idOrder) AS 'Quantidade de Pedidos'
FROM clients c
LEFT JOIN orders o ON c.idClient = o.idClient
GROUP BY c.idClient, c.firstName, c.lastName;

-- Nome, sobrenome e CPF de todos os clientes pessoa física:
SELECT firstName AS 'Primeiro Nome', lastName AS 'Sobrenome', cpf AS 'CPF'
FROM clients
WHERE clientType = 'PF';

-- Nome do produto, categoria e classificação de todos os produtos cadastrados:
SELECT product_name AS 'Nome do Produto', category AS 'Categoria', rating AS 'Classificação'
FROM product;

-- Nomes e CPFs dos clientes cujos pedidos foram confirmados:
SELECT c.firstName, c.lastName, c.cpf
FROM clients c
JOIN orders o ON c.idClient = o.idClient
WHERE o.orderStatus = 'Confirmado';

-- Atualiza o limite disponível para pagamento dos clientes que com pedidos 'processando' e têm limite menor que 600 para 600:
BEGIN;
START TRANSACTION;
	UPDATE payments p
	JOIN orders o ON p.idClient = o.idClient
	SET p.limitAvaliable = 600
	WHERE o.orderStatus = 'Processando' AND p.limitAvaliable < 600;
COMMIT;

-- Exclui todos os produtos que não possuem fornecedores na tabela de relacionamento "product_supplier":
BEGIN;
START TRANSACTION;
	DELETE FROM product
	WHERE idProduct NOT IN (SELECT DISTINCT idProduct FROM product_supplier);
COMMIT;

-- Categoria do produto e a soma da quantidade de produtos em estoque para cada categoria:
SELECT category AS 'Categoria', SUM(quantity) AS 'Quantidade em Estoque'
FROM product
JOIN storage_location sl ON product.idProduct = sl.idProduct
GROUP BY category;