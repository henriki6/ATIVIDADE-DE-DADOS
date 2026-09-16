-- FELAP Máquinas e Equipamentos LTDA
-- Entrega 2 - Banco de Dados
-- SGBD: MySQL 8.0
-- Dados fictícios para fins acadêmicos

DROP DATABASE IF EXISTS felap_bd;

CREATE DATABASE felap_bd
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

USE felap_bd;


-- =========================================================
-- 1. TABELA CLIENTE
-- =========================================================

CREATE TABLE cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cpf_cnpj VARCHAR(20) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    endereco VARCHAR(200)
);


-- =========================================================
-- 2. TABELA FUNCIONARIO
-- =========================================================

CREATE TABLE funcionario (
    id_funcionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(120) NOT NULL,
    cargo_funcao VARCHAR(80) NOT NULL
);


-- =========================================================
-- 3. TABELA MARCA
-- =========================================================

CREATE TABLE marca (
    id_marca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE
);


-- =========================================================
-- 4. TABELA CATEGORIA
-- =========================================================

CREATE TABLE categoria (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL UNIQUE
);


-- =========================================================
-- 5. TABELA PECA
-- =========================================================

CREATE TABLE peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(150) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0,

    CONSTRAINT chk_peca_estoque
        CHECK (quantidade_estoque >= 0)
);


-- =========================================================
-- 6. TABELA MAQUINA
-- =========================================================

CREATE TABLE maquina (
    id_maquina INT AUTO_INCREMENT PRIMARY KEY,
    id_marca INT NOT NULL,
    id_categoria INT NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(60) NOT NULL UNIQUE,
    situacao_linha VARCHAR(20) NOT NULL,
    status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_maquina_marca
        FOREIGN KEY (id_marca)
        REFERENCES marca(id_marca),

    CONSTRAINT fk_maquina_categoria
        FOREIGN KEY (id_categoria)
        REFERENCES categoria(id_categoria),

    CONSTRAINT chk_maquina_linha
        CHECK (situacao_linha IN ('EM_LINHA', 'FORA_DE_LINHA')),

    CONSTRAINT chk_maquina_status
        CHECK (
            status IN (
                'DISPONIVEL',
                'ALUGADA',
                'EM_MANUTENCAO',
                'VENDIDA',
                'INDISPONIVEL'
            )
        )
);


-- =========================================================
-- 7. TABELA LOCACAO
-- =========================================================

CREATE TABLE locacao (
    id_locacao INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data_retirada DATE NOT NULL,
    data_devolucao DATE,

    CONSTRAINT fk_locacao_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    CONSTRAINT fk_locacao_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario),

    CONSTRAINT chk_locacao_datas
        CHECK (
            data_devolucao IS NULL
            OR data_devolucao >= data_retirada
        )
);


-- =========================================================
-- 8. TABELA ITEM LOCACAO
-- =========================================================

CREATE TABLE item_locacao (
    id_item_locacao INT AUTO_INCREMENT PRIMARY KEY,
    id_locacao INT NOT NULL,
    id_maquina INT NOT NULL,
    valor_diaria DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_item_locacao_locacao
        FOREIGN KEY (id_locacao)
        REFERENCES locacao(id_locacao),

    CONSTRAINT fk_item_locacao_maquina
        FOREIGN KEY (id_maquina)
        REFERENCES maquina(id_maquina),

    CONSTRAINT chk_item_locacao_valor
        CHECK (valor_diaria > 0)
);


-- =========================================================
-- 9. TABELA VENDA
-- =========================================================

CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    data DATE NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_venda_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    CONSTRAINT fk_venda_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario),

    CONSTRAINT chk_venda_total
        CHECK (valor_total >= 0)
);


-- =========================================================
-- 10. TABELA ITEM VENDA
-- =========================================================

CREATE TABLE item_venda (
    id_item_venda INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NOT NULL,
    id_maquina INT NOT NULL,
    valor_venda DECIMAL(12,2) NOT NULL,

    CONSTRAINT fk_item_venda_venda
        FOREIGN KEY (id_venda)
        REFERENCES venda(id_venda),

    CONSTRAINT fk_item_venda_maquina
        FOREIGN KEY (id_maquina)
        REFERENCES maquina(id_maquina),

    CONSTRAINT chk_item_venda_valor
        CHECK (valor_venda > 0),

    CONSTRAINT uq_item_venda_maquina
        UNIQUE (id_maquina)
);


