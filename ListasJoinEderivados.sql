
1) Mostre o nome dos Clientes e seu endereço completo, dos clientes que realizaram um pedido no ano de 2015. ordene pela ordem alfabética. 
 
select cliente.nome, cliente.Endereco, cliente.Cidade, cliente.Uf, cliente.Cep from cliente where cliente.CodCliente in (select pedido.CodCliente from pedido where year(pedido.DataPedido) = 2015) order by cliente.Nome asc; 
 
2) Mostre o nome do produto e seu valor unitário. Somente devem ser exibidos os produtos que tiveram pelo menos 5 e no máximo 7 itens em um único pedido. Ordene em ordem decrescente pelo valor unitário dos produtos. SELECT Descricao, ValorUnitario FROM produto WHERE CodProduto IN (SELECT CodProduto FROM (SELECT CodPedido, CodProduto, SUM(Quantidade) as total from itempedido group by CodPedido, CodProduto) temp WHERE total >= 5 AND total <= 7)  ORDER BY ValorUnitario DESC; 
 
3) Mostre a quantidade de pedidos dos clientes que moram no RS ou em SC. 
 
select count(CodCliente) as total from pedido where CodCliente in (select CodCliente from cliente where Uf like 'RS' or 'SC'); 
 
4) Mostre o código do produto, o nome e o valor unitário dos produtos que possuam pedidos para serem entregues entre os dias 01/12/2014 e 31/01/2015. Ordene a lista pelo valor unitário decrescente dos produtos. 
 
select produto.CodProduto, produto.Descricao, produto.ValorUnitario from produto where produto.CodProduto in (select itempedido.CodProduto from itempedido where itempedido.CodPedido in (select pedido.CodPedido from pedido where pedido.DataEntrega between '2015-31-01' and '2014-01-12')) order by produto.ValorUnitario desc; 
 
5) Exiba os dados dos clientes que fizeram pedidos com mais de 60 itens, observe que esta é a quantidade total de itens, independentemente de serem produtos iguais ou diferentes. 
 
select c.* from cliente c inner join pedido p on p.codcliente = c.codcliente where p.codpedido in (select ip.codpedido as total from itempedido ip group by ip.codpedido having sum(ip.quantidade) > 60 ); 
 
6) Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus pedidos ordenados pelo nome e posteriormente pelo código do pedido. Somente devem ser exibidos os pedidos dos vendedores que possuem a faixa de comissão “A”. 
 
select cliente.CodCliente, cliente.Nome, temp2.codpedido from cliente inner join (select pedido.CodCliente, pedido.CodPedido as codpedido from pedido inner join (select vendedor.CodVendedor as codvendedor from vendedor where vendedor.FaixaComissao = "A") as temp on pedido.CodVendedor = temp.codvendedor) as temp2 on cliente.CodCliente = temp2.codcliente order by cliente.CodCliente; 
 
7) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP , código do pedido e prazo de entrega dos pedidos que NÃO sejam de vendedores que ganham menos de R$ 1500,00. 
 
SELECT cliente.Nome, cliente.Endereco, cliente.Cidade,cliente.Cep, temp.codpedido, temp.prazoentrega  from cliente inner join (select codcliente, codpedido, prazoentrega from pedido where CodVendedor not in (select codvendedor from vendedor where salariofixo >= 1500)) temp on cliente.CodCliente= temp.codCliente; 
 
 
8) Crie uma consulta que exiba o nome do cliente, cidade e estado, dos clientes que fizeram 

 algum pedido no ano de 2015. Ordene os resultados pelos nomes dos clientes em ordem alfabética. 
 
SELECT nome, cidade, uf FROM cliente WHERE codCliente IN (SELECT codCliente FROM pedido WHERE YEAR(dataPedido) = 2015) ORDER BY nome; 
 
9) Crie uma consulta que exiba o código do pedido e o somatório da quantidade de itens desse pedido. Devem ser exibidos somente os pedidos em que o somatório das quantidades de itens de um pedido seja maior que a média da quantidade de itens de todos os pedidos. 
 
select temp2.codpedido, temp2.quantidade from (select itempedido.CodPedido as codpedido, sum(itempedido.Quantidade) as quantidade from itempedido group by itempedido.CodPedido) as temp2 where temp2.quantidade > any(select avg(temp.quantidade) from (select sum(itempedido.Quantidade) as quantidade from itempedido group by itempedido.CodPedido) as temp); 
 
10) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu último pedido e o estado do cliente. Devem ser exibidos apenas os clientes do Rio Grande do Sul e apenas o último vendedor. 
 
select p.codpedido as pedido, c.Nome as NomeCliente, c.uf as EstadoCliente, v.nome as NomeVendedor, max(p.DataPedido) as DataPedido from pedido p inner join vendedor v on v.CodVendedor = p.CodVendedor inner join cliente c on p.CodCliente = c.CodCliente where c.Codcliente in (select c.codcliente from cliente c where c.uf like "RS") group by p.CodCliente order by p.codpedido; 
 
11) Selecione o nome do produto e o valor unitário dos produtos que possuem o valor unitário maior que todos os produtos que comecem com a letra L. A lista deve ser ordenada em ordem alfabética. 
 
SELECT produto.descricao, produto.valorunitario FROM produto WHERE valorunitario > ALL(SELECT valorunitario FROM produto WHERE descricao like 'L%') ORDER BY descricao; 
 
