# Relatório Técnico — Entrega 2

## Projeto de Banco de Dados — FELAP Máquinas e Equipamentos LTDA

---

# 1. Introdução

Este relatório apresenta a evolução do projeto de banco de dados desenvolvido para a empresa FELAP Máquinas e Equipamentos LTDA.

A Entrega 2 tem como objetivo transformar o modelo conceitual desenvolvido anteriormente em um modelo lógico relacional, definindo tabelas, chaves primárias, chaves estrangeiras, restrições de integridade e estruturas necessárias para futura implementação no Sistema Gerenciador de Banco de Dados (SGBD).

Para a implementação foi escolhido o MySQL 8.0, devido à sua ampla utilização, suporte a restrições de integridade, facilidade de utilização e compatibilidade com ferramentas acadêmicas e profissionais.

O banco de dados proposto busca organizar informações relacionadas aos principais processos identificados na FELAP:

- Clientes;
- Funcionários;
- Máquinas;
- Marcas;
- Categorias;
- Locações;
- Vendas;
- Ordens de Serviço;
- Peças;
- Movimentações de estoque;
- Pagamentos.

Os dados utilizados na implementação são fictícios e foram criados exclusivamente para fins acadêmicos.

---

# 2. Revisão do Modelo Conceitual

O modelo conceitual desenvolvido na Entrega 1 foi revisado para sua transformação em um modelo lógico relacional.

O modelo possui 14 entidades/tabelas principais, responsáveis por representar os dados necessários aos processos de locação, venda, assistência técnica e controle de peças.

As entidades utilizadas são:

1. CLIENTE
2. FUNCIONARIO
3. MARCA
4. CATEGORIA
5. MAQUINA
6. LOCACAO
7. ITEM_LOCACAO
8. VENDA
9. ITEM_VENDA
10. ORDEM_SERVICO
11. ITEM_ORDEM_SERVICO
12. PECA
13. MOVIMENTACAO_ESTOQUE
14. PAGAMENTO

A entidade `MAQUINA` permanece como um dos principais elementos do modelo, pois está relacionada aos processos de locação, venda e assistência técnica.

A separação dos processos em tabelas próprias evita a concentração de informações diferentes em uma única estrutura e facilita a manutenção dos dados.

---

# 3. Modelo Lógico

O modelo lógico transforma as entidades e relacionamentos do modelo conceitual em tabelas relacionais.

Cada tabela possui uma chave primária (PK), utilizada para identificar de forma única cada registro. Quando necessário, as tabelas também possuem chaves estrangeiras (FK), utilizadas para estabelecer os relacionamentos entre os dados.

## 3.1 Modelo Lógico Visual

O modelo lógico possui 14 tabelas com suas respectivas PKs, FKs e tipos de dados.

![Modelo Lógico FELAP](../modelo-logico/modelo-logico-FELAP.png)

---

# 4. Estrutura das Tabelas

## 4.1 CLIENTE

Armazena os dados dos clientes da FELAP.

| Campo | Tipo | Chave |
|---|---|---|
| id_cliente | INT | PK |
| nome | VARCHAR(120) | — |
| cpf_cnpj | VARCHAR(18) | UNIQUE |
| telefone | VARCHAR(20) | — |
| endereco | VARCHAR(200) | — |

---

## 4.2 FUNCIONARIO

Armazena os funcionários responsáveis pelos processos da empresa.

| Campo | Tipo | Chave |
|---|---|---|
| id_funcionario | INT | PK |
| nome | VARCHAR(120) | — |
| cargo_funcao | VARCHAR(100) | — |

---

## 4.3 MARCA

Armazena as marcas das máquinas comercializadas ou utilizadas pela empresa.

| Campo | Tipo | Chave |
|---|---|---|
| id_marca | INT | PK |
| nome | VARCHAR(80) | UNIQUE |

---

## 4.4 CATEGORIA

Armazena as categorias das máquinas.

| Campo | Tipo | Chave |
|---|---|---|
| id_categoria | INT | PK |
| descricao | VARCHAR(120) | UNIQUE |

---

## 4.5 MAQUINA

Armazena as informações das máquinas.

| Campo | Tipo | Chave |
|---|---|---|
| id_maquina | INT | PK |
| id_marca | INT | FK |
| id_categoria | INT | FK |
| modelo | VARCHAR(120) | — |
| numero_serie | VARCHAR(80) | UNIQUE |
| situacao_linha | VARCHAR(30) | — |
| status | VARCHAR(30) | — |

