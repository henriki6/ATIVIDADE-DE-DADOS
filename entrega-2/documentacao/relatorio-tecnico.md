# Relatório Técnico — Entrega 2
## Projeto de Banco de Dados — FELAP Máquinas e Equipamentos LTDA

---

## 1. Introdução

Este relatório apresenta a evolução do projeto de banco de dados desenvolvido para a empresa FELAP Máquinas e Equipamentos LTDA.

A Entrega 2 tem como objetivo transformar o modelo conceitual desenvolvido anteriormente em um modelo lógico relacional, definindo tabelas, chaves primárias, chaves estrangeiras, restrições de integridade e estruturas necessárias para futura implementação no Sistema Gerenciador de Banco de Dados (SGBD).

Para a implementação foi escolhido o **MySQL 8.0**, devido à sua ampla utilização, suporte a restrições de integridade, facilidade de utilização e compatibilidade com ferramentas acadêmicas e profissionais.

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

O modelo possui **14 entidades/tabelas principais**, responsáveis por representar os dados necessários aos processos de locação, venda, assistência técnica e controle de peças.

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

O campo `forma_pagamento` registra a forma utilizada para realizar o pagamento.

---



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

As PKs são utilizadas para identificar cada registro de forma única dentro de sua respectiva tabela.

---

# 6. Chaves Estrangeiras

As principais chaves estrangeiras são:

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

Os principais relacionamentos do modelo são:

### Cliente → Locação

Um cliente pode possuir várias locações.

**Cardinalidade: 1:N**

### Cliente → Venda

Um cliente pode realizar várias vendas.

**Cardinalidade: 1:N**

### Cliente → Ordem de Serviço

Um cliente pode possuir várias ordens de serviço.

**Cardinalidade: 1:N**

### Funcionário → Locação

Um funcionário pode registrar várias locações.

**Cardinalidade: 1:N**

### Funcionário → Venda

Um funcionário pode registrar várias vendas.

**Cardinalidade: 1:N**

### Funcionário → Ordem de Serviço

Um funcionário pode registrar várias ordens de serviço.

**Cardinalidade: 1:N**

### Marca → Máquina

Uma marca pode possuir várias máquinas cadastradas.

**Cardinalidade: 1:N**

### Categoria → Máquina

Uma categoria pode possuir várias máquinas.

**Cardinalidade: 1:N**

### Locação → Item de Locação

Uma locação pode possuir um ou mais itens de locação.

**Cardinalidade: 1:N**

### Máquina → Item de Locação

Uma máquina pode aparecer em diferentes registros de locação ao longo do tempo.

**Cardinalidade: 1:N**

### Venda → Item de Venda

Uma venda pode possuir um ou mais itens.

**Cardinalidade: 1:N**

### Máquina → Item de Venda

Uma máquina pode ser registrada como item de uma venda.

A regra do projeto considera que uma mesma máquina não deve ser vendida mais de uma vez.

### Máquina → Ordem de Serviço

Uma máquina pode possuir várias ordens de serviço ao longo de sua vida útil.

**Cardinalidade: 1:N**

### Ordem de Serviço → Item de Ordem de Serviço

Uma ordem de serviço pode utilizar várias peças.

**Cardinalidade: 1:N**

### Peça → Item de Ordem de Serviço

Uma peça pode ser utilizada em várias ordens de serviço.

**Cardinalidade: 1:N**

### Peça → Movimentação de Estoque

Uma peça pode possuir várias movimentações de estoque.

**Cardinalidade: 1:N**

### Pagamento

Um pagamento está relacionado a um processo de origem:

- Venda;
- Locação;
- Ordem de Serviço.

A estrutura utiliza três chaves estrangeiras opcionais e uma restrição para garantir que apenas uma origem seja informada por registro de pagamento.

---

# 8. Normalização

A normalização foi aplicada com o objetivo de reduzir redundância, evitar inconsistências e melhorar a organização dos dados.