12) Selecione o código do produto, o nome do produto e o valor unitário dos produtos que possuam pelo menos um pedido com mais de 9 itens em sua quantidade. A lista deve ser ordenada pelo valor unitário em ordem decrescente. 
 
select p.codproduto, p.descricao as nome, p.valorunitario valor_unitario from produto p where p.codproduto in (select codproduto from  (Select codPedido, Codproduto, sum(quantidade) as total from itempedido group by codPedido, codProduto) temp where total>9); 
 
13) Selecione o código do vendedor e o nome dos vendedores que não tenham vendido nenhum pedido com prazo de entrega em Agosto de 2015. A lista deve ser ordenada pelo nome dos vendedores em ordem alfabética. 
 
select vendedor.CodVendedor, vendedor.Nome from vendedor where vendedor.CodVendedor in (select pedido.CodVendedor from pedido where pedido.PrazoEntrega NOT IN (SELECT pedido.PrazoEntrega FROM pedido where month(pedido.PrazoEntrega) = 8 and year(pedido.PrazoEntrega) = 2015)) order by vendedor.Nome asc; 
 
14) Selecione o código do cliente e o nome dos clientes que tenham feitos pedidos em Abril de 2014. A lista deve ser ordenada pelo nome dos clientes em ordem alfabética 
 
SELECT CodCliente, Nome FROM cliente WHERE CodCliente IN (SELECT CodCliente FROM pedido WHERE MONTH(DataPedido)= 4 AND YEAR(DataPedido) = 2014) GROUP BY CodCliente ORDER BY Nome; 
 

 LISTA 2 
 
1) Crie uma consulta que exiba o código do cliente, o nome do cliente e o número dos seus pedidos ordenados pelo nome e posteriormente pelo código do pedido. Somente devem ser exibidos os pedidos dos vendedores que possuem a faixa de comissão “A”. 
 
SELECT temp.CodCliente, cliente.Nome, temp.CodPedido FROM cliente INNER JOIN (SELECT CodCliente,CodPedido FROM pedido WHERE CodVendedor IN  (SELECT CodVendedor FROM vendedor WHERE FaixaComissao = 'A')) temp ON temp.CodCliente = cliente.CodCliente  ORDER BY cliente.Nome,temp.CodPedido; 
 
2) Crie uma consulta que exiba o nome do cliente, endereço, cidade, UF, CEP, código do pedido e prazo de entrega dos pedidos que NÃO sejam de vendedores que ganham menos de R$ 1500,00. 
 
SELECT nome, endereco, cidade, uf, cep, codpedido, prazoentrega from cliente inner join pedido on cliente.codcliente = pedido.codcliente where codvendedor in  (SELECT codvendedor from vendedor where salariofixo >= 1500)) 
 
3) Crie uma consulta que exiba o nome do cliente, cidade e estado, dos clientes que fizeram algum pedido no ano de 2015. Ordene os resultados pelos nomes dos clientes em ordem alfabética. 
 
SELECT nome, cidade, uf FROM cliente WHERE codcliente IN(SELECT codcliente FROM pedido WHERE YEAR(datapedido) = 2015) ORDER BY nome ASC; 
 
4) Crie uma consulta que exiba o código do pedido e o somatório da quantidade de itens desse pedido. Devem ser exibidos somente os pedidos em que o somatório das quantidades de itens de um pedido seja maior que a média da quantidade de itens de todos os pedidos. 
 
SELECT temp2.CodPedido, temp2.total FROM (SELECT CodPedido, SUM(quantidade) as total FROM itempedido GROUP BY CodPedido) temp2 WHERE temp2.total > (SELECT AVG(total) AS media FROM (SELECT CodPedido, SUM(quantidade) AS total FROM itempedido GROUP BY CodPedido) temp) ORDER BY temp2.CodPedido; 
 
5) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu último pedido e o estado do cliente. Devem ser exibidos apenas os clientes do Rio Grande do Sul e apenas o último vendedor. 
 
 
6) Crie uma consulta que exiba o nome do cliente, o nome do vendedor de seu primeiro pedido e o estado do cliente. Devem ser exibidos apenas os clientes de Santa Cataria e apenas o primeiro vendedor. 
 
select cliente.Nome,cliente.uf,vendedor.Nome as vNome from  (select pedido.CodCliente,pedido.CodVendedor from (select CodCliente, min(DataPedido) as ultimo from pedido group by CodCliente) temp  inner join pedido on pedido.CodCliente = temp.CodCliente where ultimo = pedido.DataPedido) temp2  inner join cliente on cliente.CodCliente = temp2.CodCliente inner join vendedor on vendedor.CodVendedor = temp2.codVendedor where cliente.UF like 'RS' order by cliente.Nome; 
 
7) Selecione o nome do produto e o valor unitário dos produtos que possuem o valor unitário maior que todos os produtos que comecem com a letra L. A lista deve ser ordenada em ordem alfabética. 

 SELECT descricao, valorUnitario FROM produto WHERE valorUnitario >  (SELECT MAX(valorUnitario) FROM produto WHERE descricao LIKE 'L%') ORDER BY descricao ASC; 
 
