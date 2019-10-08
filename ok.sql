use compubras;
/*SUBCONSULTAS*/
/*LISTA 1*/

SELECT c.nome, c.Endereco FROM cliente AS c WHERE c.CodCliente IN
(SELECT p.CodCliente FROM pedido AS p WHERE YEAR (DataPedido)='2015')
ORDER BY c.nome ASC;

/*LISTA 2*/




/*LISTA 3*/

SELECT * FROM itempedido INNER JOIN cliente;

/*LISTA 4*/


