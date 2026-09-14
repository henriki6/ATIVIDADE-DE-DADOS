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

---

# 15. Consultas SQL

O banco possui consultas para demonstrar o relacionamento entre as tabelas.

Entre os exemplos estão consultas utilizando `JOIN`.

### Exemplo: máquinas com marca e categoria

```sql
SELECT
    m.id_maquina,
    m.modelo,
    m.numero_serie,
    ma.nome AS marca,
    c.descricao AS categoria,
    m.status
FROM maquina m
INNER JOIN marca ma
    ON m.id_marca = ma.id_marca
INNER JOIN categoria c
    ON m.id_categoria = c.id_categoria;
16. Consultas de Gestão

As consultas de gestão têm como objetivo transformar os dados operacionais em informações úteis para tomada de decisão.

Exemplos de análises:

máquinas disponíveis;
máquinas alugadas;
máquinas em manutenção;
máquinas vendidas;
quantidade de peças em estoque;
peças mais utilizadas;
ordens de serviço abertas;
vendas realizadas;
locações realizadas;
pagamentos registrados.

Essas consultas podem auxiliar os gestores da FELAP no acompanhamento das operações.

17. Consultas de Auditoria

As consultas de auditoria têm como objetivo identificar situações que possam representar inconsistências ou necessidade de verificação.

Exemplos:

máquinas com status de manutenção;
peças com estoque reduzido;
máquinas vendidas;
movimentações de entrada e saída;
ordens de serviço abertas;
pagamentos associados aos processos;
registros que possam exigir conferência administrativa.

A auditoria contribui para melhorar o controle operacional e a confiabilidade das informações.


18. Operações UPDATE e DELETE

O script também contempla comandos de alteração e exclusão de registros.

O comando UPDATE demonstra a atualização controlada de informações.

Exemplo: UPDATE peca
SET quantidade_estoque = quantidade_estoque + 10
WHERE id_peca = 1;

O comando DELETE deve ser utilizado com cuidado, principalmente em tabelas relacionadas por chaves estrangeiras.

Por isso, no script acadêmico, os exemplos de exclusão são apresentados de forma controlada e devem ser executados somente quando não houver dependências que impeçam a operação.

19. Potencial de BI

Os dados estruturados pelo banco podem futuramente ser utilizados em uma solução de Business Intelligence (BI).

A integração com uma ferramenta de BI permitiria transformar os dados operacionais em indicadores e painéis gerenciais.

19.1 Informações estratégicas

Entre as informações que poderiam ser acompanhadas estão:

faturamento de vendas;
faturamento de locações;
quantidade de máquinas disponíveis;
quantidade de máquinas alugadas;
quantidade de máquinas em manutenção;
quantidade de máquinas vendidas;
quantidade de ordens de serviço;
consumo de peças;
situação do estoque.
20. Indicadores de Desempenho — KPIs

Alguns KPIs que podem ser utilizados são:

KPI 1 — Faturamento de vendas

Representa o valor total das vendas realizadas.

KPI 2 — Receita de locações

Permite acompanhar os valores relacionados às locações.

KPI 3 — Máquinas em manutenção

Indica quantas máquinas estão atualmente em manutenção.

KPI 4 — Peças mais utilizadas

Permite identificar quais peças possuem maior consumo nas ordens de serviço.

KPI 5 — Estoque

Permite acompanhar a quantidade disponível de cada peça.

KPI 6 — Ordens de serviço

Permite acompanhar a quantidade e situação das ordens de serviço.

21. Possibilidades de Inteligência Artificial

A estrutura do banco também pode futuramente servir como fonte de dados para aplicações de Inteligência Artificial.

A IA não substitui o banco de dados. Ela pode utilizar os dados armazenados para realizar análises e gerar recomendações.

21.1 Manutenção Preditiva

Com histórico suficiente de manutenção, seria possível utilizar modelos de IA para identificar padrões relacionados às falhas das máquinas.

Uma aplicação futura poderia estimar quais máquinas possuem maior probabilidade de necessitar de manutenção.

21.2 Previsão de Estoque

A IA poderia analisar:

histórico de consumo;
quantidade de peças utilizadas;
frequência das ordens de serviço;
movimentações de estoque.

Com isso, poderia auxiliar na previsão de necessidade de reposição.

21.3 Recomendação de Estoque

Uma aplicação de IA poderia recomendar quais peças deveriam receber maior prioridade de reposição.

Por exemplo:

Uma peça apresenta consumo elevado e estoque reduzido. O sistema pode recomendar a reposição antes que o estoque se esgote.

21.4 Análise de Locação

A análise dos históricos de locação poderia identificar:

máquinas mais procuradas;
períodos de maior demanda;
modelos com maior utilização;
máquinas com baixa utilização.
Essas informações poderiam auxiliar decisões relacionadas à aquisição e disponibilidade de equipamentos.

22. Arquitetura Proposta de BI e IA

A arquitetura futura pode ser representada da seguinte forma:

BANCO DE DADOS FELAP
        |
        v
     ETL / ELT
        |
        v
   DATA WAREHOUSE
        |
        +--------------------+
        |                    |
        v                    v
       BI                    IA
        |                    |
        v                    v
 DASHBOARDS             MODELOS ANALÍTICOS
        |                    |
        v                    v
 INDICADORES             PREVISÕES
 E KPIs                  E RECOMENDAÇÕES

O banco operacional seria a fonte dos dados.

Os dados poderiam passar por um processo de ETL/ELT e posteriormente alimentar uma estrutura analítica.

A ferramenta de BI poderia apresentar dashboards para os gestores, enquanto modelos de IA poderiam realizar previsões e recomendações.

23. Benefícios Esperados para a FELAP

A implantação do banco de dados pode proporcionar:

maior organização das informações;
redução de duplicidade de dados;
maior controle das máquinas;
melhor acompanhamento das locações;
melhor controle das vendas;
acompanhamento das ordens de serviço;
maior controle do estoque;
histórico das movimentações;
facilidade para geração de relatórios;
suporte à tomada de decisões.

Em uma etapa futura, a integração com BI e IA poderá ampliar ainda mais o valor dos dados.

24. Regras de Negócio Consideradas

O modelo lógico considera as principais regras identificadas na Entrega 1.

Entre elas:

O número de série da máquina deve ser único.
Uma máquina não deve ser cadastrada duas vezes.
Máquinas alugadas devem possuir controle de disponibilidade.
Máquinas em manutenção devem ser identificadas pelo status.
Máquinas vendidas não devem continuar disponíveis para locação.
Ordens de serviço devem estar relacionadas a um cliente e a uma máquina.
Uma ordem de serviço pode utilizar várias peças.
A utilização de peças deve ser relacionada ao controle de estoque.
O estoque não deve possuir quantidade negativa.
As movimentações de estoque devem ser registradas.
Os processos devem possuir funcionários responsáveis.
Os pagamentos devem estar relacionados a um processo de origem.
Os dados dos clientes devem ser tratados com segurança.
O acesso às informações deve respeitar as permissões definidas pelo sistema.
25. Pontos de Validação e Evolução

Como o projeto está relacionado a uma empresa real, algumas regras ainda dependem da validação da pesquisa de campo.

Entre os pontos que devem ser confirmados estão:

funcionamento real do sistema GESCOM;
regras internas de locação;
critérios utilizados para definir uma máquina como fora de linha;
processo real de aprovação de orçamento;
processo de movimentação de estoque;
regras para compatibilidade entre máquinas e peças;
responsáveis por cada etapa dos processos;
regras de pagamento utilizadas pela empresa.

Essas informações poderão gerar ajustes no modelo lógico e na implementação final.

26. Uso de Inteligência Artificial no Desenvolvimento

A Inteligência Artificial foi utilizada como ferramenta de apoio durante o desenvolvimento do projeto.

As ferramentas utilizadas foram:

Claude;
ChatGPT.

A utilização ocorreu principalmente para:

levantamento inicial de ideias;
organização dos requisitos;
revisão da estrutura do banco;
apoio na definição das tabelas;
análise de relacionamentos;
elaboração do modelo lógico;
apoio na criação do script SQL;
revisão da normalização;
identificação de possíveis inconsistências;
elaboração das possibilidades de BI e IA.

As respostas geradas pelas ferramentas não foram consideradas automaticamente corretas.

As sugestões foram analisadas pelos integrantes do projeto e comparadas com:

requisitos da atividade;
modelo conceitual;
regras de negócio;
informações levantadas sobre a organização;
coerência técnica do banco.

Quando uma sugestão não estava de acordo com o projeto, ela foi modificada ou descartada.

27. Reflexão Crítica sobre o Uso de IA

A utilização de IA contribuiu para acelerar a elaboração e revisão do projeto, principalmente em tarefas de organização, documentação e desenvolvimento do SQL.

Entretanto, a IA não substituiu a análise dos integrantes do grupo.

Foi necessário revisar as respostas, pois algumas sugestões poderiam não representar exatamente a realidade da FELAP ou poderiam gerar inconsistências entre o modelo conceitual, o modelo lógico e as regras de negócio.

Dessa forma, a IA foi utilizada como ferramenta de apoio e não como fonte única de decisão.

A validação humana permaneceu necessária durante todo o desenvolvimento.

28. Conclusão

A Entrega 2 permitiu transformar o modelo conceitual desenvolvido anteriormente em uma estrutura lógica preparada para implementação em banco de dados relacional.

O modelo foi organizado em 14 tabelas, com definição de chaves primárias, chaves estrangeiras, restrições de integridade e normalização até a Terceira Forma Normal.

Também foi desenvolvido um script SQL para o MySQL 8.0, contendo a estrutura do banco, dados fictícios e consultas para demonstrar seu funcionamento.

Além do armazenamento dos dados, o projeto demonstra que as informações geradas pelos processos da FELAP podem futuramente ser utilizadas em soluções de BI e Inteligência Artificial.

A solução proposta busca oferecer uma estrutura organizada, consistente e preparada para futuras evoluções do sistema de gestão da empresa.