O campo `numero_serie` é único para evitar o cadastro duplicado de uma mesma máquina.

O campo `situacao_linha` permite diferenciar máquinas em linha e fora de linha.

O campo `status` representa a situação operacional da máquina, como:

- DISPONIVEL;
- ALUGADA;
- EM_MANUTENCAO;
- VENDIDA;
- INDISPONIVEL.

---

## 4.6 LOCACAO

Armazena os registros de locação realizados pela FELAP.

| Campo | Tipo | Chave |
|---|---|---|
| id_locacao | INT | PK |
| id_cliente | INT | FK |
| id_funcionario | INT | FK |
| data_retirada | DATE | — |
| data_devolucao | DATE | — |

A tabela relaciona o cliente e o funcionário responsável pelo registro da locação.

A data de devolução deve ser igual ou posterior à data de retirada.

---

## 4.7 ITEM_LOCACAO

Armazena as máquinas incluídas em cada locação e o valor da diária.

| Campo | Tipo | Chave |
|---|---|---|
| id_item_locacao | INT | PK |
| id_locacao | INT | FK |
| id_maquina | INT | FK |
| valor_diaria | DECIMAL(12,2) | — |

A tabela permite relacionar uma locação às máquinas utilizadas.

O valor da diária é armazenado no item da locação porque pode variar de acordo com a máquina ou negociação realizada.

---

## 4.8 VENDA

Armazena os registros de venda de máquinas.

| Campo | Tipo | Chave |
|---|---|---|
| id_venda | INT | PK |
| id_cliente | INT | FK |
| id_funcionario | INT | FK |
| data | DATE | — |
| valor_total | DECIMAL(12,2) | — |

A tabela registra o cliente responsável pela compra, o funcionário responsável pelo registro, a data e o valor total da venda.

---

## 4.9 ITEM_VENDA

Armazena as máquinas incluídas em uma venda.

| Campo | Tipo | Chave |
|---|---|---|
| id_item_venda | INT | PK |
| id_venda | INT | FK |
| id_maquina | INT | FK |
| valor_venda | DECIMAL(12,2) | — |

Cada item relaciona uma venda a uma máquina específica.

O campo `valor_venda` registra o valor negociado para a máquina no momento da venda.

A mesma máquina não deve ser registrada em mais de uma venda.

---

## 4.10 ORDEM_SERVICO

Armazena as ordens de serviço relacionadas à manutenção e assistência técnica.

| Campo | Tipo | Chave |
|---|---|---|
| id_ordem_servico | INT | PK |
| id_cliente | INT | FK |
| id_funcionario | INT | FK |
| id_maquina | INT | FK |
| diagnostico | TEXT | — |
| status | VARCHAR(30) | — |

A ordem de serviço relaciona o cliente, o funcionário responsável e a máquina atendida.

O campo `diagnostico` registra as informações relacionadas ao problema identificado.

O campo `status` permite acompanhar a situação da ordem de serviço.

Exemplos de status:

- ABERTA;
- EM_DIAGNOSTICO;
- AGUARDANDO_PECAS;
- EM_MANUTENCAO;
- CONCLUIDA;
- CANCELADA.

---

## 4.11 ITEM_ORDEM_SERVICO

Armazena as peças utilizadas em cada ordem de serviço.

| Campo | Tipo | Chave |
|---|---|---|
| id_item_os | INT | PK |
| id_ordem_servico | INT | FK |
| id_peca | INT | FK |
| quantidade_utilizada | INT | — |

A tabela permite registrar quais peças foram utilizadas em cada ordem de serviço e a quantidade utilizada.

Essa estrutura evita armazenar várias peças em uma única coluna da ordem de serviço.

---

## 4.12 PECA

Armazena as peças utilizadas nos serviços e controladas pelo estoque.

| Campo | Tipo | Chave |
|---|---|---|
| id_peca | INT | PK |
| descricao | VARCHAR(150) | — |
| quantidade_estoque | INT | — |

O campo `quantidade_estoque` representa a quantidade atual disponível da peça.

O estoque não deve possuir quantidade negativa.

---

## 4.13 MOVIMENTACAO_ESTOQUE

Registra as entradas e saídas de peças do estoque.

| Campo | Tipo | Chave |
|---|---|---|
| id_movimentacao | INT | PK |
| id_peca | INT | FK |
| tipo | VARCHAR(20) | — |
| quantidade | INT | — |