8) Selecione o código do produto, o nome do produto e o valor unitário dos produtos que possuam pelo menos um pedido com mais de 9 itens em sua quantidade. A lista deve ser ordenada pelo valor unitário em ordem decrescente. 
 
SELECT CodProduto, descricao, ValorUnitario FROM produto WHERE CodProduto IN (SELECT CodProduto from (SELECT CodPedido, CodProduto, SUM(quantidade) as total from itempedido group by CodPedido, CodProduto) temp where total > 9) ORDER BY ValorUnitario DESC; 
 
9) Selecione o código do vendedor e o nome dos vendedores que não tenham vendido nenhum pedido com prazo de entrega em Agosto de 2015. A lista deve ser ordenada pelo nome dos vendedores em ordem alfabética. 
 
SELECT CodVendedor, Nome FROM vendedor WHERE CodVendedor NOT IN  (SELECT CodVendedor FROM pedido WHERE MONTH(PrazoEntrega)=08 AND YEAR(PrazoEntrega)=2015)  ORDER BY Nome; 
 
10) Selecione o código do cliente e o nome dos clientes que tenham feitos pedidos em Abril de 2014. A lista deve ser ordenada pelo nome dos clientes em ordem alfabética 
 
SELECT CodCliente, Nome FROM cliente WHERE CodCliente in (SELECT Codcliente FROM pedido WHERE MONTH(Datapedido) = 4 AND YEAR(Datapedido) = 2014) ORDER BY Nome ASC; 

 LISTA 3 1) Exiba o nome, endereço, cidade e o CEP dos clientes que moram em Santa Catarina e que tenham pelo menos um pedido feito onde o prazo de entrega é entre 16 e 20 dias. 
 
2) Exiba o nome, endereço, cidade e o CEP dos clientes que moram no Rio Grande do Sul e tenham pedidos realizados por algum vendedor que tenha o nome iniciando com a letra A. Além disso deve ser exibido apenas os clientes que tiveram pedidos no ano de 2015. A lista deve estar ordenada em ordem alfabética e sem clientes repetidos. 
 
SELECT Nome, Endereco, Cidade, Cep FROM Cliente WHERE Uf = 'RS' AND CodCliente IN ( SELECT CodCliente FROM Pedido WHERE YEAR(DataPedido) = 2015 AND CodVendedor IN ( SELECT CodVendedor FROM Vendedor WHERE Nome LIKE 'A%')) GROUP BY Nome ORDER BY Nome ASC; 
 
3) Exiba o nome, salário e a faixa de comissão dos vendedores que recebem mais que R$ 1800,00 que tenham realizado algum pedido em Dezembro de 2014 para clientes que moram ou em Santa Catarina ou no Rio Grande do Sul. (2 sub-consultas) 
 
SELECT v.Nome, v.SalarioFixo, v.FaixaComissao FROM vendedor v  INNER JOIN pedido p ON v.codvendedor = p.codvendedor WHERE (v.SalarioFixo) >= 1800 AND p.codpedido  IN (SELECT p.codpedido FROM pedido p WHERE MONTH(p.datapedido) = 12 AND YEAR(p.datapedido) = 2014  AND p.codcliente IN (SELECT c.codcliente FROM cliente c WHERE c.uf = 'SC' OR c.uf = 'RS'))  ORDER BY v.CodVendedor; 
 
4) Exiba um ranking contendo o nome e o total de vendas efetuadas por vendedor durante o ano de 2015. Note que não devem aparecer vendedores que efetuaram nenhuma venda no ano. 
 
SELECT vendedor.nome, COUNT(pedido.codvendedor) AS Total FROM vendedor INNER JOIN pedido ON vendedor.codvendedor=pedido.Codvendedor WHERE pedido.codpedido IN (SELECT pedido.codpedido FROM pedido WHERE YEAR(pedido.datapedido)=2015) GROUP BY vendedor.codvendedor ORDER BY Total DESC; 
 
5)  
 
6) Exiba o nome e a comissão dos vendedores. A consulta externa deverá ser na tabela vendedor e existem duas sub-consultas (uma dentro da outra). A lista deve ser ordenada pelo valor das comissões. Além disso, as comissões devem ter o valor exibido arredondado (2 números depois da vírgula), a comissão para todos os vendedores é 10% do total vendido. 
 
Select nome, round(coalence(comissao*0.1,0),2) as comissao_dos_vendedores from vendedor left join (Select codVendedor, SUM(total) as comissao from pedido inner join (SELECT codPedido, SUM(quantidade*valorunitario) as total from itempedido inner join produto ON itempedido.codProduto = produto.codProduto group by codPedido) temp on pedido.codPedido = temp.codPedido group by codVendedor) temp2 on vendedor.codVendedor = temp2.codVendedor order by comissao_dos_vendedores;  
 
7) Exiba um ranking com o nome do cliente e o total comprado por este cliente no ano de 2015. Os clientes que devem integrar o ranking devem morar no Rio Grande do Sul ou em Santa Catarina. Além disso, o total devem ter o valor exibido arredondado (2 números depois da vírgula). A consulta externa é em cliente. 
 
Select nome, round(coalence(total_parcial,0),2) as total_comprado from cliente left join (Select codCliente, SUM(total) as total_parcial from pedido inner join (SELECT codPedido, SUM(quantidade*valorunitario) as total from itempedido inner join produto ON itempedido.codProduto = produto.codProduto group by codPedido) temp on pedido.codPedido = temp.codPedido where YEAR(pedido.dataPedido) = 2015 group by codCliente) temp2 on cliente.codCliente = temp2.codCliente where uf=”RS” OR uf=”SC”; 

 
 
