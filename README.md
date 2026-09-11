## 1. Caracterização da Organização

A organização escolhida é a **FELAP Máquinas e Equipamentos LTDA**, empresa privada com fins lucrativos localizada na cidade de São Paulo/SP, atuante no ramo de máquinas e equipamentos de trabalho.

**Contexto e porte**
A empresa conta com aproximadamente 60 funcionários. Para este trabalho, o grupo optou por delimitar o escopo da modelagem aos setores de **Oficina, Assistência Técnica, Locação de Máquinas e Venda de Máquinas Usadas**, por serem os processos mais relevantes e conhecidos pelo grupo, evitando um modelo excessivamente amplo para esta primeira etapa. As informações da empresa são atualmente controladas pelo sistema **GESCOM**, que organiza os dados separando os módulos de Oficina, Assistência Técnica, Locação e Venda.

**Problemas e necessidades identificados**
- Locação de máquinas que estão fora de linha (descontinuadas) ou sem peças de reposição disponíveis para montagem/manutenção;
- Inconsistências de cadastro e estoque: máquinas que deveriam constar como disponíveis não são localizadas fisicamente ou aparecem como "perdidas" no sistema;
- Falta de integração clara entre o controle de estoque de peças e a disponibilidade real de máquinas para locação.

**Justificativa da escolha**
A empresa foi escolhida por ser o local de trabalho de um dos integrantes do grupo, que possui conhecimento direto dos sistemas internos (GESCOM), dos processos de oficina, locação e estoque, e reconhece as falhas operacionais existentes hoje — o que facilita o levantamento de requisitos e a validação das regras de negócio, mesmo antes da realização da entrevista formal. Além disso, os setores de Oficina, Assistência Técnica e Locação apresentam processos ricos o suficiente para gerar um modelo de dados consistente, com múltiplas entidades e relacionamentos relevantes.

