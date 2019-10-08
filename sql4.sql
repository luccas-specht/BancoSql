/*GATILHOS*/


/*1  Faça um gatilho que só permita cadastrar clientes onde a UF seja válida.*/

DELIMITER $$
									/*timing*//*operação*/ 
CREATE TRIGGER utr_Cadastra_UF_valida BEFORE INSERT
ON cliente
FOR EACH ROW
BEGIN


END$$


DELIMITER $$
CREATE TRIGGER Ex1 BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
SET @fuf = new.Uf ;
IF(@fuf != 'RS' AND @fuf != 'SC' AND @fuf != 'SP' AND @fuf != 'RJ' AND @fuf != 'RR' AND @fuf != 'GO' AND @fuf != 'MS' AND
@fuf != 'SE' AND @fuf != 'AP' AND @fuf != 'AC' AND @fuf != 'AL' AND @fuf != 'AM' AND @fuf != 'BA' AND @fuf != 'CE' AND
@fuf != 'DF' AND @fuf != 'ES' AND @fuf != 'MA' AND @fuf != 'MG' AND @fuf != 'MT' AND @fuf != 'PA' AND @fuf != 'PB' AND
@fuf != 'PE' AND @fuf != 'PI' AND @fuf != 'PR' AND @fuf != 'RN' AND @fuf != 'RO' AND @fuf != 'TO' )THEN
SET new.Uf = NULL;
END IF ;
END $$
DELIMITER ;

DROP TRIGGER Ex1;





INSERT INTO `cliente` VALUES (1577,'Laura Gomena','95997  Cuba Blvd.','Warrek','46876','RS','318589545');

SELECT Uf FROM cliente GROUP BY Uf;





/2) Faça um gatilho que não permita atualizar a UF do cliente, caso a UF não seja válida./

DELIMITER $$
CREATE TRIGGER Ex2 BEFORE INSERT ON cliente
FOR EACH ROW
BEGIN
SET @fuf = new.Uf ;
IF(@fuf = 'RS' OR @fuf = 'SC' OR @fuf = 'SP' OR @fuf = 'RJ'  OR @fuf = 'RR'  OR @fuf = 'GO'  OR @fuf = 'MS'  OR
@fuf = 'SE'  OR @fuf = 'AP'  OR @fuf = 'AC'  OR @fuf = 'AL'  OR @fuf = 'AM'  OR @fuf = 'BA' OR @fuf = 'CE' OR
@fuf = 'DF'  OR @fuf = 'ES'  OR @fuf = 'MA'  OR @fuf = 'MG'  OR @fuf = 'MT' OR @fuf = 'PA' OR @fuf = 'PB' OR
@fuf = 'PE'  OR @fuf = 'PI'  OR @fuf = 'PR'  OR @fuf = 'RN'  OR @fuf = 'RO' OR @fuf = 'TO' )THEN
SET new.Uf = NULL;
END IF ;
END $$
DELIMITER ;

DROP TRIGGER Ex2;

INSERT INTO `cliente` VALUES (1581,'Laura Gomena','95997  Cuba Blvd.','Warrek','46876','RS','318589545');