## 8.1 Primeira Forma Normal — 1FN

A Primeira Forma Normal determina que os atributos devem possuir valores atômicos e que não devem existir grupos repetitivos dentro de uma mesma tabela.

O modelo atende à 1FN porque as informações foram separadas de acordo com suas responsabilidades.

Por exemplo, as peças utilizadas em uma ordem de serviço não são armazenadas em uma única coluna da tabela `ordem_servico`.

Foi criada a tabela:

`item_ordem_servico`

Ela permite registrar:

- a ordem de serviço;
- a peça utilizada;
- a quantidade utilizada.

Dessa forma, uma ordem de serviço pode utilizar várias peças sem criar colunas repetitivas.

---

# 9. Segunda Forma Normal — 2FN

A Segunda Forma Normal exige que os atributos não pertencentes à chave dependam integralmente da chave primária.

No modelo proposto, as informações específicas dos itens foram mantidas nas respectivas tabelas.

Por exemplo:

`item_locacao`

possui:

- id_item_locacao;
- id_locacao;
- id_maquina;
- valor_diaria.

Já as informações do cliente ficam na tabela `cliente`, enquanto as informações da máquina ficam na tabela `maquina`.

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

Ela participa de processos de:

- locação;
- venda;
- assistência técnica;
- controle de disponibilidade;
- manutenção.

Por isso, a entidade `maquina` possui relacionamentos com diferentes processos.

---

## 12.2 Controle de status da máquina

O campo `status` foi mantido na tabela `maquina` para centralizar a situação operacional atual.

Exemplos:

- DISPONIVEL;
- ALUGADA;
- EM_MANUTENCAO;
- VENDIDA;
- INDISPONIVEL.

Isso facilita consultas sobre disponibilidade e situação das máquinas.

---

## 12.3 Separação dos processos

Locação, venda e ordem de serviço foram mantidas em tabelas diferentes.

Essa decisão foi tomada porque cada processo possui características próprias.

A separação facilita:

- consultas;
- manutenção;
- auditoria;
- controle de regras;
- expansão futura do sistema.

---

## 12.4 Uso das tabelas de itens

Foram utilizadas tabelas intermediárias para representar os itens de cada processo:

- `item_locacao`;
- `item_venda`;
- `item_ordem_servico`.

Essa estrutura permite relacionar os processos com máquinas e peças sem duplicar informações.

---

## 12.5 Controle de estoque

A tabela `peca` armazena o estoque atual da peça.

A tabela `movimentacao_estoque` registra entradas e saídas.

Essa separação permite consultar tanto o saldo atual quanto o histórico de movimentações.

---

## 12.6 Integridade dos dados

Foram utilizadas restrições no banco para melhorar a qualidade das informações.

Entre elas:

- PRIMARY KEY;
- FOREIGN KEY;
- UNIQUE;
- CHECK;
- NOT NULL.

Essas restrições ajudam a evitar registros inválidos ou inconsistentes.

---

# 13. Implementação no MySQL 8.0

O banco foi planejado para ser implementado no **MySQL 8.0**.

O script SQL contém:

- criação do banco;
- criação das tabelas;
- definição de PKs;
- definição de FKs;
- restrições de integridade;
- inserção de dados fictícios;
- consultas;
- comandos de atualização;
- comandos de exclusão;
- consultas de gestão;
- consultas de auditoria.

O arquivo SQL está disponível no repositório:

[Script SQL — FELAP Entrega 2](../sql/felap_entrega2_mysql.sql)

---

# 14. Dados Fictícios

Para testar o funcionamento do banco foram utilizados dados fictícios.

A massa de dados contempla exemplos de:

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

Os dados não representam informações pessoais reais de clientes ou funcionários.

O objetivo é permitir a execução das consultas e demonstrar o funcionamento do modelo sem exposição de dados pessoais.

