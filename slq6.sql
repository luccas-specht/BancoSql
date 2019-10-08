

/*EVENTOS*/


/* 1) O valor unitário dos produtos está em reais. Porém, a empresa utiliza o dólar como moeda-base.
O procedimento armazenado atualiza_preco() atualiza os valores unitários a partir do valor do dólar
do dia anterior. Faça um evento que executa o atualiza_preco(), de segunda a sexta, às 7h. */

# É PRECISO CRIAR UM PRA CADA DIA DA SEMANA. É ISSO OU FAZER GAMBIARRA, E NÃO TÔ AFIM KK
# COLOQUEI O STARTS NUMA SEGUNDA, NUMA TERÇA, NUMA QUARTA, ETC. E A CADA 1 SEMANA ELE EXECUTA

# SEGUNDA-FEIRA

CREATE EVENT Questao1_segunda ON SCHEDULE
EVERY 1 WEEK STARTS '2019-09-23 07:00:00'
ON COMPLETION PRESERVE
DO
CALL atualiza_preco();

# TERÇA-FEIRA
CREATE EVENT Questao1_terca ON SCHEDULE
EVERY 1 WEEK STARTS '2019-09-24 07:00:00'
ON COMPLETION PRESERVE
DO
CALL atualiza_preco();

# QUARTA-FEIRA
CREATE EVENT Questao1_quarta ON SCHEDULE
EVERY 1 WEEK STARTS '2019-09-25 07:00:00'
ON COMPLETION PRESERVE
DO
CALL atualiza_preco();

# QUINTA-FEIRA

CREATE EVENT Questao1_quinta ON SCHEDULE
EVERY 1 WEEK STARTS '2019-09-26 07:00:00'
ON COMPLETION PRESERVE
DO
CALL atualiza_preco();
   
# SEXTA-FEIRA
   
    CREATE EVENT Questao1_sexta ON SCHEDULE
EVERY 1 WEEK STARTS '2019-09-27 07:00:00'
ON COMPLETION PRESERVE
DO
CALL atualiza_preco();
  
  
  
  
  
  
  
  
  
/* 2) Crie um evento que realiza o backup do compubrás, todo dia, às 0h, através do procedimento
armazenado backup_diário(), outro evento que realiza o backup todo domingo, às 0h, através do
procedimento backup_semanal(). */


CREATE EVENT Questao2_Backup_Diario ON SCHEDULE
EVERY 1 DAY STARTS '2019-09-23 00:00:00'
ON COMPLETION PRESERVE
DO
CALL backup_diário();

CREATE EVENT Questao2_backup_semanal ON SCHEDULE
EVERY 1 WEEK STARTS '2019-09-29 00:00:00'
ON COMPLETION PRESERVE
DO
CALL backup_semanal();










/* 3) Existem algumas datas especiais para o compubrás, onde é dado um desconto nesse dia. Para
isso, crie um evento que executa o procedimento armazenado aplica_desconto(int desconto),
responsável por atualizar o preço dos produtos com o desconto na visão que disponibiliza os preços
com ou sem desconto. Este ano, será dado um desconto de 50% no black friday, 10% de desconto
no natal, e 20% de desconto no aniversário da empresa, que ocorre daqui a duas semanas. Crie um
evento para cada data. */

# Black-Fraude

CREATE EVENT questao3_black_friday_discount ON SCHEDULE
AT '2019-11-29 00:00:00' ON COMPLETION PRESERVE
DO
CALL aplica_desconto(50);
   
# Christimas!!!

CREATE EVENT questao3_christimas_discount ON SCHEDULE
AT '2019-12-25 00:00:00' ON COMPLETION PRESERVE
DO
CALL aplica_desconto(10);
   
# Company's Birthday!

CREATE EVENT questao3_company_birthday_discount ON SCHEDULE
AT NOW() + INTERVAL 2 WEEK ON COMPLETION PRESERVE
DO
CALL aplica_desconto(20);










   
/* 4) Todo dia 5 é realizado o pagamento dos vendedores. Realize um evento que execute o
procedimento pagar_vendedores(). */