8) Exiba um ranking com o nome do vendedor e o total vendido por ele no ano de 2014. Além disso, o total devem ter o valor exibido arredondado (2 números depois da vírgula). A consulta externa é em vendedor. 
 
Select nome, round(coalence(comissao*0.1,0),2) as comissao_dos_vendedores from vendedor left join (Select codVendedor, SUM(total) as comissao from pedido inner join (SELECT codPedido, SUM(quantidade*valorunitario) as total from itempedido inner join produto ON itempedido.codProduto = produto.codProduto group by codPedido) temp on pedido.codPedido = temp.codPedido where YEAR(pedido.dataPedido) = 2014 group by codVendedor) temp2 on vendedor.codVendedor = temp2.codVendedor order by comissao_dos_vendedores;  
 
9) Exiba o código do produto, nome e a quantidade vendida dos produtos que tiveram pedidos entre os dias 12/08/2014 e 27/10/2014. Os resultados devem ser ordenados pela quantidade e a consulta externa é na tabela produto. 
 
Select produto.codProduto, produto.descricao, total from produto inner join (Select codProduto, coalence(sum(quantidade),0) as total from itempedido where codPedido in (select codPedido from pedido where dataPedido between ’2014-12-08’ and ‘2014-10-27’) group by codProduto) temp on produto,codProduto=temp.codProduto; 
 
 
10) Crie uma consulta que retorne o nome do cliente e o total comprado por este no ano de 2014 e no ano de 2015. A consulta também deve retornar o saldo da diferença entre o total comprado no ano de 2015 e o total de 2014, ordenada por este saldo. Não preocupe-se com os saldos que por eventualidade possuam o valor null. DICA: a sub-consulta será no lugar de uma tabela, ademais podem haver várias sub-consultas para as colunas desta tabela. 
 
Select nome, total_2014, total_2015 from cliente left join (Select codCliente, round(coalence(SUM(total),0,2) as total_2015 from pedido inner join (SELECT codPedido, SUM(quantidade*valorunitario) as total from itempedido inner join produto ON itempedido.codProduto = produto.codProduto group by codPedido) temp on pedido.codPedido = temp.codPedido where YEAR(pedido.dataPedido) = 2015 group by codCliente) temp2 on cliente.codCliente = temp2.codCliente left join (Select codCliente, round(coalence(SUM(total),0,2) as total_2014 from pedido inner join (SELECT codPedido, SUM(quantidade*valorunitario) as total from itempedido inner join produto ON itempedido.codProduto = produto.codProduto group by codPedido) temp3 on pedido.codPedido = temp3.codPedido where YEAR(pedido.dataPedido) = 2014 group by codCliente) temp4 on cliente.codCliente = temp4.codCliente); 
 
 

 LISTA 4 1) Exiba o código, o nome e o valor unitário dos produtos que tiveram mais que 9 unidades vendidas em apenas um pedido (note que não é o somatório total de unidades vendidas é apenas em um único pedido). 
 
SELECT pr.CodProduto, pr.Descricao, pr.ValorUnitario FROM produto pr WHERE pr.CodProduto IN (SELECT ip.CodProduto FROM itempedido ip WHERE ip.Quantidade > 9) ORDER BY pr.CodProduto; 
 
2) Exiba o código, o nome do cliente, o endereço, a cidade, o cep, o estado e a IE dos clientes que efetuaram pedidos entre 25/09/2014 e 05/10/2015. 
 
SELECT * from cliente WHERE CodCliente in (SELECT CodCliente from pedido WHERE DataPedido BETWEEN ('2014-09-25') and ('2015-10-05')); 
 
3) Exiba o código, o nome do cliente, o endereço, a cidade, o estado e a quantidade de pedidos de todos os clientes ao longo do histórico da loja. Ordene a lista pela quantidade de pedidos efetuados pelos clientes. 
 
 
SELECT c.CodCliente, c.Nome AS NomeCliente, c.endereco, c.cidade, c.cep, c.Uf, COALESCE(temp.TotalPedidoCliente, 0) AS TotalPedidoCliente FROM cliente c LEFT JOIN (SELECT p.CodCliente, COUNT(p.CodPedido) AS TotalPedidoCliente FROM pedido p GROUP BY p.CodCliente) temp ON c.CodCliente = temp.CodCliente; 
 
4) Mostre o código do pedido, a data de entrega, a data do pedido, o código do cliente, o código do vendedor e a quantidade total de unidades em cada pedido. Note que não é necessário diferenciar os produtos. Ordene a lista pela quantidade total de unidades nos pedidos. 
 
SELECT pedido.CodPedido, PrazoEntrega, DataPedido, CodCliente, CodVendedor, COALESCE(temp.produtos, 0) AS produtos FROM pedido LEFT JOIN (SELECT SUM(Quantidade) AS produtos, CodPedido FROM itempedido GROUP BY CodPedido) temp ON pedido.CodPedido = temp.CodPedido ORDER BY produtos DESC; 
 
5) Mostre todos os dados (código, descrição e valor unitário) dos produtos que nunca foram vendidos. Ordene pela ordem alfabética da descrição dos produtos. 
 
