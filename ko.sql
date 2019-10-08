USE compubras;
/*QUESTÃO 10, LISTA 2*/

/*Selecione o código do cliente e o nome dos clientes que tenham feitos pedidos em Abril
de 2014. A lista deve ser ordenada pelo nome dos clientes em ordem alfabética*/



SELECT nome, CodCliente FROM cliente WHERE CodCliente IN
(SELECT Codcliente FROM pedido WHERE MONTH(Datapedido)=4 AND YEAR(Datapedido)=2014)
GROUP BY CodCliente ORDER BY nome ASC;



/*QUESTÃO 1, LISTA 3*/

/*Exiba o nome, endereço, cidade e o CEP dos clientes que moram em Santa Catarina e
que tenham pelo menos um pedido feito onde o prazo de entrega é entre 16 e 20 dias.*/

SELECT cliente.nome, cliente.Cidade, cliente.Endereco, cliente.Cep FROM cliente WHERE Uf='SC'IN 
(SELECT CodCliente FROM pedido WHERE PrazoEntrega BETWEEN'16' AND '20')
ORDER BY cliente.nome ASC;

/*QUESTÃO 2, LISTA 3*/

/* Exiba o nome, endereço, cidade e o CEP dos clientes que moram no Rio Grande do Sul e
tenham pedidos realizados por algum vendedor que tenha o nome iniciando com a letra A.
Além disso deve ser exibido apenas os clientes que tiveram pedidos no ano de 2015. A
lista deve estar ordenada em ordem alfabética e sem clientes repetidos.*/

SELECT cliente.nome, cliente.Endereco, cliente.Cidade, cliente.Cep FROM cliente WHERE Uf='RS' AND cliente.CodCliente IN
(SELECT CodCliente FROM pedido WHERE YEAR(Datapedido)='2015' AND CodVendedor IN 
(SELECT CodVendedor FROM Vendedor WHERE nome LIKE 'A%'))
GROUP BY Cliente.nome ORDER BY cliente.nome ASC;
 
 
 
 /*QUESTÃO 3, LISTA 3*/
 /*Crie uma consulta que exiba o nome do cliente, cidade e estado, dos clientes que fizeram
algum pedido no ano de 2015. Ordene os resultados pelos nomes dos clientes em ordem
alfabética.*/

SELECT cliente.nome, cliente.Cidade, cliente.Uf FROM Cliente WHERE CodCliente IN 
(SELECT CodCliente FROM pedido WHERE YEAR(DataPedido)='2015')
 ORDER BY cliente.nome ASC; 
 
 
 
 /*QUESTÃO 6, LISTA 4*/
 /*QUESTÃO QUE TENHO QUE POSTAR*/
 
 /*Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e
produto. Exiba o código do pedido e o valor total de cada pedido. LINHAS = 6507.*/
 
 


 
 