-- =========================================================
-- 11. TABELA ORDEM DE SERVICO
-- =========================================================

CREATE TABLE ordem_servico (
    id_ordem_servico INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_funcionario INT NOT NULL,
    id_maquina INT NOT NULL,
    diagnostico TEXT,
    status VARCHAR(30) NOT NULL,

    CONSTRAINT fk_os_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES cliente(id_cliente),

    CONSTRAINT fk_os_funcionario
        FOREIGN KEY (id_funcionario)
        REFERENCES funcionario(id_funcionario),

    CONSTRAINT fk_os_maquina
        FOREIGN KEY (id_maquina)
        REFERENCES maquina(id_maquina),

    CONSTRAINT chk_os_status
        CHECK (
            status IN (
                'ABERTA',
                'EM_DIAGNOSTICO',
                'AGUARDANDO_PECAS',
                'EM_MANUTENCAO',
                'CONCLUIDA',
                'CANCELADA'
            )
        )
);


-- =========================================================
-- 12. TABELA ITEM ORDEM DE SERVICO
-- =========================================================

CREATE TABLE item_ordem_servico (
    id_item_os INT AUTO_INCREMENT PRIMARY KEY,
    id_ordem_servico INT NOT NULL,
    id_peca INT NOT NULL,
    quantidade_utilizada INT NOT NULL,

    CONSTRAINT fk_item_os_os
        FOREIGN KEY (id_ordem_servico)
        REFERENCES ordem_servico(id_ordem_servico),

    CONSTRAINT fk_item_os_peca
        FOREIGN KEY (id_peca)
        REFERENCES peca(id_peca),

    CONSTRAINT chk_item_os_quantidade
        CHECK (quantidade_utilizada > 0)
);


-- =========================================================
-- 13. TABELA MOVIMENTACAO ESTOQUE
-- =========================================================

CREATE TABLE movimentacao_estoque (
    id_movimentacao INT AUTO_INCREMENT PRIMARY KEY,
    id_peca INT NOT NULL,
    tipo VARCHAR(10) NOT NULL,
    quantidade INT NOT NULL,

    CONSTRAINT fk_movimentacao_peca
        FOREIGN KEY (id_peca)
        REFERENCES peca(id_peca),

    CONSTRAINT chk_movimentacao_tipo
        CHECK (tipo IN ('ENTRADA', 'SAIDA')),

    CONSTRAINT chk_movimentacao_quantidade
        CHECK (quantidade > 0)
);


-- =========================================================
-- 14. TABELA PAGAMENTO
-- =========================================================

CREATE TABLE pagamento (
    id_pagamento INT AUTO_INCREMENT PRIMARY KEY,
    id_venda INT NULL,
    id_locacao INT NULL,
    id_ordem_servico INT NULL,
    valor DECIMAL(12,2) NOT NULL,
    forma_pagamento VARCHAR(30) NOT NULL,

    CONSTRAINT fk_pagamento_venda
        FOREIGN KEY (id_venda)
        REFERENCES venda(id_venda),

    CONSTRAINT fk_pagamento_locacao
        FOREIGN KEY (id_locacao)
        REFERENCES locacao(id_locacao),

    CONSTRAINT fk_pagamento_os
        FOREIGN KEY (id_ordem_servico)
        REFERENCES ordem_servico(id_ordem_servico),

    CONSTRAINT chk_pagamento_valor
        CHECK (valor > 0),

    CONSTRAINT chk_pagamento_origem
        CHECK (
            (id_venda IS NOT NULL)
            + (id_locacao IS NOT NULL)
            + (id_ordem_servico IS NOT NULL) = 1
        )
);


-- =========================================================
-- DADOS FICTÍCIOS
-- =========================================================


-- CLIENTES