SELECT * FROM Produto WHERE CodProduto NOT IN( SELECT CodProduto FROM itempedido)  ORDER BY Descricao ASC; 
 
6) Exiba o código, a descrição, o valor unitário e a quantidade de unidades vendidas de cada produto desde que a loja abriu. Ordene pelo somatório total de unidades vendidas. 
 
SELECT codProduto, descricao, valorUnitario, total from produto inner join (select codProduto, sum(quantidade) as total from itempedido order by codProduto) temp on produto.codProduto=temp.codProduto order by total desc; 
 
 
7) Exiba o código, o nome do cliente, o endereço, a cidade, o cep, o estado e a IE dos clientes que efetuaram pedidos que contenham pelo menos um produto que custe menos de R$ 10,00. 
 
SELECT CodCliente, Nome, Endereco, Cidade, Cep, Ie FROM cliente WHERE CodCliente IN  (SELECT pedido.CodCliente FROM pedido WHERE CodPedido IN (SELECT CodPedido FROM itempedido WHERE itempedido.CodProduto IN  (SELECT produto.CodProduto FROM produto WHERE ValorUnitario < 10.00))) 
 

 
 
8) Mostre os dados (código, nome, salário e faixa de comissão) dos vendedores que venderam algum produto que a descrição inicie com IPHONE 6 PLUS. 
 
SELECT * FROM vendedor WHERE CodVendedor IN( SELECT CodVendedor FROM pedido WHERE CodPedido IN(SELECT CodPedido FROM itempedido WHERE CodProduto IN (SELECT CodProduto FROM produto WHERE Descricao LIKE "IPHONE 6 PLUS%"))); 
 
9) Mostre os dados (código, descrição, valor unitário) dos produtos, bem como a quantidade de pedidos que solicitaram esses produtos. Ordene a lista pela quantidade de pedidos de cada produto (do maior para o menor). 
 
Select produto.codProduto, descricao, valorUnitario, total from produto inner join (select codProduto, count(codPedido) as total from itempedido group by codPedido) temp on produto.codProduto = temp.codProduto; 
 
 
10) Mostre o código, prazo de entrega, data do pedido, código do cliente, do vendedor e o valor total (em reais) de todos os pedidos. Ordene a lista em ordem decrescente pelo valor total. 
 
SELECT P.CodPedido,P.PrazoEntrega,P.DataPedido,P.CodCliente,P.CodVendedor,round( coalence(T.Total,0),2) FROM pedido P inner join (SELECT CodPedido,SUM(ValorUnitario * Quantidade) AS Total FROM itempedido INNER JOIN produto ON produto.CodProduto = itempedido.CodProduto GROUP BY CodPedido) T INNER JOIN pedido P ON T.CodPedido = P.CodPedido ORDER BY Total desc; 
 
11) Crie um ranking contendo o nome dos vendedores e a quantidade total de vendas (total de pedidos) efetuados por cada um os vendedores. Ordene o ranking do vendedor com o maior número de vendas (pedidos vendidos aos clientes) para o que possui o menor total. 
 
Select vendedor.nome, total from vendedor inner join (select codvendedor, count(codPedido) as total from pedido group by codVendedor) temp on vendedor.codvendedor = temp.codvendedor order by total desc; 
 
12) Crie um ranking contendo o nome dos vendedores o valor total gasto por cada cliente na loja. Note que o valor total não é por pedido e sim por cliente (se um cliente efetuou mais de um pedido os valores devem ser somados). Ordene a lista pelo total gasto por cada cliente. 
 
 
13) Mostre os dados dos produtos (código, descrição e valor unitário) bem como a quantidade total de unidades vendidas em 2015 para cada um dos produtos. Ordene a lista pela quantidade total de unidades vendidas. 
 
SELECT produto.codProduto, Descricao, valorunitario, total from produto inner join (select codProduto, sum(quantidade) AS total from itempedido where codPedido in (select codPedido from pedido where year(datapedido) = 2015) group by codProduto) temp on temp.codProduto = produto.codProduto order by total desc; 
 
 
14) Mostre os dados dos produtos (código, descrição e valor unitário), bem como a quantidade de unidades vendidas e o valor total arrecadado com cada produto. A lista deve ser ordenada pelo valor total arrecadado ao longo dos anos. 
 
SELECT produto.codProduto, Descricao, valorUnitario, COALESCE (total,0) as unidades_vendidas, round(COALESCE (total*valorUnitario,0),2) as total_vendido from produto left join  (Select codProduto, SUM(quantidade), 0) as total from itempedido group by codProduto) temp on temp.codProduto = produto.CodProduto order by total_vendido desc; 
 
 

 
 
15) Mostre o nome do vendedor e o valor total vendido por cada um dos vendedores desde que a loja abriu. Ordene a lista pelo valor total vendido (maior para o menor). 
 
Select nome, round(coalence(total,0),2) as total_vendido from vendedor left join (select codvendedor, sum(quantidade*valorunitario) as total from pedido inner join itempedido on pedido.codPedido = itempedido.codPedido inner join produto on produto.codProduto=itempedido.codProduto group by codVendedor) temp on temp.codVendedor = vendedor.codVendedor order by total desc; 
 
 
 
 
 
 
 
 
 
 
 
 
 
 LISTA 5 
 
 
