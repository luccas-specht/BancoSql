/**LISTA DE JOIN/

/*1) Mostrar a quantidade pedida para um determinado produto com um determinado código a partir da tabela item de pedido.*/
SELECT i.Quantidade, p.CodProduto FROM itempedido AS i INNER JOIN produto AS p ON p.codproduto=i.coditempedido;


/*2) Listar a quantidade de produtos que cada pedido contém.*/

CREATE VIEW y AS (SELECT p.CodPedido, i.Quantidade FROM pedido as p  INNER JOIN itempedido AS i ON i.coditempedido=p.codpedido
ORDER BY i.quantidade DESC);

SELECT * FROM y;


/*3)Ver os pedidos de cada cliente, listando nome do cliente e número do pedido. (codpedido asc, codcliente asc)*/

CREATE VIEW xica AS (SELECT cliente.CodCliente, cliente.Nome, pedido.CodPedido FROM pedido INNER JOIN cliente  ON cliente.codcliente=pedido.CodCliente
ORDER BY pedido.CodPedido asc);


SELECT * from xica;

 /*4)Listar todos os clientes com seus respectivos pedidos. Os clientes que não têm pedidos também devem ser apresentados*/
/*não ta tri*/


SELECT c.CodCliente, c.nome, p.CodPedido FROM cliente AS c INNER JOIN pedido AS p ON c.CodCliente=p.CodCliente
ORDER BY p.CodPedido, c.CodCliente ASC;




/*5) Clientes com prazo de entrega superior a 10 dias e 
que pertençam aos estados do Rio Grande do Sul ou Santa Catarina. (codcliente asc) */

SELECT CodCliente, nome FROM cliente where uf LIKE 'RS' OR uf LIKE 'SC';



SELECT * FROM cliente WHERE cliente.codcliente in

(SELECT pedido.codcliente FROM pedido where prazoentrega>10);

SELECT nome, codcliente FROM cliente WHERE CodCliente IN 
(SELECT codcliente, codpedido, uf, prazoentrega FROM pedido) WHERE 


