INSERT INTO cliente
(nome, cpf_cnpj, telefone, endereco)
VALUES
('João da Silva', '11111111111', '(11) 98888-1001', 'São Paulo - SP'),
('Construtora Alpha Ltda.', '12345678000190', '(11) 3222-1002', 'São Paulo - SP'),
('Marcos Oliveira', '22222222222', '(11) 97777-1003', 'Guarulhos - SP'),
('Engenharia Beta Ltda.', '98765432000110', '(11) 3444-1004', 'Santo André - SP'),
('Carlos Souza', '33333333333', '(11) 96666-1005', 'São Paulo - SP');


-- FUNCIONARIOS

INSERT INTO funcionario
(nome, cargo_funcao)
VALUES
('Ana Paula', 'Atendente'),
('Carlos Mendes', 'Técnico'),
('Roberto Lima', 'Vendedor'),
('Fernanda Alves', 'Responsável pelo Estoque');


-- MARCAS

INSERT INTO marca
(nome)
VALUES
('JCB'),
('Caterpillar'),
('Komatsu'),
('Bobcat');


-- CATEGORIAS

INSERT INTO categoria
(descricao)
VALUES
('Retroescavadeira'),
('Escavadeira'),
('Pá Carregadeira'),
('Mini Carregadeira');


-- PECAS

INSERT INTO peca
(descricao, quantidade_estoque)
VALUES
('Filtro de óleo', 15),
('Filtro de ar', 10),
('Correia do motor', 8),
('Bomba hidráulica', 4),
('Mangueira hidráulica', 12),
('Rolamento', 20);


-- MAQUINAS

INSERT INTO maquina
(id_marca, id_categoria, modelo, numero_serie, situacao_linha, status)
VALUES
(1, 1, 'JCB 3CX', 'JCB3CX001', 'EM_LINHA', 'DISPONIVEL'),
(2, 2, 'CAT 320', 'CAT320002', 'EM_LINHA', 'ALUGADA'),
(3, 3, 'WA200', 'KOMWA200003', 'EM_LINHA', 'EM_MANUTENCAO'),
(4, 4, 'S650', 'BOBS650004', 'FORA_DE_LINHA', 'VENDIDA'),
(1, 1, 'JCB 4CX', 'JCB4CX005', 'EM_LINHA', 'DISPONIVEL'),
(1, 1, 'JCB 540-170', 'JCB540170006', 'EM_LINHA', 'VENDIDA');


-- LOCACOES

INSERT INTO locacao
(id_cliente, id_funcionario, data_retirada, data_devolucao)
VALUES
(1, 1, '2026-08-01', '2026-08-10'),
(2, 3, '2026-08-05', NULL);


-- ITENS DE LOCACAO

INSERT INTO item_locacao
(id_locacao, id_maquina, valor_diaria)
VALUES
(1, 2, 850.00),
(2, 5, 780.00);


-- VENDAS

INSERT INTO venda
(id_cliente, id_funcionario, data, valor_total)
VALUES
(3, 3, '2026-08-15', 185000.00),
(5, 3, '2026-08-20', 142000.00);


-- ITENS DE VENDA

INSERT INTO item_venda
(id_venda, id_maquina, valor_venda)
VALUES
(1, 6, 185000.00),
(2, 4, 142000.00);


-- ORDENS DE SERVICO

INSERT INTO ordem_servico
(id_cliente, id_funcionario, id_maquina, diagnostico, status)
VALUES
(
    2,
    2,
    3,
    'Falha no sistema hidráulico e necessidade de revisão.',
    'EM_MANUTENCAO'
),
(
    4,
    2,
    4,
    'Máquina parada aguardando disponibilidade de peças.',
    'AGUARDANDO_PECAS'
);


-- ITENS DAS ORDENS DE SERVICO

INSERT INTO item_ordem_servico
(id_ordem_servico, id_peca, quantidade_utilizada)
VALUES
(1, 4, 1),
(1, 5, 2),
(2, 3, 1);


-- MOVIMENTACOES DE ESTOQUE

INSERT INTO movimentacao_estoque
(id_peca, tipo, quantidade)
VALUES
(1, 'ENTRADA', 20),
(2, 'ENTRADA', 10),
(3, 'ENTRADA', 10),
(3, 'SAIDA', 2),
(4, 'ENTRADA', 5),
(4, 'SAIDA', 1),
(5, 'ENTRADA', 15),
(5, 'SAIDA', 2),
(6, 'ENTRADA', 20);


