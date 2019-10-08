

/*11 lista 2*/

Delimiter ##


Create function sumUfY (estado char(255)) returns char(255)
not deterministic

begin

declare resp char(255);

CASE

	when estado='AC'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'AC');
    return resp;
    
    when estado='Al'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'Al');
    return resp;
    
    when estado='AP'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'AP');
    return resp;
	
    
    when estado='AM'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= "AM");
    return resp;
    
    when estado='BA'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'BA');
    return resp;
    
    when estado='CE'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'CE');
    return resp;
    
    
    when estado='DF'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'DF');
    return resp;
    
    when estado='ES'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'ES');
    return resp;
    
    
    when estado='GO'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'GO');
    return resp;
    
    
    when estado='MA'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'MA');
    return resp;
    
    when estado='MT'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'MT');
    return resp;
    
    when estado='MS'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'MS');
    return resp;
	
    
    when estado='MG'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'MG');
    return resp;
    
    when estado='PA'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'PA');
    return resp;
    
    when estado='PB'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'PB');
    return resp;
    
    
    when estado='PR'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'PR');
    return resp;
    
    when estado='PE'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'PE');
    return resp;
    
    when estado='PI'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'PI');
    return resp;
	
    
    when estado='RJ'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'RJ');
    return resp;
    
    when estado='RN'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'RN');
    return resp;
    
    when estado='RS'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'RS');
    return resp;
    
	when estado='RO'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'RO');
    return resp;
    
    when estado='RR'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'RR');
    return resp;
    
    when estado='SC'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'SC');
    return resp;
    
	when estado='SP'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'SP');
    return resp;
    
	when estado='SE'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'SE');
    return resp;
    
	when estado='TO'
    then set resp = (select sum(i.quantidade), c.Uf from itempedido as i inner join cliente as c  on i.CodItemPedido=c.CodCliente
    where c.Uf= 'TO');
    return resp;
    
    
end case;
end##
Delimiter ; 

select sumUfY('rs'); 







 
    
    
    
    
    
    
    
    
    