O campo `tipo` identifica se a movimentação representa uma:

- ENTRADA;
- SAIDA.

A quantidade deve ser maior que zero.

A tabela permite manter o histórico das movimentações relacionadas às peças.

---

## 4.14 PAGAMENTO

Armazena os pagamentos relacionados aos processos da empresa.

| Campo | Tipo | Chave |
|---|---|---|
| id_pagamento | INT | PK |
| id_venda | INT | FK |
| id_locacao | INT | FK |
| id_ordem_servico | INT | FK |
| valor | DECIMAL(12,2) | — |
| forma_pagamento | VARCHAR(30) | — |

Um pagamento pode estar relacionado a uma venda, uma locação ou uma ordem de serviço.

A estrutura utiliza as três chaves estrangeiras como possibilidades de origem do pagamento, sendo permitido informar apenas uma origem por registro.

---

# 5. Chaves Primárias

As chaves primárias utilizadas no modelo são:

| Tabela | Chave Primária |
|---|---|
| cliente | id_cliente |
| funcionario | id_funcionario |
| marca | id_marca |
| categoria | id_categoria |
| maquina | id_maquina |
| locacao | id_locacao |
| item_locacao | id_item_locacao |
| venda | id_venda |
| item_venda | id_item_venda |
| ordem_servico | id_ordem_servico |
| item_ordem_servico | id_item_os |
| peca | id_peca |
| movimentacao_estoque | id_movimentacao |
| pagamento | id_pagamento |

As PKs identificam cada registro de forma única dentro de sua respectiva tabela.

---

# 6. Chaves Estrangeiras

| Tabela | Campo FK | Tabela relacionada |
|---|---|---|
| maquina | id_marca | marca |
| maquina | id_categoria | categoria |
| locacao | id_cliente | cliente |
| locacao | id_funcionario | funcionario |
| item_locacao | id_locacao | locacao |
| item_locacao | id_maquina | maquina |
| venda | id_cliente | cliente |
| venda | id_funcionario | funcionario |
| item_venda | id_venda | venda |
| item_venda | id_maquina | maquina |
| ordem_servico | id_cliente | cliente |
| ordem_servico | id_funcionario | funcionario |
| ordem_servico | id_maquina | maquina |
| item_ordem_servico | id_ordem_servico | ordem_servico |
| item_ordem_servico | id_peca | peca |
| movimentacao_estoque | id_peca | peca |
| pagamento | id_venda | venda |
| pagamento | id_locacao | locacao |
| pagamento | id_ordem_servico | ordem_servico |

As chaves estrangeiras garantem a integridade referencial entre as tabelas.

---

# 7. Relacionamentos Principais

- CLIENTE → LOCACAO: 1:N
- CLIENTE → VENDA: 1:N
- CLIENTE → ORDEM_SERVICO: 1:N
- FUNCIONARIO → LOCACAO: 1:N
- FUNCIONARIO → VENDA: 1:N
- FUNCIONARIO → ORDEM_SERVICO: 1:N
- MARCA → MAQUINA: 1:N
- CATEGORIA → MAQUINA: 1:N
- LOCACAO → ITEM_LOCACAO: 1:N
- MAQUINA → ITEM_LOCACAO: 1:N
- VENDA → ITEM_VENDA: 1:N
- MAQUINA → ITEM_VENDA: 1:1 no contexto de venda
- MAQUINA → ORDEM_SERVICO: 1:N
- ORDEM_SERVICO → ITEM_ORDEM_SERVICO: 1:N
- PECA → ITEM_ORDEM_SERVICO: 1:N
- PECA → MOVIMENTACAO_ESTOQUE: 1:N

Um pagamento possui uma única origem entre venda, locação ou ordem de serviço.

---

# 8. Normalização

A normalização foi aplicada com o objetivo de reduzir redundância, evitar inconsistências e melhorar a organização dos dados.

## 8.1 Primeira Forma Normal — 1FN

A Primeira Forma Normal determina que os atributos devem possuir valores atômicos e que não devem existir grupos repetitivos dentro de uma mesma tabela.

O modelo atende à 1FN porque as informações foram separadas de acordo com suas responsabilidades.

Por exemplo, as peças utilizadas em uma ordem de serviço não são armazenadas em uma única coluna da tabela `ordem_servico`.

