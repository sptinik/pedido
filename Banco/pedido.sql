/*
Navicat MySQL Data Transfer

Source Server         : pcrw
Source Server Version : 50516
Source Host           : localhost:3306
Source Database       : pedido
Target Server Type    : MYSQL
Target Server Version : 50516
File Encoding         : 65001

Date: 2021-03-17 13:07:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `clientes`
-- ----------------------------
DROP TABLE IF EXISTS `clientes`;
CREATE TABLE `clientes` (
  `id_cli` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cidade` varchar(45) NOT NULL,
  `uf` char(2) NOT NULL,
  PRIMARY KEY (`id_cli`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of clientes
-- ----------------------------
INSERT INTO `clientes` VALUES ('1', 'DANIEL PEREIRA ROCHA', 'RIO JANEIRO', 'RJ');
INSERT INTO `clientes` VALUES ('2', 'FILIPE JUNIO DE OLIVEIRA', 'SÃO PAULO', 'SP');
INSERT INTO `clientes` VALUES ('3', 'WEMBLEY SOUZA JOCA', 'GOIANIA', 'GO');
INSERT INTO `clientes` VALUES ('4', 'JUNIO EDUARDO LEITE', 'JUSSARA', 'GO');
INSERT INTO `clientes` VALUES ('5', 'WESLEY MOREIRA GOMES ', 'NOVO BRASIL', 'GO');
INSERT INTO `clientes` VALUES ('6', 'WALBERSON MACHADO DE QUEIROZ SILVA', 'FAZENDA NOVA', 'GO');
INSERT INTO `clientes` VALUES ('7', 'ELZO JOSÉ DA SILVA ANDRADE', 'ITABERAI', 'GO');
INSERT INTO `clientes` VALUES ('8', 'CÉLIO PIRES MARTINS', 'JUSSARA', 'MG');
INSERT INTO `clientes` VALUES ('9', 'MARCOS FERNANDO GOMES DA SILVA', 'SAO PAULO', 'GO');
INSERT INTO `clientes` VALUES ('10', 'ALAN KARDEC NOGUEIRA JUNIOR', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES ('11', 'JEFFERSON FERNANDES DE OLIVEIRA', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES ('12', 'ROGÉRIO GONÇALVES PINHEIRO', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES ('13', 'THIAGO TEIXEIRA SIMÕES', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES ('14', 'GEZIEL DE OLIVEIRA CIRINO', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES ('15', 'RODRIGO COSTA OLIVEIRA ', 'SAO PAULO', 'SP');
INSERT INTO `clientes` VALUES ('16', 'RODRYGO RAFAEL VALADARES DOS SANTOS', 'NOVO BRASIL', 'GO');
INSERT INTO `clientes` VALUES ('17', 'DIEGO SOARES DOS REIS', 'Salvador', 'GO');
INSERT INTO `clientes` VALUES ('18', 'ENIO MARLES SOUZA OLIVEIRA', 'NOVO BRASIL', 'GO');
INSERT INTO `clientes` VALUES ('19', 'BRUNO CASELATO', 'NOVO BRASIL', 'GO');
INSERT INTO `clientes` VALUES ('20', 'GILBERTO ROSA DA COSTA FILHO', 'NOVO BRASIL', 'SP');

-- ----------------------------
-- Table structure for `pedidos_dados_gerais`
-- ----------------------------
DROP TABLE IF EXISTS `pedidos_dados_gerais`;
CREATE TABLE `pedidos_dados_gerais` (
  `num_pedido` int(11) NOT NULL AUTO_INCREMENT,
  `data_emissao` datetime NOT NULL,
  `valor_total` double NOT NULL,
  `clientes_id` int(11) NOT NULL,
  PRIMARY KEY (`num_pedido`),
  KEY `fk_pedidos_dados_gerais_clientes_idx` (`clientes_id`),
  CONSTRAINT `fk_pedidos_dados_gerais_clientes` FOREIGN KEY (`clientes_id`) REFERENCES `clientes` (`id_cli`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pedidos_dados_gerais
-- ----------------------------

-- ----------------------------
-- Table structure for `pedidos_produtos`
-- ----------------------------
DROP TABLE IF EXISTS `pedidos_produtos`;
CREATE TABLE `pedidos_produtos` (
  `item` int(11) NOT NULL AUTO_INCREMENT,
  `qtde` varchar(11) NOT NULL,
  `vlr_unit` double NOT NULL,
  `vlr_total` double NOT NULL,
  `num_pedido` int(11) NOT NULL,
  `produtos_id_prod` int(11) NOT NULL,
  PRIMARY KEY (`item`),
  KEY `fk_pedidos_produtos_pedidos_dados_gerais1_idx` (`num_pedido`),
  KEY `fk_pedidos_produtos_produtos1_idx` (`produtos_id_prod`),
  CONSTRAINT `fk_pedidos_produtos_pedidos_dados_gerais1` FOREIGN KEY (`num_pedido`) REFERENCES `pedidos_dados_gerais` (`num_pedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pedidos_produtos_produtos1` FOREIGN KEY (`produtos_id_prod`) REFERENCES `produtos` (`id_prod`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pedidos_produtos
-- ----------------------------

-- ----------------------------
-- Table structure for `produtos`
-- ----------------------------
DROP TABLE IF EXISTS `produtos`;
CREATE TABLE `produtos` (
  `id_prod` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL,
  `preco_venda` double NOT NULL,
  PRIMARY KEY (`id_prod`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of produtos
-- ----------------------------
INSERT INTO `produtos` VALUES ('1', 'ITEM 1', '300');
INSERT INTO `produtos` VALUES ('2', 'ITEM 2', '500');
INSERT INTO `produtos` VALUES ('3', 'ITEM 3', '230');
INSERT INTO `produtos` VALUES ('4', 'ITEM 4', '650');
INSERT INTO `produtos` VALUES ('5', 'ITEM 5', '100');
INSERT INTO `produtos` VALUES ('6', 'ITEM 6', '170');
INSERT INTO `produtos` VALUES ('7', 'ITEM 7', '300');
INSERT INTO `produtos` VALUES ('8', 'ITEM 8', '630');
INSERT INTO `produtos` VALUES ('9', 'ITEM 9', '700');
INSERT INTO `produtos` VALUES ('10', 'ITEM 10', '100');
INSERT INTO `produtos` VALUES ('11', 'ITEM 11', '3300');
INSERT INTO `produtos` VALUES ('12', 'ITEM 12', '830');
INSERT INTO `produtos` VALUES ('13', 'ITEM 13', '360');
INSERT INTO `produtos` VALUES ('14', 'ITEM 14', '510');
INSERT INTO `produtos` VALUES ('15', 'ITEM 15', '520');
INSERT INTO `produtos` VALUES ('16', 'ITEM 16', '100');
INSERT INTO `produtos` VALUES ('17', 'ITEM 17', '350');
INSERT INTO `produtos` VALUES ('18', 'ITEM 18', '200');
INSERT INTO `produtos` VALUES ('19', 'ITEM 19', '130');
INSERT INTO `produtos` VALUES ('20', 'ITEM 20', '700');
