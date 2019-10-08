/*Lista 1 q1
use compubras;

DELIMITER $$
create function Nome_Mes (x date) returns varchar(255)

begin

case date_format(x, '%m')

when 1 then return '1- Janeiro';

when 2 then return '2- Fevereiro';

when 3 then return '3- Março';

when 4 then return '4- Abril';

when 5 then return '5-Maio';

when 6 then return '6- Junho';

when 7 then return '7 - julho';

when 8 then return '8- agosto';

when 9 then return '9- Setembro';

when 10 then return '10-Outubro';

when 11 then return '11- Novembro';

when 12 then return '12- dezembro';

end case;
end$$

DELIMITER ;

select Nome_Mes(datapedido) from pedido; */





/*lista 1 q2

DELIMITER $$
drop function if exists nome_pt;
CREATE FUNCTION nome_pt (x DATE) RETURNS VARCHAR(255)
BEGIN
CASE DATE_FORMAT(x, '%a')
WHEN 'Sun' then return '0-domingo';  
WHEN 'Mon' then return '1-segunda'; 
WHEN 'Tue' then return '2-terça'; 
WHEN 'Wed' then return '4-quarta'; 
WHEN 'Thu' then return '5-quinta';
WHEN 'Fri' then return '6-sexta';
WHEN 'Sat' then return '7-sábado';   
END CASE;
END $$
DELIMITER ; 

select nome_pt(datapedido) from pedido;*/







/*lista 1 q3

delimiter $$

create function apelido4 (estado char(2)) returns varchar(50) 

begin

declare resp varchar(50);

case estado 
when 'RS'
then set resp='gaúcho';
return resp;

when 'SC'
then set resp='catarinense';
return resp;

when 'PR'
then set resp=' paranaense';
return resp;

end case;
end $$
delimiter ;


select apelido4('RS'); */



/*lista1 q4


delimiter $$
create function IEformat(ie varchar(12)) returns varchar(13)
 begin
 
 return concat ((substring(ie, 1, 7)), "-", (substring(ie, 8, 9)));
 end$$
delimiter ;

select CodCliente,nome,cep,IEformat(ie) as IE from cliente;*/





/*lista 1q8

delimiter $$
 
 create function salario_ajustado(salario double, comissao double, vendas double) returns double
 
 not deterministic
 
 
 begin
 
 declare salarioTotal double;
 set  salarioTotal = salario + (comissao/100) * vendas;
 return salarioTotal;
 
end$$
delimiter ; 

select vendedor.nome, round(salario_ajustado(vendedor.salarioFixo, 20, coalesce(sum(it.quantidade*pr.valorUnitario),0)),2) as salarioTotal
from vendedor left join pedido on vendedor.CodVendedor=pedido.CodVendedor
left join itempedido it on pedido.CodPedido = it.codpedido left join produto pr on it.codproduto = pr.codproduto
group by vendedor.codvendedor order by salarioTotal desc; */





DELIMITER $$
	CREATE FUNCTION getBhaskara(A INT, B INT, C INT) RETURNS VARCHAR(255)
    deterministic
    BEGIN
        DECLARE X FLOAT;
        DECLARE Y FLOAT;
        DECLARE Delta FLOAT;
     categoria   
        SET Delta = sqrt((B*B) - 4 * A * C);
        
        IF Delta >= 0 THEN 
        
        SET X = (-B + Delta) / (2 * A);
        SET Y = (-B - Delta) / (2 * A);
        
        RETURN CONCAT("Os resultados calculados são ", X , " e ", Y);
        
        ELSE RETURN "Raizes não reais";
        
        END IF;
	END$$
DELIMITER ;

SELECT getBhaskara(4, -4, -1);




