/*EXERCICOS DE SUBCONSULTA*/

/*OK*--> bateu com o resultado do sor/
/*X* --> não entendi/

/*1). Lista: 1*/

SELECT c.nome, c.Endereco FROM cliente AS c WHERE c.CodCliente IN
(SELECT p.CodCliente FROM pedido AS p WHERE YEAR (p.DataPedido)='2015')
ORDER BY c.nome ASC; /*OK*/

/*2). Lista: 1*/

/*) Mostre o nome do produto e seu valor unitário. Somente devem ser exibidos os produtos que tiveram pelo menos 5 e no máximo 7 itens em um único pedido. 
Ordene em ordem decrescente pelo valor unitário dos produtos. */

SELECT Descricao, ValorUnitario FROM produto WHERE codproduto IN 

(SELECT CodProduto FROM


 (SELECT CodPedido, CodProduto, SUM(quantidade) AS total FROM itempedido
GROUP BY CodPedido, CodProduto) TEMP 

WHERE total>=5 OR total<=7)



ORDER BY ValorUnitario DESC;


 
/*3). Lista: 1*/

/*Mostre a quantidade de pedidos dos clientes que moram no RS ou em SC. */

SELECT COUNT(Quantidade) AS total FROM pedido WHERE CodCliente IN 
(SELECT CodCliente FROM cliente WHERE Uf like 'RS' OR 'SC');


/*4). Lista: 1*/
/*4) Mostre o código do produto, o nome e o valor unitário dos produtos que possuam pedidos para serem entregues entre os dias 01/12/2014 e 31/01/2015. 
Ordene a lista pelo valor unitário decrescente dos produtos. */


use compubras;

select produto.CodProduto, produto.Descricao, produto.ValorUnitario from produto
 
 where produto.CodProduto in /*FEZ UMA SUBCONSULTA*/

 (select itempedido.CodProduto from itempedido where itempedido.CodPedido in  /*FEZ OUTRA SUBCONSULTA*/
 
 (select pedido.CodPedido from pedido where pedido.DataEntrega between '2015-31-01' and '2014-01-12')) 
 
 order by produto.ValorUnitario desc; 
 


/*5) Exiba os dados dos clientes que fizeram pedidos com mais de 60 itens, 
observe que esta é a quantidade total de itens, independentemente de serem produtos iguais ou diferentes. */

SELECT c.* FROM cliente c INNER JOIN pedido p ON p.codcliente = c.codcliente /*APENAS INNEER JOIN*/

WHERE p.codpedido /*FEZ UMA SUBCONCULTA*/
IN (SELECT ip.codpedido AS total FROM itempedido ip GROUP BY ip.codpedido HAVING SUM(ip.quantidade) > 60 ); 



/*6). Lista: 1*/
/*?*/

/* Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus pedidos ordenados pelo nome e posteriormente pelo código do pedido. 
Somente devem ser exibidos os pedidos dos vendedores que possuem a faixa de comissão “A”.*/


select cliente.CodCliente, cliente.Nome, temp2.codpedido from cliente inner join 


(select pedido.CodCliente, pedido.CodPedido as codpedido from pedido inner join 

(select vendedor.CodVendedor as codvendedor from vendedor where vendedor.FaixaComissao = "A") as temp 

on pedido.CodVendedor = temp.codvendedor) as temp2 


on cliente.CodCliente = temp2.codcliente order by cliente.CodCliente;




/*7) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP, código do pedido e prazo de entrega dos pedidos 
que NÃO sejam de vendedores que ganham menos de R$ 1500,00. */

 use compubras;

SELECT cliente.Nome, cliente.Endereco, cliente.Cidade, cliente.uf,cliente.Cep, temp.codpedido, temp.prazoentrega from cliente inner join 

(select codcliente, codpedido, prazoentrega from pedido where CodVendedor not in 

(select codvendedor from vendedor where salariofixo >= 1500)) temp on cliente.CodCliente= temp.codCliente; 
/*?*/



/*8) Crie uma consulta que exiba o nome do cliente, cidade e estado, dos clientes que fizeram algum pedido no ano de 2015. 
Ordene os resultados pelos nomes dos clientes em ordem alfabética.*/

SELECT cliente.nome, cliente.cidade, cliente.uf FROM Cliente WHERE CodCliente IN 
(SELECT Codcliente FROM pedido where year(Datapedido)=2015)
ORDER BY nome;






/*9) Crie uma consulta que exiba o código do pedido e o somatório da quantidade de itens desse pedido. 
Devem ser exibidos somente os pedidos em que o somatório das quantidades de itens de um pedido seja maior que a média da quantidade de itens de todos os pedidos*/


1) codpedido, somatoria da quantidade;
2) somatoria da quantidade>a média da quantidade;





use compubras;

 select temp2.codpedido, temp2.quantidade from (select itempedido.CodPedido as codpedido, sum(itempedido.Quantidade) as quantidade from 
 itempedido group by itempedido.CodPedido) as temp2 where temp2.quantidade >
 any(select avg(temp.quantidade) from (select sum(itempedido.Quantidade) as quantidade from itempedido group by itempedido.CodPedido) as temp); 


/*10) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu último pedido e o estado do cliente.
 Devem ser exibidos apenas os clientes do Rio Grande do Sul e apenas o último vendedor*/



select p.codpedido as pedido, c.Nome as NomeCliente, c.uf as EstadoCliente, v.nome as NomeVendedor, max(p.DataPedido) as DataPedido from pedido p 
inner join vendedor v on v.CodVendedor = p.CodVendedor inner join 
cliente c on p.CodCliente = c.CodCliente where c.Codcliente in 
(select c.codcliente from cliente c where c.uf like "RS") 
group by p.CodCliente order by p.codpedido; 
 
 
 
 