1) Crie uma tabela temporária que contenha os dados de todos os pedidos e de seus vendedores e exiba na consulta principal o código do pedido, data de entrega e o nome do vendedor. LINHAS = 8432. 
 
Select codPedido, dataEntrega, nome from (select * from vendedor inner join pedido on vendedor.codVendedor = pedido.CodVendedor) temp; 
 
2) Crie uma tabela temporária que contenha todos os dados das tabelas pedido e cliente, após exiba na consulta principal apenas o código do pedido, data do pedido e o nome do cliente. Por fim, ordene a lista em ordem cronológica a data do pedido. LINHAS = 8432. 
 
SELECT temp.CodPedido AS pedido, temp.DataPedido AS datap, temp.Nome AS Nome FROM (SELECT c.*, p.CodPedido, p.PrazoEntrega, p.DataPedido, p.CodVendedor  FROM cliente c RIGHT JOIN pedido p ON c.CodCliente = p.CodCliente) temp ORDER BY datap ASC; 
 
3) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, cliente e vendedor. Além disso, na consulta principal exiba os estados cadastrados e a quantidade total de pedidos por estado. LINHAS = 27. SELECT temp.Uf, COALESCE(COUNT(temp.CodPedido), 0) AS TotalPedidosEstado FROM (SELECT p.*, c.Endereco, c.Cidade, c.Cep, c.Uf, c.Ie, v.SalarioFixo, v.FaixaComissao FROM pedido p LEFT JOIN cliente c ON p.CodCliente = c.CodCliente LEFT JOIN vendedor v ON p.CodVendedor = v.CodVendedor) temp GROUP BY temp.Uf ORDER BY TotalPedidosEstado DESC; 4) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, cliente e vendedor. Exiba o ranking dos vendedores pela quantidade de pedidos e ordene em ordem decrescente. LINHAS = 244. 
 
SELECT temp.NomeVendedor, COUNT(temp.codPedido) as quantidade FROM (SELECT pedido.codPedido, pedido.PrazoEntrega, pedido.DataPedido, cliente.codCliente, cliente.Nome, Cliente.Endereco, Cliente.cidade, cliente.cep, cliente.uf, cliente.ie, vendedor.codVendedor, vendedor.Nome as nomeVendedor, vendedor.SalarioFixo, vendedor.FaixaComissao FROM pedido INNER JOIN cliente ON pedido.CodCliente = cliente.CodCliente INNER JOIN vendedor ON pedido.CodVendedor = vendedor.CodVendedor) temp GROUP BY temp.CodVendedor ORDER BY quantidade DESC; 
 
5) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, cliente e vendedor. Exiba o ranking dos clientes pela quantidade de pedidos e ordene em ordem decrescente. LINHAS = 1569. 
 
SELECT nome, COUNT(temp.codcliente) AS ranking FROM cliente INNER JOIN (SELECT p.codcliente, p.codvendedor, p.codpedido, p.datapedido, p.prazoentrega, c.nome AS NomeCliente, c.endereco, c.cidade, c.cep, c.uf, c.ie, v.nome as NomeVendedor, v.salariofixo, v.faixacomissao FROM vendedor v INNER JOIN pedido p ON v.codvendedor = p.codvendedor INNER JOIN cliente c ON p.codcliente = c.codcliente) temp ON cliente.codcliente = temp.codcliente GROUP BY cliente.codcliente ORDER BY ranking DESC; 
 
6) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o código do pedido e o valor total de cada pedido. LINHAS = 6507. 
 
7) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o código do vendedor, o nome do vendedor e o salário deste vendedor para o mês de abril/2016, considerando salário + comissão de 20% sobre as vendas desse vendedor. Note que devem ser exibidos apenas os vendedores pertencentes a faixa de comissão A. LINHAS = 22. Select vendedor.codvendedor, vendedor.nome, vendedor.salariofixo + round(coalence(sum( 

 temp.valorunitario * temp.quantidade) * 0.2),0),2) from vendedor left join (Select * from pedido inner join itempedido on pedido.codpedido = itempedido.codpedido RIGHT join produto on itempedido.codproduto = produto.codproduto) temp on vendedor.codvendedor = temp.codvendedor where vendedor.faixaComissao like “A” group by temp.codVendedor;   
 
8) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o código do cliente, o nome do cliente e o valor gasto por ele durante o ano de 2016. Por fim, ordene a lista pelo total gasto pelo cliente no decorrer do ano (maior -> menor). LINHAS = 621. SELECT cliente.codcliente, cliente.nome, SUM(temp.Quantidade*temp.valorunitario) as valorGasto FROM cliente INNER JOIN (SELECT p.CodPedido, p.CodCliente, p.CodVendedor, p.DataPedido, p.PrazoEntrega, i.CodItemPedido, i.CodProduto, i.Quantidade, pr.Descricao, pr.ValorUnitario FROM pedido p INNER JOIN itempedido i ON p.codpedido = i.codpedido RIGHT JOIN produto pr ON i.codproduto = pr.codproduto) temp ON cliente.codcliente = temp.codcliente WHERE YEAR(temp.datapedido) = 2016 GROUP BY temp.codcliente ORDER BY valorGasto DESC; 
 
9) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o código do produto, o seu nome e a quantidade total vendida no ano de 2015. LINHAS = 2715. Select codProduto, descricao, coalence(sum(quantidade),0) as total from (SELECT p.CodPedido, p.CodCliente, p.CodVendedor, p.DataPedido, p.PrazoEntrega, i.CodItemPedido, i.CodProduto, i.Quantidade, pr.Descricao, pr.ValorUnitario FROM pedido p INNER JOIN itempedido i ON p.codpedido = i.codpedido RIGHT JOIN produto pr ON i.codproduto = pr.codproduto) temp where year(datapedido) = 2015; 
 
10) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o código do vendedor, o nome e o total de pedidos que contenham itens que iniciem com ‘PS4’. LINHAS = 146. 
 
SELECT v.CodVendedor, v.nome, count(TEMP.codPedido) FROM vendedor v INNER JOIN (SELECT it.CodItemPedido, it.Quantidade, pd.*, pr.* FROM pedido pd INNER JOIN itempedido it ON it.CodPedido = pd.CodPedido RIGHT JOIN produto pr ON pr.CodProduto = it.CodProduto) AS TEMP ON v.codVendedor = temp.CodVendedor WHERE temp.descricao LIKE 'PS4%' GROUP BY v.CodVendedor ; 
 
11) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o código do pedido, o código do produto e o valor total (valor total = quantidade * valor unitário) de cada produto em um pedido. Dica: deverão ser utilizados dois campos na clausula group by. LINHAS = 12339. 
 
SELECT codpedido, codproduto, round(coalence(SUM(valorunitario*quantidade),0),2) AS valor_total  FROM (SELECT pe.*, i.coditempedido, i.quantidade, pr.codproduto, pr.descricao, pr.valorunitario FROM pedido pe LEFT JOIN itempedido i ON pe.codpedido = i.codpedido RIGHT JOIN produto pr ON i.codproduto = pr.codproduto) temp GROUP BY codpedido, codproduto ORDER BY codpedido ASC, codproduto ASC; 
 
12) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o ano, o código do cliente, o nome do cliente e o total comprado por este cliente a cada ano. Dica: deverão ser utilizados dois campos na clausula group by. LINHAS = 3905. 
 
SELECT YEAR(temp.dataPedido) AS Ano, c.codCliente as CodCliente, c.nome AS NomeCliente, round(coalence(SUM(temp.valorUnitario*temp.quantidade),0),2) AS ValoTotal FROM cliente c inner join (Select pedido.*, itempedido.coditempedido, itempedido.quantidade, produto.codproduto, produto.descricao, produto.valorunitario from pedido inner join itempedido on pedido.codpedido = itempedido.codpedido right join produto on produto.codproduto = itempedido.codproduto) temp on temp.codcliente = c.codcliente GROUP BY YEAR(temp.dataPedido), c.codCliente ORDER BY Ano; 

 13) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o ano, o código do vendedor, o nome do vendedor e o valor total das vendas a cada ano. Dica:  deverão ser  utilizados dois campos na clausula group by. LINHAS = 968. SELECT YEAR(datapedido) as Ano, v.codvendedor, nome, round(coalence(SUM(valorunitario *quantidade),0),2) as ValorTotal FROM Vendedor v INNER JOIN (SELECT p.CodPedido, p.CodCliente, p.CodVendedor, p.DataPedido, p.PrazoEntrega, i.CodItemPedido, i.CodProduto, i.Quantidade, pr.Descricao, pr.ValorUnitario FROM pedido p INNER JOIN itempedido i ON p.codpedido = i.codpedido RIGHT JOIN produto pr ON i.codproduto = pr.codproduto) temp ON temp.codVendedor = v.codVendedor GROUP BY YEAR(datapedido), codvendedor;
4/29/19, 18:09 - Luccas Specht: LISTA DE JOIN


/*1) Mostrar a quantidade pedida para um determinado produto com um determinado
código a partir da tabela item de pedido.*/

SELECT Pr.CodProduto,SUM(I.Quantidade) AS Total
FROM produto Pr INNER JOIN itempedido I ON Pr.CodProduto = I.CodProduto
GROUP BY Pr.CodProduto
ORDER BY Pr.CodProduto;


/*2) Listar a quantidade de produtos que cada pedido contém.*/
SELECT P.CodPedido,SUM(I.Quantidade) AS Total
FROM pedido P INNER JOIN itempedido I ON P.CodPedido = I.CodPedido
GROUP BY P.CodPedido
ORDER BY P.CodPedido ;

/*3) Ver os pedidos de cada cliente, listando nome do cliente e número do pedido.*/

SELECT C.Nome, P.CodPedido
FROM cliente C INNER JOIN pedido P ON C.CodCliente = P.CodCliente
ORDER BY C.Nome;



/*4) Listar todos os clientes com seus respectivos pedidos. Os clientes que não têm
pedidos também devem ser apresentados.*/

SELECT C.Nome,P.*
FROM cliente C LEFT JOIN pedido P ON C.CodCliente  = P.CodCliente
ORDER BY C.Nome;


/*5) Clientes com prazo de entrega superior a 10 dias e que pertençam aos estados do
Rio Grande do Sul ou Santa Catarina.*/