-- PAGAMENTOS

INSERT INTO pagamento
(id_venda, id_locacao, id_ordem_servico, valor, forma_pagamento)
VALUES
(1, NULL, NULL, 185000.00, 'TRANSFERENCIA'),
(NULL, 1, NULL, 8500.00, 'PIX'),
(NULL, NULL, 1, 2500.00, 'CARTAO'),
(2, NULL, NULL, 142000.00, 'BOLETO');


-- =========================================================
-- CONSULTAS BASICAS
-- =========================================================


-- Listar clientes

SELECT *
FROM cliente;


-- Listar maquinas com marca e categoria

SELECT
    m.id_maquina,
    m.modelo,
    m.numero_serie,
    ma.nome AS marca,
    c.descricao AS categoria,
    m.situacao_linha,
    m.status
FROM maquina m
INNER JOIN marca ma
    ON ma.id_marca = m.id_marca
INNER JOIN categoria c
    ON c.id_categoria = m.id_categoria;


-- Listar locacoes

SELECT
    l.id_locacao,
    c.nome AS cliente,
    f.nome AS funcionario,
    m.modelo AS maquina,
    l.data_retirada,
    l.data_devolucao,
    il.valor_diaria
FROM locacao l
INNER JOIN cliente c
    ON c.id_cliente = l.id_cliente
INNER JOIN funcionario f
    ON f.id_funcionario = l.id_funcionario
INNER JOIN item_locacao il
    ON il.id_locacao = l.id_locacao
INNER JOIN maquina m
    ON m.id_maquina = il.id_maquina;


-- Listar vendas

SELECT
    v.id_venda,
    c.nome AS cliente,
    v.data,
    m.modelo AS maquina,
    iv.valor_venda,
    v.valor_total
FROM venda v
INNER JOIN cliente c
    ON c.id_cliente = v.id_cliente
INNER JOIN item_venda iv
    ON iv.id_venda = v.id_venda
INNER JOIN maquina m
    ON m.id_maquina = iv.id_maquina;


-- Listar ordens de servico

SELECT
    os.id_ordem_servico,
    c.nome AS cliente,
    f.nome AS tecnico,
    m.modelo AS maquina,
    os.diagnostico,
    os.status
FROM ordem_servico os
INNER JOIN cliente c
    ON c.id_cliente = os.id_cliente
INNER JOIN funcionario f
    ON f.id_funcionario = os.id_funcionario
INNER JOIN maquina m
    ON m.id_maquina = os.id_maquina;


-- Listar pecas utilizadas nas ordens de servico

SELECT
    os.id_ordem_servico,
    m.modelo AS maquina,
    p.descricao AS peca,
    ios.quantidade_utilizada
FROM item_ordem_servico ios
INNER JOIN ordem_servico os
    ON os.id_ordem_servico = ios.id_ordem_servico
INNER JOIN maquina m
    ON m.id_maquina = os.id_maquina
INNER JOIN peca p
    ON p.id_peca = ios.id_peca;


-- =========================================================
-- CONSULTAS DE GESTAO
-- =========================================================


-- Maquinas disponiveis

SELECT
    id_maquina,
    modelo,
    numero_serie,
    status
FROM maquina
WHERE status = 'DISPONIVEL';


-- Maquinas fora de linha

SELECT
    id_maquina,
    modelo,
    numero_serie,
    situacao_linha,
    status
FROM maquina
WHERE situacao_linha = 'FORA_DE_LINHA';


-- Ordens aguardando pecas

SELECT
    os.id_ordem_servico,
    c.nome AS cliente,
    m.modelo AS maquina,
    os.status
FROM ordem_servico os
INNER JOIN cliente c
    ON c.id_cliente = os.id_cliente
INNER JOIN maquina m
    ON m.id_maquina = os.id_maquina
WHERE os.status = 'AGUARDANDO_PECAS';


-- Pecas com estoque baixo

SELECT
    id_peca,
    descricao,
    quantidade_estoque