Foi criada a tabela `item_ordem_servico`, permitindo registrar:

- a ordem de serviço;
- a peça utilizada;
- a quantidade utilizada.

Dessa forma, uma ordem de serviço pode utilizar várias peças sem criar colunas repetitivas.

---

# 9. Segunda Forma Normal — 2FN

A Segunda Forma Normal exige que os atributos não pertencentes à chave dependam integralmente da chave primária.

No modelo proposto, as informações específicas dos itens foram mantidas nas respectivas tabelas.

Por exemplo, `item_locacao` possui:

- id_item_locacao;
- id_locacao;
- id_maquina;
- valor_diaria.

As informações do cliente ficam na tabela `cliente`, enquanto as informações da máquina ficam na tabela `maquina`.

Da mesma forma, os dados específicos de uma venda ficam separados entre:

- `venda`;
- `item_venda`.

Essa organização evita que informações de uma entidade sejam repetidas desnecessariamente em outra.

---

# 10. Terceira Forma Normal — 3FN

A Terceira Forma Normal busca eliminar dependências transitivas.

No modelo, informações que possuem uma entidade própria foram separadas em tabelas específicas.

Por exemplo, a tabela `maquina` não armazena diretamente o nome da marca e a descrição da categoria.

Em vez disso, utiliza:

- `id_marca`;
- `id_categoria`.

As informações correspondentes ficam nas tabelas:

- `marca`;
- `categoria`.

Assim, caso o nome de uma marca precise ser alterado, a alteração ocorre em um único local.

O mesmo princípio é utilizado para clientes, funcionários e peças.

---

# 11. Resultado da Normalização

Após a aplicação das regras de normalização, o modelo foi estruturado buscando atender às:

- 1FN — valores atômicos;
- 2FN — dependência adequada em relação às chaves;
- 3FN — redução de dependências transitivas.

A normalização contribui para:

- reduzir duplicidade;
- melhorar a consistência;
- facilitar manutenção;
- facilitar consultas;
- melhorar a integridade dos dados;
- preparar o banco para implementação no MySQL.

---

# 12. Justificativas Técnicas

## 12.1 Máquina como entidade central

A máquina é um dos principais elementos do negócio da FELAP.

Ela participa dos processos de:

- locação;
- venda;
- assistência técnica;
- controle de disponibilidade;
- manutenção.

Por isso, a entidade `maquina` possui relacionamentos com diferentes processos.

## 12.2 Controle de status

O campo `status` foi mantido na tabela `maquina` para centralizar a situação operacional atual.

Exemplos:

- DISPONIVEL;
- ALUGADA;
- EM_MANUTENCAO;
- VENDIDA;
- INDISPONIVEL.

## 12.3 Separação dos processos

Locação, venda e ordem de serviço foram mantidas em tabelas diferentes porque cada processo possui características próprias.

A separação facilita consultas, manutenção, auditoria e expansão futura.

## 12.4 Uso das tabelas de itens

Foram utilizadas tabelas de itens:

- `item_locacao`;
- `item_venda`;
- `item_ordem_servico`.

Essas estruturas permitem relacionar processos com máquinas e peças sem duplicar informações.

## 12.5 Controle de estoque

A tabela `peca` armazena o estoque atual.

A tabela `movimentacao_estoque` registra as entradas e saídas, permitindo manter o histórico das operações.

## 12.6 Pagamentos

A tabela `pagamento` foi mantida separada para permitir que os registros financeiros sejam associados aos processos de venda, locação ou ordem de serviço.

---

# 13. Implementação no MySQL 8.0

O modelo foi preparado para implementação no MySQL 8.0.

O script SQL contém:

- criação do banco de dados;
- criação das tabelas;
- chaves primárias;
- chaves estrangeiras;
- restrições UNIQUE;
- restrições CHECK;
- inserção de dados fictícios;
- consultas com JOIN;
- consultas de gestão;
- consultas de auditoria;
- exemplos de UPDATE;
- exemplo de DELETE.

O script SQL está disponível na pasta:

`entrega-2/sql/`

Arquivo:

`felap_entrega2_mysql.sql`

---

# 14. Dados Fictícios

Os dados utilizados no projeto são fictícios e foram criados apenas para testar o funcionamento do banco.

Foram cadastrados exemplos de:

- clientes;
- funcionários;
- marcas;
- categorias;
- máquinas;
- peças;
- locações;
- vendas;
- ordens de serviço;
- movimentações de estoque;
- pagamentos.