SELECT DISTINCT(C.Nome),C.Uf -- P.PrazoEntrga --
FROM cliente C INNER JOIN pedido P ON C.CodCliente = P.CodCliente
WHERE DATEDIFF(P.PrazoEntrega,P.DataPedido)> 10 AND C.Uf  = 'RS' OR C.Uf = 'SC'
ORDER BY C.Nome;

/*6) Mostrar os clientes e seus respectivos prazos de entrega, ordenando do maior para
o menor.*/

SELECT C.Nome, P.PrazoEntrega
FROM cliente V INNER JOIN pedido P ON C.CodCliente = P.CodCliente
ORDER BY DATEDIFF(P.PrazoEntrega,P.DataPedido) ;

/*7) Apresentar os vendedores, em ordem alfabética, que emitiram pedidos com prazos
de entrega superiores a 15 dias e que tenham salários fixos iguais ou superiores a
R$ 1.000,00
*/

SELECT DISTINCT(V.Nome),V.SalarioFixo 
FROM vendedor V INNER JOIN pedido P ON V.CodVendedor = P.CodVendedor
WHERE DATEDIFF(P.PrazoEntrega,P.DataPedido)> 15 AND V.SalarioFixo >= 1000
ORDER BY V.Nome;

/*8) Os vendedores têm seu salário fixo acrescido de 20% da soma dos valores dos
pedidos. Faça uma consulta que retorne o nome dos funcionários e o total de
comissão, desses funcionários.*/

SELECT V.Nome,(0.2*SUM(Pr.ValorUnitario*I.Quantidade)) + V.SalarioFixo AS SalarioFinal
FROM vendedor V INNER JOIN pedido P ON V.CodVendedor = P.CodVendedor
INNER JOIN itempedido I ON P.CodPedido = I.CodPedido 
INNER JOIN produto Pr ON I.CodPedido = Pr.CodProduto
GROUP BY V.CodVendedor
ORDER BY SalarioFinal asc;


/*9) Os clientes e os respectivos vendedores que fizeram algum pedido para esse
cliente, juntamente com a data do pedido.*/

SELECT C.Nome AS Cliente, V.Nome AS Vendedor, P.DataPedido
FROM cliente C INNER JOIN pedido P ON C.CodCliente = P.CodCliente
INNER JOIN vendedor V ON V.CodVendedor = P.CodVendedor;

/*10) Liste o nome do cliente e a quantidade de pedidos de cada cliente.*/

SELECT C.Nome,COUNT(P.CodPedido) AS Quantidade
FROM cliente C INNER JOIN pedido P ON C.CodCliente = P.CodCliente
GROUP BY C.Nome
ORDER BY C.Nome;

/*11) Liste o nome do cliente, o código do pedido e a quantidade total de produtos por
pedido.*/

SELECT C.Nome,P.CodPedido,I.Quantidade 
FROM cliente C INNER JOIN pedido P ON C.CodCliente = P.CodCliente
INNER JOIN itempedido I ON P.CodPedido = I.CodPedido;


/*12) Liste o nome do cliente, o código do pedido e o valor total do pedido*/

SELECT C.Nome,P.CodPedido, SUM(I.Quantidade * Pr.ValorUnitario) AS Total
FROM cliente C INNER JOIN pedido P ON C.CodCliente = P.CodCliente
INNER JOIN itempedido I ON P.CodPedido = I.CodPedido
INNER JOIN produto Pr ON Pr.CodProduto = I.CodProduto
GROUP BY P.CodPedido
ORDER BY C.Nome;


/*13) Liste os produtos, a quantidade vendida e a data dos pedidos realizados no mês de
maio de 2015, começando pelos mais vendidos.*/

SELECT Pr.CodProduto,I.Quantidade,P.DataPedido
FROM produto Pr INNER JOIN itempedido I ON Pr.CodProduto = I.CodProduto
INNER JOIN pedido P ON P.CodPedido = I.CodPedido
WHERE MONTH(P.DataPedido) = 5 AND YEAR(P.DataPedido) = 2015 
ORDER BY I.Quantidade desc;


/*14) Liste os produtos, do mais caro para o mais barato, dos pedidos no mês de junho
(considerando todos os anos)*/

SELECT Pr.CodProduto, P.DataPedido
FROM produto Pr INNER JOIN itempedido I ON Pr.CodPrduto = I.CodProduto
INNER JOIN pedido P ON P.CodPedido = I.CodPedido;






8) Crie uma tabela temporária que contenha todos os dados das tabelas pedido, itempedido e produto. Exiba o código do cliente, o nome do cliente e o valor gasto por ele durante o ano de 2016. Por fim, ordene a lista pelo total gasto pelo cliente no decorrer do ano (maior -> menor). LINHAS = 621. SELECT cliente.codcliente, cliente.nome, SUM(temp.Quantidade*temp.valorunitario) as valorGasto FROM cliente INNER JOIN (SELECT p.CodPedido, p.CodCliente, p.CodVendedor, p.DataPedido, p.PrazoEntrega, i.CodItemPedido, i.CodProduto, i.Quantidade, pr.Descricao, pr.ValorUnitario FROM pedido p INNER JOIN itempedido i ON p.codpedido = i.codpedido RIGHT JOIN produto pr ON i.codproduto = pr.codproduto) temp ON cliente.codcliente = temp.codcliente WHERE YEAR(temp.datapedido) = 2016 GROUP BY temp.codcliente ORDER BY valorGasto DESC; 