FROM peca
WHERE quantidade_estoque <= 5
ORDER BY quantidade_estoque ASC;


-- Total de itens por venda

SELECT
    v.id_venda,
    c.nome AS cliente,
    SUM(iv.valor_venda) AS total_itens
FROM venda v
INNER JOIN cliente c
    ON c.id_cliente = v.id_cliente
INNER JOIN item_venda iv
    ON iv.id_venda = v.id_venda
GROUP BY
    v.id_venda,
    c.nome;


-- Media do valor das diarias

SELECT
    AVG(valor_diaria) AS media_diaria
FROM item_locacao;


-- Quantidade de maquinas por status

SELECT
    status,
    COUNT(*) AS quantidade
FROM maquina
GROUP BY status
ORDER BY quantidade DESC;


-- =========================================================
-- CONSULTAS DE AUDITORIA
-- =========================================================


-- Conferir maquinas vendidas

SELECT
    m.id_maquina,
    m.modelo,
    m.numero_serie,
    m.status,
    v.id_venda,
    v.data,
    iv.valor_venda
FROM maquina m
INNER JOIN item_venda iv
    ON iv.id_maquina = m.id_maquina
INNER JOIN venda v
    ON v.id_venda = iv.id_venda
WHERE m.status = 'VENDIDA';


-- Conferir maquinas alugadas

SELECT
    m.id_maquina,
    m.modelo,
    m.numero_serie,
    l.id_locacao,
    c.nome AS cliente,
    l.data_retirada,
    l.data_devolucao
FROM maquina m
INNER JOIN item_locacao il
    ON il.id_maquina = m.id_maquina
INNER JOIN locacao l
    ON l.id_locacao = il.id_locacao
INNER JOIN cliente c
    ON c.id_cliente = l.id_cliente
WHERE m.status = 'ALUGADA';


-- Conferir maquinas em manutencao

SELECT
    m.id_maquina,
    m.modelo,
    m.numero_serie,
    os.id_ordem_servico,
    os.status
FROM maquina m
INNER JOIN ordem_servico os
    ON os.id_maquina = m.id_maquina
WHERE m.status = 'EM_MANUTENCAO';


-- Pecas com estoque abaixo de 5 unidades

SELECT
    id_peca,
    descricao,
    quantidade_estoque
FROM peca
WHERE quantidade_estoque < 5;


-- Ordens de servico sem pecas cadastradas

SELECT
    os.id_ordem_servico,
    os.status,
    os.diagnostico
FROM ordem_servico os
LEFT JOIN item_ordem_servico ios
    ON ios.id_ordem_servico = os.id_ordem_servico
WHERE ios.id_item_os IS NULL;


-- Maquinas fora de linha

SELECT
    id_maquina,
    modelo,
    numero_serie,
    situacao_linha,
    status
FROM maquina
WHERE situacao_linha = 'FORA_DE_LINHA';


-- =========================================================
-- UPDATE - EXEMPLOS
-- =========================================================

-- UPDATE maquina
-- SET status = 'EM_MANUTENCAO'
-- WHERE id_maquina = 1;


-- UPDATE cliente
-- SET telefone = '(11) 99999-0000'
-- WHERE id_cliente = 1;


-- =========================================================
-- DELETE - EXEMPLO
-- =========================================================

-- DELETE FROM cliente
-- WHERE id_cliente = 5;


-- =========================================================
-- CONSULTAS EXTRAS PARA APRESENTACAO
-- =========================================================


-- Faturamento total de vendas

SELECT
    SUM(valor_total) AS faturamento_total_vendas
FROM venda;


-- Quantidade total de pecas em estoque

SELECT
    SUM(quantidade_estoque) AS total_pecas_estoque
FROM peca;


-- Clientes que possuem locacoes

SELECT DISTINCT
    c.id_cliente,
    c.nome
FROM cliente c
INNER JOIN locacao l
    ON l.id_cliente = c.id_cliente;


-- Pagamentos registrados

SELECT
    id_pagamento,
    valor,
    forma_pagamento,
    id_venda,
    id_locacao,
    id_ordem_servico
FROM pagamento
ORDER BY id_pagamento;


-- =========================================================
-- FIM DO SCRIPT
-- =========================================================