# Jeito "complicado"
DROP EVENT questao4;
CREATE EVENT questao4 ON SCHEDULE
EVERY 1 MONTH STARTS NOW() - INTERVAL DAY(NOW()) DAY + INTERVAL 1 MONTH + INTERVAL 5 DAY - INTERVAL CURRENT_TIME HOUR_SECOND
ON COMPLETION PRESERVE
DO
CALL pagar_vendedores();
   
SELECT NOW() - INTERVAL CURRENT_TIME HOUR_SECOND;
# Jeito "simples"
CREATE EVENT questao4_ ON SCHEDULE
EVERY 1 MONTH STARTS '2019-10-05 00:00:00' ON COMPLETION PRESERVE
DO
CALL pagar_vendedores();
   
/* 5) Entre os dias 5 e 7 deste mês ocorre o dia do gamer, onde a cada dia o compubrás dará 30% de
desconto em um produto. A cada dia o produto muda. Crie um evento que executa diariamente, às
00:01, o procedimento armazenado aplicar_desconto(), responsável por escolher um produto e
aplicar o desconto. */

# Vou dividir em três eventos, porque não dá pra fazer em um só. Teria que ter um comando "ENDS",
# mas desconheço isso. Tipo, every 1 day não dá porque ele repetiria todos os dias, não só nos dias
# 5, 6 e 7. Poderia criar um evento que é acionado no dia 8, sei lá, e apaga os outros, mas aí já é gambiarra...

# Dia 5
CREATE EVENT questao5_dia_1 ON SCHEDULE
AT NOW() - INTERVAL DAY(NOW()) DAY + INTERVAL 1 MONTH + INTERVAL 5 DAY - INTERVAL CURRENT_TIME HOUR_SECOND + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
CALL aplicar_desconto();

# Dia 6
CREATE EVENT questao5_dia_2 ON SCHEDULE
AT NOW() - INTERVAL DAY(NOW()) DAY + INTERVAL 1 MONTH + INTERVAL 6 DAY - INTERVAL CURRENT_TIME HOUR_SECOND + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
CALL aplicar_desconto();

# Dia 7
CREATE EVENT questao5_dia_3 ON SCHEDULE
AT NOW() - INTERVAL DAY(NOW()) DAY + INTERVAL 1 MONTH + INTERVAL 7 DAY - INTERVAL CURRENT_TIME HOUR_SECOND + INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
CALL aplicar_desconto();














/* 6) Na última semana do ano ocorre o recesso da empresa, onde a empresa não realiza vendas. Crie
um evento que, durante a meia noite da segunda dessa semana, execute o procedimento armazenado
ativar_gatilho_recesso(), e crie outro evento que, às 23:59 do domingo dessa mesma semana,
execute o desativar_gatilho_recesso(). */

CREATE EVENT questao6_segunda ON SCHEDULE
AT NOW() - INTERVAL DAYOFYEAR(NOW()) DAY + INTERVAL 1 DAY + INTERVAL 1 YEAR - INTERVAL 1 WEEK - INTERVAL WEEKDAY(NOW()
- INTERVAL DAYOFYEAR(NOW()) DAY + INTERVAL 1 DAY + INTERVAL 1 YEAR) DAY - INTERVAL CURRENT_TIME HOUR_SECOND
ON COMPLETION PRESERVE
DO
CALL ativar_gatilho_recesso();

CREATE EVENT questao6_domingo ON SCHEDULE
AT NOW() - INTERVAL DAYOFYEAR(NOW()) DAY + INTERVAL 1 DAY + INTERVAL 1 YEAR - INTERVAL 1 WEEK - INTERVAL WEEKDAY(NOW()
- INTERVAL DAYOFYEAR(NOW()) DAY + INTERVAL 1 DAY + INTERVAL 1 YEAR) DAY + INTERVAL 6 DAY - INTERVAL CURRENT_TIME HOUR_SECOND
+ INTERVAL 1 DAY - INTERVAL 1 MINUTE
ON COMPLETION PRESERVE
DO
CALL desativar_gatilho_recesso();

SHOW EVENTS;