A massa de dados foi criada de maneira coerente com os relacionamentos do modelo, permitindo testar diferentes situações do negócio.

Nenhum dado pessoal real de clientes foi utilizado na implementação acadêmica.

---

# 15. Consultas SQL

## 15.1 Consulta de clientes

```sql
SELECT *
FROM cliente;

---

15.2 Consulta de máquinas disponíveis
SELECT
    m.id_maquina,
    m.modelo,
    m.numero_serie,
    ma.nome AS marca,
    c.descricao AS categoria
FROM maquina m
JOIN marca ma ON ma.id_marca = m.id_marca
JOIN categoria c ON c.id_categoria = m.id_categoria
WHERE m.status = 'DISPONIVEL';
15.3 Consulta de locações com clientes
SELECT
    l.id_locacao,
    c.nome AS cliente,
    l.data_retirada,
    l.data_devolucao
FROM locacao l
JOIN cliente c ON c.id_cliente = l.id_cliente;
15.4 Consulta de ordens de serviço
SELECT
    os.id_ordem_servico,
    c.nome AS cliente,
    m.modelo AS maquina,
    os.status,
    os.diagnostico
FROM ordem_servico os
JOIN cliente c ON c.id_cliente = os.id_cliente
JOIN maquina m ON m.id_maquina = os.id_maquina;
15.5 Consulta de peças utilizadas
SELECT
    os.id_ordem_servico,
    p.descricao AS peca,
    ios.quantidade_utilizada
FROM item_ordem_servico ios
JOIN ordem_servico os
    ON os.id_ordem_servico = ios.id_ordem_servico
JOIN peca p
    ON p.id_peca = ios.id_peca;
15.6 Consulta de vendas
SELECT
    v.id_venda,
    c.nome AS cliente,
    v.data,
    v.valor_total
FROM venda v
JOIN cliente c ON c.id_cliente = v.id_cliente;
16. Consultas de Gestão

As consultas de gestão permitem transformar os dados operacionais em informações úteis para tomada de decisão.

16.1 Quantidade de máquinas por status
SELECT
    status,
    COUNT(*) AS quantidade
FROM maquina
GROUP BY status
ORDER BY quantidade DESC;
16.2 Estoque atual de peças
SELECT
    id_peca,
    descricao,
    quantidade_estoque
FROM peca
ORDER BY quantidade_estoque ASC;
16.3 Peças com estoque baixo
SELECT
    id_peca,
    descricao,
    quantidade_estoque
FROM peca
WHERE quantidade_estoque <= 5
ORDER BY quantidade_estoque ASC;
16.4 Total de vendas
SELECT
    SUM(valor_total) AS total_vendas
FROM venda;
16.5 Total recebido por forma de pagamento
SELECT
    forma_pagamento,
    SUM(valor) AS total_recebido
FROM pagamento
GROUP BY forma_pagamento
ORDER BY total_recebido DESC;
17. Consultas de Auditoria

As consultas de auditoria ajudam a identificar inconsistências ou situações que precisam de verificação.

17.1 Máquinas vendidas ainda marcadas como disponíveis
SELECT
    m.id_maquina,
    m.modelo,
    m.numero_serie,
    m.status
FROM maquina m
JOIN item_venda iv
    ON iv.id_maquina = m.id_maquina
WHERE m.status <> 'VENDIDA';
17.2 Estoque negativo
SELECT
    id_peca,
    descricao,
    quantidade_estoque
FROM peca
WHERE quantidade_estoque < 0;

Essa consulta deve retornar zero registros quando a regra de integridade estiver funcionando corretamente.

17.3 Locações com datas inconsistentes
SELECT
    id_locacao,
    data_retirada,
    data_devolucao
FROM locacao
WHERE data_devolucao < data_retirada;
17.4 Pagamentos sem origem válida
SELECT
    id_pagamento,
    valor,
    forma_pagamento
FROM pagamento
WHERE
    (id_venda IS NULL AND id_locacao IS NULL AND id_ordem_servico IS NULL)
    OR
    (
        (id_venda IS NOT NULL) +
        (id_locacao IS NOT NULL) +
        (id_ordem_servico IS NOT NULL)
    ) <> 1;
18. UPDATE e DELETE
18.1 Exemplo de UPDATE

Atualização do status de uma máquina:

UPDATE maquina
SET status = 'EM_MANUTENCAO'
WHERE id_maquina = 3;

Antes de executar alterações definitivas, recomenda-se verificar o registro com um SELECT.

18.2 Exemplo de DELETE

Exemplo acadêmico de exclusão:

DELETE FROM cliente
WHERE id_cliente = 5;

A exclusão deve respeitar as chaves estrangeiras existentes. Em um ambiente real, os registros relacionados devem ser analisados antes da exclusão.

19. Potencial de BI

O banco de dados possui potencial para utilização em soluções de Business Intelligence (BI).

Os dados podem ser utilizados para gerar indicadores relacionados a:

vendas;
locações;
máquinas;
manutenção;
estoque;
pagamentos;
utilização de peças.

A partir desses dados, a empresa poderia criar dashboards para acompanhar o desempenho operacional.

Exemplos de análises:

máquinas mais alugadas;
máquinas vendidas;
quantidade de ordens de serviço;
peças mais utilizadas;
peças com maior movimentação;
formas de pagamento mais utilizadas;
situação atual das máquinas;
volume de locações ao longo do tempo.
20. KPIs

Alguns indicadores que podem ser utilizados pela FELAP são:

KPI	Objetivo
Total de vendas	Medir o faturamento com vendas
Total de locações	Medir a utilização da frota
Máquinas disponíveis	Acompanhar disponibilidade
Máquinas em manutenção	Acompanhar indisponibilidade
Ordens de serviço abertas	Medir demanda da oficina
Ordens concluídas	Acompanhar produtividade
Peças em estoque	Controlar disponibilidade
Peças mais utilizadas	Apoiar compras
Valor recebido	Acompanhar entradas financeiras
Máquinas vendidas	Acompanhar saída do ativo

Esses indicadores podem ser acompanhados em períodos diário, semanal, mensal ou anual.

21. Possibilidades de IA

Com uma base de dados organizada, soluções de Inteligência Artificial podem ser utilizadas futuramente como apoio à gestão.

21.1 Previsão de demanda

A IA pode analisar o histórico de locações e vendas para estimar períodos de maior procura.

21.2 Previsão de necessidade de peças

O histórico de utilização das peças pode ser utilizado para estimar quais itens terão maior demanda.

21.3 Apoio à manutenção

O histórico de ordens de serviço pode ser analisado para identificar máquinas com maior frequência de manutenção.

21.4 Recomendação de estoque

A IA pode auxiliar na definição de níveis de estoque com base no consumo histórico.

21.5 Identificação de anomalias

Modelos analíticos podem apontar situações fora do padrão, como movimentações incomuns de estoque ou alterações inesperadas no comportamento das máquinas.

A IA seria utilizada como apoio à decisão, e não como substituição da análise dos responsáveis pela empresa.

22. Arquitetura de BI e IA

Uma possível arquitetura futura é:

                 BANCO DE DADOS FELAP
                         |
                         v
                ETL / TRATAMENTO
                         |
                         v
                DATA WAREHOUSE
                    /          \
                   /            \
                  v              v
                BI               IA
                 |               |
                 v               v
            DASHBOARDS      PREVISÕES
                             RECOMENDAÇÕES
                             ANOMALIAS
                 \             /
                  \           /
                   v         v
                  GESTÃO E TOMADA
                    DE DECISÃO

O banco operacional armazenaria os dados do dia a dia.

Um processo de ETL poderia extrair, transformar e carregar os dados para uma estrutura analítica.

O BI apresentaria indicadores e dashboards.

A IA poderia utilizar os dados históricos para previsões, recomendações e identificação de padrões.

23. Benefícios Esperados

A implementação do banco de dados pode proporcionar:

centralização das informações;
redução de duplicidade;
maior organização dos cadastros;
melhoria do controle de máquinas;
melhoria do controle de estoque;
acompanhamento das ordens de serviço;
facilidade na geração de relatórios;
melhoria da rastreabilidade;
apoio à tomada de decisão;
preparação para soluções de BI e IA.

Para a empresa, a principal vantagem é transformar informações dos processos em dados estruturados e consultáveis.

24. Regras de Negócio

As principais regras consideradas no projeto são:

Cada máquina deve possuir número de série único.
Uma máquina não deve ser vendida mais de uma vez.
Uma locação deve possuir cliente e funcionário responsáveis.
A data de devolução não deve ser anterior à data de retirada.
Uma máquina disponível pode participar de uma locação conforme as regras operacionais da empresa.
Máquinas fora de linha devem ser tratadas de acordo com as regras de disponibilidade definidas pela empresa.
Uma máquina pode possuir várias ordens de serviço ao longo do tempo.
Uma ordem de serviço pode utilizar várias peças.
O estoque não deve possuir quantidade negativa.
Toda movimentação de estoque deve possuir peça, tipo e quantidade.
O pagamento deve possuir somente uma origem entre venda, locação e ordem de serviço.
O acesso aos dados deve respeitar as permissões dos usuários do sistema.
Dados pessoais reais não devem ser utilizados nos arquivos acadêmicos.
Regras específicas de compatibilidade entre máquinas e peças devem ser confirmadas na pesquisa de campo antes de serem incorporadas ao modelo definitivo.
25. Pontos de Validação e Evolução

O modelo ainda pode receber ajustes após a validação em campo.

Entre os pontos que devem ser confirmados estão:

regras reais de disponibilidade das máquinas;
controle de máquinas fora de linha;
regras de compatibilidade entre máquinas e peças;
processo de aprovação de orçamento;
regras reais de pagamento;
necessidade de histórico de alterações;
necessidade de registro de data nas movimentações de estoque;
regras para cancelamento e encerramento de ordens de serviço.

Esses pontos não devem ser tratados como fatos definitivos enquanto não forem confirmados com a empresa.

Caso a pesquisa de campo confirme a necessidade, o modelo lógico poderá ser refinado sem alterar sua estrutura principal.

26. Uso de IA

A Inteligência Artificial foi utilizada como ferramenta de apoio ao desenvolvimento do projeto.

As ferramentas utilizadas foram:

Claude;
ChatGPT.
26.1 Apoio na construção do modelo

A IA foi utilizada para:

organizar ideias;
revisar entidades;
sugerir relacionamentos;
revisar chaves primárias e estrangeiras;
apoiar a elaboração do SQL;
revisar consultas;
estruturar o relatório técnico;
sugerir possibilidades de BI e IA.
26.2 Validação humana

As respostas geradas pela IA não foram aceitas automaticamente.

As sugestões foram comparadas com:

requisitos da atividade;
modelo conceitual;
regras de negócio;
estrutura do banco;
necessidade de validação em campo.

Quando uma sugestão não correspondia ao modelo desenvolvido, ela foi ajustada ou descartada.

26.3 Exemplo de uso

Um exemplo de solicitação feita à IA foi:

Revise o modelo lógico do banco de dados da FELAP e verifique se as tabelas possuem PKs, FKs e relacionamentos coerentes com o modelo conceitual.

A resposta serviu como apoio para identificar pontos de melhoria.

A decisão final sobre o modelo permaneceu baseada nos requisitos da atividade e nas regras do projeto.

27. Reflexão Crítica

A utilização de IA facilitou a organização do projeto e ajudou na identificação de possíveis inconsistências.

Entretanto, foi necessário analisar criticamente as respostas, pois uma sugestão gerada automaticamente pode não representar corretamente a realidade da empresa.

Durante o desenvolvimento, percebeu-se que algumas informações precisam ser confirmadas diretamente na pesquisa de campo antes de serem incorporadas definitivamente ao banco.

Por esse motivo, a IA foi utilizada como ferramenta de apoio e não como fonte única de decisão.

O conhecimento das regras de negócio e a revisão humana continuam sendo necessários para garantir que o banco represente corretamente os processos da FELAP.

28. Conclusão

A Entrega 2 transformou o modelo conceitual da FELAP em uma proposta de modelo lógico relacional composta por 14 tabelas.

Foram definidas:

tabelas;
PKs;
FKs;
relacionamentos;
regras de integridade;
normalização;
dados fictícios;
consultas SQL;
consultas de gestão;
consultas de auditoria;
operações de atualização;
potencial de BI;
possibilidades de utilização de IA.

O modelo foi estruturado para atender aos principais processos identificados na empresa, mantendo separadas as informações de clientes, funcionários, máquinas, locações, vendas, assistência técnica, peças, estoque e pagamentos.

O projeto também foi preparado para futuras evoluções, principalmente após a validação das regras de negócio durante a pesquisa de campo.

Assim, o banco de dados proposto constitui uma base para organização das informações da FELAP e para futuras soluções de análise de dados, BI e Inteligência Artificial.