**Evidências da organização**
- Site: [felap.com.br](https://www.felap.com.br)
- Instagram: [@felapmaquinas](https://www.instagram.com/felapmaquinas/)
- Endereço: Av. Alcântara Machado, 190 - Mooca, São Paulo - SP, 03102-000
- Telefone: (11) 3272-7200
- *(a complementar: fotos da visita, nome/cargo do responsável entrevistado e data da entrevista, após a pesquisa de campo)*

---

## 2. Processos de Negócio


**Principais processos mapeados**

Considerando o escopo definido, os processos centrais identificados são:

1. **Locação de máquinas** — do pedido do cliente até a devolução do equipamento.
2. **Oficina / Assistência técnica (ordem de serviço)** — do recebimento da máquina com defeito até a devolução ao cliente, com consumo de peças do estoque.
3. **Venda de máquina usada** — do cadastro da máquina usada até a atualização do estoque após a venda.

### Fluxogramas

#### Fluxo de Oficina / Assistência Técnica

![Fluxo de Oficina / Assistência Técnica](imagens/fluxo-oficina.png)

#### Fluxo de Estoque de Peças

![Fluxo de Estoque de Peças](imagens/fluxo-estoque-pecas.png)

#### Fluxo de Locação de Máquinas

![Fluxo de Locação de Máquinas](imagens/fluxo-locacao.png)



- **Locação de Máquinas:** Cliente solicita locação → Verificação de disponibilidade (modelo, peças, linha ativa) → Registro da locação no GESCOM → Entrega da máquina → Devolução e conferência.
- **Oficina/Assistência Técnica:** Cliente leva a máquina → Abertura da ordem de serviço → Diagnóstico e orçamento → Reparo executado (usa peças do estoque) → Devolução ao cliente.
- **Venda de Máquina Usada:** Máquina usada é cadastrada → Consulta de disponibilidade e preço → Cliente decide a compra → Registro da venda no GESCOM → Atualização do estoque.

---

## 3. Requisitos do Sistema

### 3.1 Requisitos Funcionais

| Código | Requisito funcional |
|--------|---------------------|
| RF01 | O sistema deve permitir cadastrar clientes. |
| RF02 | O sistema deve permitir cadastrar funcionários. |
| RF03 | O sistema deve permitir cadastrar marcas e categorias de máquinas. |
| RF04 | O sistema deve permitir cadastrar máquinas usadas, incluindo se ainda estão em linha (ativas) ou fora de linha (descontinuadas). |
| RF05 | O sistema deve permitir consultar a situação atual de cada máquina (disponível, alugada, vendida, em manutenção ou indisponível/perdida). |
| RF06 | O sistema deve permitir registrar a venda de máquinas usadas. |
| RF07 | O sistema deve permitir registrar locações de máquinas. |
| RF08 | O sistema deve permitir registrar a devolução de máquinas alugadas, com verificação de estado do equipamento. |
| RF09 | O sistema deve permitir cadastrar peças de reposição, vinculadas aos modelos de máquina compatíveis. |
| RF10 | O sistema deve controlar a entrada e a saída de peças do estoque. |
| RF11 | O sistema deve impedir ou alertar a locação de uma máquina fora de linha ou sem peças de reposição compatíveis disponíveis. |
| RF12 | O sistema deve permitir abrir ordens de serviço na oficina/assistência técnica. |
| RF13 | O sistema deve permitir registrar o diagnóstico e o orçamento de uma ordem de serviço. |
| RF14 | O sistema deve permitir registrar as peças utilizadas em uma ordem de serviço, dando baixa automática no estoque. |
| RF15 | O sistema deve permitir consultar o histórico de manutenção de uma máquina. |
| RF16 | O sistema deve permitir registrar pagamentos referentes a vendas, locações e ordens de serviço. |

### 3.2 Requisitos Não Funcionais

| Código | Requisito não funcional |
|--------|--------------------------|
| RNF01 | O sistema deve exigir login para acesso, com controle de permissões por função (técnico, atendente, gerente), como já ocorre no GESCOM. |
| RNF02 | As consultas de disponibilidade de máquina e de peças devem retornar resultado rapidamente, evitando erros de locação por informação desatualizada. |
| RNF03 | A interface deve ser simples e de fácil uso pelos funcionários dos diferentes setores (oficina, locação, vendas). |
| RNF04 | O sistema deve manter os dados armazenados de forma organizada, íntegra e segura. |
| RNF05 | O sistema deve permitir a realização de cópias de segurança periódicas. |
| RNF06 | O sistema deve evitar o cadastro duplicado de máquinas pelo número de série. |
| RNF07 | O sistema deve manter consistência entre o cadastro de máquinas e o estoque físico, para reduzir casos de máquina "perdida" ou não localizada. |

---

## 4. Regras de Negócio

**Regras operacionais**

- Cada máquina deve possuir um número de série único, que a identifica no sistema.
- Uma máquina só pode ser alugada se estiver com status "disponível", não estando fora de linha nem faltando peças essenciais para uso.
- Uma máquina fora de linha (descontinuada) só pode ser locada mediante confirmação manual de um responsável, registrando a exceção.
- Uma máquina devolvida com defeito deve ser automaticamente encaminhada para abertura de ordem de serviço na oficina.
- Uma locação deve possuir data de retirada e data prevista de devolução.
- Uma máquina não pode constar simultaneamente como "alugada" e "disponível para venda".
- Uma ordem de serviço deve estar sempre associada a uma máquina e a um cliente.
- Uma ordem de serviço pode utilizar uma ou várias peças; cada peça utilizada deve gerar automaticamente uma saída no estoque.
- A quantidade de peças em estoque não pode ficar negativa; se uma peça necessária não estiver disponível, a ordem de serviço deve ser sinalizada como "aguardando peça".
- O cliente deve aprovar o orçamento antes da execução do reparo.
- Uma máquina usada só pode ser vendida se não estiver alugada nem em processo de manutenção.
- Após a venda de uma máquina usada, seu status deve ser atualizado para "vendida", removendo-a da disponibilidade de locação.
- Toda movimentação de estoque (entrada/saída de peça) deve ser registrada com data, tipo e quantidade, para permitir auditoria e localizar divergências entre estoque físico e sistema.

**Restrições organizacionais**

- O acesso ao sistema é restrito por função (técnico, atendente, gerente), conforme já implementado no GESCOM — o modelo de dados deve prever essa distinção de perfis.
- A separação dos módulos de Oficina, Assistência Técnica, Locação e Venda no GESCOM atual reforça a necessidade de um modelo relacional que integre essas informações sem duplicar cadastros (ex.: um único cadastro de Cliente e de Máquina compartilhado entre os módulos).
- Informações de clientes e funcionários reais não podem ser expostas no trabalho — todos os exemplos usados no dicionário de dados e no DER devem ser fictícios.

---

## 5. Dicionário de Dados Conceitual (Preliminar)

**Entidade: Cliente**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código do cliente | Identificação do cliente no sistema | Deve ser único |
| Nome | Nome do cliente (pessoa física ou jurídica) | Campo obrigatório |
| CPF/CNPJ | Documento de identificação | Deve ser único; exemplo fictício |
| Telefone | Contato do cliente | Campo obrigatório |
| Endereço | Endereço do cliente | Opcional |

**Entidade: Funcionário**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código do funcionário | Identificação no sistema | Deve ser único |
| Nome | Nome do funcionário | Campo obrigatório |
| Cargo/função | Define o perfil de acesso (técnico, atendente, gerente) | Usado para controle de permissões no sistema |
| Telefone | Contato interno | Opcional |

**Entidade: Marca**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da marca | Identificação da marca | Deve ser único |
| Nome | Nome do fabricante (ex.: Makita, Bosch, DeWalt) | Campo obrigatório |

**Entidade: Categoria**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da categoria | Identificação da categoria | Deve ser único |
| Descrição | Tipo de máquina (furadeira, serra, compressor etc.) | Campo obrigatório |

**Entidade: Máquina**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da máquina | Identificação no sistema | Deve ser único |
| Modelo | Modelo comercial do equipamento | Campo obrigatório |
| Número de série | Identificação do fabricante | Não pode ser repetido |
| Situação de linha | Indica se o modelo está ativo ou fora de linha | Usado para bloquear ou alertar locação |
| Status | Situação atual: disponível, alugada, vendida, em manutenção, indisponível | Não pode assumir dois status simultâneos |
| Valor de venda | Preço de venda, se aplicável | Obrigatório para máquinas à venda |
| Valor da diária | Preço de locação por dia | Obrigatório para máquinas alugáveis |

**Entidade: Locação**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da locação | Identificação do contrato de locação | Deve ser único |
| Data de retirada | Data em que a máquina foi entregue ao cliente | Obrigatória |
| Data prevista de devolução | Data combinada para devolução | Obrigatória |
| Data de devolução real | Data em que a máquina retornou de fato | Preenchida no encerramento |
| Status | Situação da locação (em andamento, concluída, atrasada) | Atualizado conforme a devolução |

**Entidade: Item de Locação**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código do item | Identificação do item dentro da locação | Deve ser único |
| Valor da diária aplicado | Valor cobrado por dia para essa máquina específica | Pode variar conforme negociação |

**Entidade: Venda**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da venda | Identificação da venda | Deve ser único |
| Data | Data em que a venda foi realizada | Obrigatória |
| Valor total | Soma dos itens vendidos | Deve ser maior que zero |

**Entidade: Item de Venda**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código do item | Identificação do item dentro da venda | Deve ser único |
| Valor de venda aplicado | Valor final negociado para a máquina | Deve ser maior que zero |

**Entidade: Ordem de Serviço**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da ordem | Identificação da ordem de serviço | Deve ser único |
| Data de entrada | Data em que a máquina chegou para avaliação | Obrigatória |
| Data de saída | Data em que a máquina foi devolvida | Preenchida no encerramento |
| Diagnóstico | Descrição do problema identificado | Preenchido pelo técnico |
| Status | Aguardando peça, em execução, concluída ou cancelada | Só pode ser encerrada quando concluída ou cancelada |
| Valor do orçamento | Valor estimado do reparo | Deve ser aprovado pelo cliente antes da execução |

**Entidade: Item de Ordem de Serviço**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código do item | Identificação do item dentro da ordem de serviço | Deve ser único |
| Quantidade utilizada | Quantidade da peça usada no reparo | Deve gerar saída correspondente no estoque |

**Entidade: Peça**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da peça | Identificação da peça | Deve ser único |
| Descrição | Nome/descrição da peça | Campo obrigatório |
| Preço | Valor unitário da peça | Deve ser maior que zero |
| Quantidade em estoque | Saldo atual disponível | Não pode ficar negativa |
| Estoque mínimo | Quantidade mínima antes de gerar alerta de reposição | Usado para controle de compras |

**Entidade: Movimentação de Estoque**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código da movimentação | Identificação do registro | Deve ser único |
| Tipo | Entrada ou saída de peça | Campo obrigatório |
| Quantidade | Quantidade movimentada | Deve ser maior que zero |
| Data | Data da movimentação | Obrigatória |
| Motivo | Ex.: uso em manutenção, reposição de estoque | Usado para auditoria de divergências |

**Entidade: Pagamento**

| Atributo | Descrição | Regra de negócio associada |
|----------|-----------|------------------------------|
| Código do pagamento | Identificação do pagamento | Deve ser único |
| Valor | Valor pago | Deve ser maior que zero |
| Forma de pagamento | Dinheiro, cartão, PIX, boleto etc. | Campo obrigatório |
| Data | Data do pagamento | Obrigatória |

---

## 6. Modelagem Conceitual (Entidades, Atributos, Relacionamentos)

**Entidades reconhecidas**

| Entidade | Justificativa |
|----------|----------------|
| Cliente | Pessoa que aluga máquinas, compra máquinas usadas ou leva equipamentos para manutenção. |
| Funcionário | Responsável por registrar locações, vendas e ordens de serviço, ou por executar o reparo (técnico). |
| Marca | Fabricante da máquina (Makita, DeWalt, Bosch etc.), necessária para classificação e busca de peças compatíveis. |
| Categoria | Tipo de máquina (furadeira, serra, compressor etc.), útil para organizar o estoque e o cadastro. |
| Máquina | Equipamento usado que pode ser alugado, vendido ou levado à oficina — entidade central do modelo. |
| Locação | Registro de um contrato de aluguel de uma ou mais máquinas. |
| Item de Locação | Detalha qual(is) máquina(s) fazem parte de uma locação específica. |
| Venda | Registro da venda de uma máquina usada. |
| Item de Venda | Detalha qual máquina foi vendida em uma venda. |
| Ordem de Serviço | Registro de um atendimento da oficina/assistência técnica, do diagnóstico até a devolução. |
| Item de Ordem de Serviço | Detalha quais peças foram utilizadas em uma ordem de serviço. |
| Peça | Componente de reposição usado em manutenções, com controle próprio de estoque. |
| Movimentação de Estoque | Registra entradas e saídas de peças, essencial para rastrear divergências de estoque. |
| Pagamento | Registro de valores recebidos, associado a uma venda, locação ou ordem de serviço. |

**Relacionamentos pertinentes**

- Cliente **1:N** Locação / Cliente **1:N** Venda / Cliente **1:N** Ordem de Serviço
- Funcionário **1:N** Locação / Funcionário **1:N** Venda / Funcionário **1:N** Ordem de Serviço
- Marca **1:N** Máquina / Categoria **1:N** Máquina
- Locação **1:N** Item de Locação / Máquina **1:N** Item de Locação
- Venda **1:N** Item de Venda / Máquina **1:1** Item de Venda
- Máquina **1:N** Ordem de Serviço
- Ordem de Serviço **1:N** Item de Ordem de Serviço / Peça **1:N** Item de Ordem de Serviço
- Peça **1:N** Movimentação de Estoque
- Pagamento associado, conforme o caso, a uma Venda, uma Locação ou uma Ordem de Serviço (**1:1**, apontando para apenas uma origem por pagamento)

**Restrições e políticas organizacionais aplicadas ao modelo**

- O status da Máquina (disponível, alugada, vendida, em manutenção, indisponível) é compartilhado entre os três processos, evitando que a mesma máquina apareça, por exemplo, como disponível para locação e para venda ao mesmo tempo — atacando diretamente o problema de máquinas "perdidas" relatado pelo grupo.
- A entidade Peça e a Movimentação de Estoque existem separadamente para permitir rastrear historicamente entradas e saídas, e não apenas a quantidade atual — o que ajuda a investigar divergências de estoque.
- A separação entre Locação/Venda/Ordem de Serviço e seus respectivos "Itens" permite que uma locação ou ordem de serviço envolva mais de uma máquina ou peça sem duplicar dados.

---

## 7. Diagrama Entidade-Relacionamento (DER)

![Diagrama Entidade-Relacionamento](DER/DER.png)

O diagrama representa as 14 entidades identificadas na modelagem conceitual, com seus principais atributos e as cardinalidades entre os relacionamentos (1:1 e 1:N). A entidade **Máquina** ocupa posição central, conectando-se aos processos de Locação, Venda e Ordem de Serviço, o que reflete a realidade observada na FELAP: uma mesma máquina passa por diferentes ciclos (disponível → alugada/vendida → em manutenção) ao longo do tempo.

---

## 8. Justificativa Técnica

A modelagem partiu de um princípio central: a entidade **Máquina** é o ativo que mais transita entre os processos da empresa (locação, venda e manutenção), então ela foi posicionada como núcleo do modelo, compartilhando um único atributo de **status** entre todos os processos. Essa decisão foi tomada justamente para atacar o problema relatado pelo grupo — máquinas que aparecem como "perdidas" ou indisponíveis por falta de integração entre os controles de locação, venda e oficina. Se cada processo tivesse seu próprio controle de disponibilidade, o risco de inconsistência (a mesma máquina "disponível" em um módulo e "alugada" em outro) seria ainda maior do que o observado hoje no GESCOM.

O atributo **situação de linha** na entidade Máquina foi incluído especificamente para resolver o segundo problema relatado: locações de máquinas fora de linha, sem peça de reposição compatível. Combinado ao relacionamento **Peça–Item de Ordem de Serviço**, esse atributo permite, em etapas futuras do sistema, verificar automaticamente se existe peça de reposição disponível antes de autorizar uma locação ou reparo.

A separação entre **Locação/Venda/Ordem de Serviço** e suas respectivas entidades de "Item" (Item de Locação, Item de Venda, Item de Ordem de Serviço) foi escolhida em vez de um modelo mais simples, com apenas uma tabela por processo, porque uma única locação ou ordem de serviço pode envolver mais de uma máquina ou peça. Uma alternativa mais simples — uma única entidade genérica de "Transação" cobrindo venda, locação e ordem de serviço — foi descartada, pois cada um desses processos tem atributos muito distintos entre si (datas de devolução, diagnóstico técnico, valor de diária), o que geraria uma tabela com muitos campos nulos e regras de negócio confusas.

A entidade **Movimentação de Estoque** foi separada da entidade **Peça** para manter um histórico de entradas e saídas, em vez de armazenar apenas a quantidade atual em estoque. Essa escolha foi motivada diretamente pelo problema de divergência de estoque relatado: sem um histórico de movimentações, seria impossível auditar onde uma peça "sumiu" do sistema.

Por fim, a entidade **Pagamento** foi modelada como podendo se relacionar (de forma exclusiva) com Venda, Locação ou Ordem de Serviço, e não com uma tabela unificada de "Transação", para manter a rastreabilidade de a qual processo específico cada pagamento pertence — refletindo a própria separação de módulos existente hoje no sistema GESCOM da empresa.

As cardinalidades adotadas (majoritariamente 1:N entre Cliente/Funcionário e os processos, e 1:1 entre Máquina e Item de Venda) refletem as regras reais da operação: um cliente pode ter várias locações, vendas e ordens de serviço ao longo do tempo, mas uma máquina usada, uma vez vendida, corresponde a um único item de venda.

---

## 9. Uso de Inteligência Artificial

O grupo utilizou a IA **Claude (Anthropic)** em diferentes etapas do trabalho, conforme registrado abaixo.

**Uso 1 — Estruturação inicial (antes do roteiro do professor)**

| Item | Registro |
|------|------------------|
| Ferramenta e etapa | Claude — ideação inicial de slides e de um diagrama de banco de dados para uma empresa genérica de máquinas e equipamentos |
| Motivação | Organizar ideias iniciais sobre entidades e processos antes de ter acesso ao roteiro exato da disciplina |
| Prompt(s) utilizados | Pedido de apresentação de slides e diagrama de banco de dados para uma empresa fictícia de máquinas e equipamentos, com locação, estoque de peças, venda de máquinas novas/usadas e assistência técnica |
| Resposta recebida | Estrutura de slides, lista de entidades genéricas (Cliente, Máquina, Venda, Locação, Peça, Ordem de Serviço) e um diagrama já em formato de modelo lógico, com PK e FK |
| Fontes consultadas e verificadas | Não se aplica — resposta baseada em conhecimento geral de modelagem de dados |
| Trechos rejeitados ou corrigidos | O nome fictício de empresa ("Máquinas Forte Ltda.") foi rejeitado, pois o roteiro exige uma organização real; o diagrama com PK e FK foi rejeitado nesta etapa, por ser Modelo Conceitual e não Lógico |
| Justificativa da escolha final | Mantidas apenas as entidades e processos compatíveis com a realidade observada na FELAP, descartando os elementos técnicos do modelo lógico |
| Reflexão crítica | A resposta inicial foi genérica e não considerava os processos reais de nenhuma empresa específica; serviu apenas como ponto de partida para a estrutura do trabalho |

**Uso 2 — Adaptação do modelo para a FELAP e construção das Etapas 3 a 8 do README**

| Item | Registro |
|------|------------------|
| Ferramenta e etapa | Claude — definição de requisitos funcionais/não funcionais, regras de negócio, entidades/atributos/relacionamentos, dicionário de dados, DER conceitual e justificativa técnica |
| Motivação | Organizar, junto com o conhecimento de um integrante que trabalha na FELAP, as informações da empresa no formato exigido pelo roteiro do professor |
| Prompt(s) utilizados | Informações fornecidas pelo integrante sobre a FELAP (setores, sistema GESCOM, problema de locação de máquina fora de linha/sem peça, problema de estoque e máquina "perdida"), com pedido de continuidade do trabalho etapa por etapa |
| Resposta recebida | Requisitos funcionais e não funcionais, regras de negócio, lista de entidades/atributos/relacionamentos, dicionário de dados, diagrama DER conceitual e texto de justificativa técnica |
| Fontes consultadas e verificadas | As informações usadas vieram do conhecimento direto do integrante sobre os sistemas e processos internos da empresa, e não de pesquisa externa; serão confirmadas e complementadas na entrevista de campo |
| Trechos rejeitados ou corrigidos | Setores fora do escopo definido pelo grupo (venda de máquinas novas e peças avulsas como processo central) foram removidos das entidades/processos, por decisão do grupo, para não tornar o modelo grande demais |
| Justificativa da escolha final | O modelo apresentado refletiu de forma coerente os processos e problemas reais relatados pelo integrante, sendo adotado como base do trabalho, sujeito a validação na entrevista formal com a empresa |
| Reflexão crítica | Como a IA não tem acesso direto à empresa, todas as regras de negócio e a modelagem ainda precisam ser confirmadas na pesquisa de campo (entrevista) antes da entrega final, para evitar que suposições geradas pela IA sejam tratadas como fato confirmado sem validação |
