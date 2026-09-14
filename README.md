# Projeto de Banco de Dados — FELAP Máquinas e Equipamentos LTDA

## 1. Caracterização da Organização

A organização escolhida é a **FELAP Máquinas e Equipamentos LTDA**, empresa privada com fins lucrativos localizada na cidade de São Paulo/SP, atuante no ramo de máquinas e equipamentos de trabalho.

### Contexto e porte

A empresa conta com aproximadamente 60 funcionários. Para este trabalho, o grupo optou por delimitar o escopo da modelagem aos setores de **Oficina, Assistência Técnica, Locação de Máquinas e Venda de Máquinas Usadas**, por serem os processos mais relevantes e conhecidos pelo grupo, evitando um modelo excessivamente amplo nesta primeira etapa.

As informações da empresa são atualmente controladas pelo sistema **GESCOM**, que organiza os dados separando os módulos de Oficina, Assistência Técnica, Locação e Venda.

### Problemas e necessidades identificados

* Locação de máquinas que estão fora de linha (descontinuadas) ou sem peças de reposição disponíveis para montagem/manutenção;
* Inconsistências de cadastro e estoque: máquinas que deveriam constar como disponíveis não são localizadas fisicamente ou aparecem como "perdidas" no sistema;
* Falta de integração clara entre o controle de estoque de peças e a disponibilidade real de máquinas para locação.

### Justificativa da escolha

A empresa foi escolhida por ser o local de trabalho de um dos integrantes do grupo, que possui conhecimento direto dos sistemas internos (GESCOM), dos processos de oficina, locação e estoque, e reconhece as falhas operacionais existentes atualmente.

Esse conhecimento facilita o levantamento inicial dos requisitos e das regras de negócio, mesmo antes da realização da entrevista formal. A pesquisa de campo será utilizada posteriormente para confirmar, corrigir e complementar as informações levantadas.

Além disso, os setores de Oficina, Assistência Técnica e Locação apresentam processos suficientemente relevantes para gerar um modelo de dados consistente, com múltiplas entidades e relacionamentos.

### Evidências da organização

* Site: https://www.felap.com.br
* Instagram: https://www.instagram.com/felapmaquinas/
* Endereço: Av. Alcântara Machado, 190 - Mooca, São Paulo - SP, 03102-000
* Telefone: (11) 3272-7200
* **A complementar após a pesquisa de campo:** fotos da visita, nome/cargo do responsável entrevistado e data da entrevista.

---

## 2. Processos de Negócio

Considerando o escopo definido, os processos centrais identificados são:

1. **Locação de máquinas** — do pedido do cliente até a devolução do equipamento.
2. **Oficina / Assistência Técnica** — do recebimento da máquina para manutenção até a devolução ao cliente.
3. **Venda de máquina usada** — do cadastro da máquina até o registro da venda e atualização de sua situação.

### Fluxogramas



![Fluxo de Oficina / Assistência Técnica](imagens/fluxo-oficina.png)



![Fluxo de Estoque de Peças](imagens/fluxo-estoque-pecas.png)



![Fluxo de Locação de Máquinas](imagens/fluxo-locacao.png)

### Resumo dos processos

* **Locação de Máquinas:** Cliente solicita locação → verificação da situação da máquina → registro da locação → entrega da máquina → devolução e conferência.

* **Oficina/Assistência Técnica:** Cliente leva a máquina → abertura da ordem de serviço → diagnóstico e orçamento → aprovação → reparo → utilização de peças quando necessário → devolução ao cliente.

* **Venda de Máquina Usada:** Máquina disponível para venda → consulta da situação e valor → cliente decide a compra → registro da venda → atualização da situação da máquina.

---

## 3. Requisitos do Sistema

### 3.1 Requisitos Funcionais

| Código | Requisito funcional                                                                                                                                                    |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| RF01   | O sistema deve permitir cadastrar clientes.                                                                                                                            |
| RF02   | O sistema deve permitir cadastrar funcionários.                                                                                                                        |
| RF03   | O sistema deve permitir cadastrar marcas e categorias de máquinas.                                                                                                     |
| RF04   | O sistema deve permitir cadastrar máquinas usadas, identificando se o modelo está em linha ou fora de linha.                                                           |
| RF05   | O sistema deve permitir consultar a situação atual de cada máquina (disponível, alugada, vendida, em manutenção ou indisponível).                                      |
| RF06   | O sistema deve permitir registrar a venda de máquinas usadas.                                                                                                          |
| RF07   | O sistema deve permitir registrar locações de máquinas.                                                                                                                |
| RF08   | O sistema deve permitir registrar a devolução de máquinas alugadas e verificar sua condição.                                                                           |
| RF09   | O sistema deve controlar a entrada e a saída de peças do estoque.                                                                                                      |
| RF10   | O sistema deve alertar ou impedir a locação de uma máquina fora de linha quando houver restrição operacional relacionada à sua manutenção ou disponibilidade de peças. |
| RF11   | O sistema deve permitir abrir ordens de serviço na oficina/assistência técnica.                                                                                        |
| RF12   | O sistema deve permitir registrar o diagnóstico e o orçamento de uma ordem de serviço.                                                                                 |
| RF13   | O sistema deve permitir registrar as peças utilizadas em uma ordem de serviço, relacionando o consumo ao estoque.                                                      |
| RF14   | O sistema deve permitir consultar o histórico de manutenção de uma máquina.                                                                                            |
| RF15   | O sistema deve permitir registrar pagamentos referentes a vendas, locações e ordens de serviço.                                                                        |

### 3.2 Requisitos Não Funcionais

| Código | Requisito não funcional                                                                                                                                    |
| ------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| RNF01  | O sistema deve exigir login para acesso, com controle de permissões por função (técnico, atendente e gerente), conforme a organização utilizada no GESCOM. |
| RNF02  | As consultas de disponibilidade de máquinas e peças devem apresentar resultados rapidamente, reduzindo o risco de informações desatualizadas.              |
| RNF03  | A interface deve ser simples e de fácil utilização pelos funcionários dos diferentes setores.                                                              |
| RNF04  | O sistema deve manter os dados armazenados de forma organizada, íntegra e segura.                                                                          |
| RNF05  | O sistema deve permitir a realização de cópias de segurança periódicas.                                                                                    |
| RNF06  | O sistema deve evitar o cadastro duplicado de máquinas pelo número de série.                                                                               |
| RNF07  | O sistema deve manter consistência entre o cadastro das máquinas e as informações de estoque e disponibilidade.                                            |

---

## 4. Regras de Negócio

### Regras operacionais

* Cada máquina deve possuir um número de série único, utilizado para sua identificação.
* Uma máquina somente deve ser alugada quando estiver com situação **disponível**.
* Máquinas fora de linha devem receber uma verificação adicional antes da locação.
* Quando uma máquina devolvida apresentar defeito, ela deve ser encaminhada para avaliação e possível abertura de ordem de serviço.
* Uma locação deve possuir data de retirada e data prevista de devolução.
* Uma máquina não pode estar simultaneamente com situação de **alugada** e disponível para venda.
* Uma ordem de serviço deve estar associada a uma máquina e a um cliente.
* Uma ordem de serviço pode utilizar uma ou várias peças.
* Toda peça utilizada em uma ordem de serviço deve gerar uma movimentação de saída no estoque.
* A quantidade disponível de uma peça não pode ficar negativa.
* Quando uma peça necessária não estiver disponível, a ordem de serviço deve poder ser sinalizada como **aguardando peça**.
* O cliente deve aprovar o orçamento antes da execução do reparo.
* Uma máquina usada somente pode ser vendida quando não estiver alugada ou em processo de manutenção.
* Após a venda, a situação da máquina deve ser atualizada para **vendida**.
* Toda movimentação de estoque deve ser registrada com data, tipo e quantidade, permitindo auditoria das entradas e saídas.

### Restrições organizacionais

* O acesso ao sistema deve ser restrito de acordo com a função do funcionário.
* O modelo deve utilizar um cadastro único de Cliente e Máquina, evitando duplicação de informações entre os módulos.
* As informações dos processos de Oficina, Assistência Técnica, Locação e Venda devem ser relacionadas por meio das entidades compartilhadas.
* Informações reais de clientes e funcionários não devem ser expostas no trabalho. Os exemplos utilizados devem ser fictícios.
* Regras específicas sobre compatibilidade entre modelos de máquinas e peças deverão ser confirmadas na pesquisa de campo antes da implementação definitiva.

---

## 5. Dicionário de Dados Conceitual

O dicionário abaixo representa os principais atributos considerados na etapa conceitual. Os identificadores e chaves estrangeiras serão definidos detalhadamente na etapa do **Modelo Lógico**.

### Entidade: Cliente

| Atributo | Descrição                                  | Regra de negócio associada                          |
| -------- | ------------------------------------------ | --------------------------------------------------- |
| Nome     | Nome do cliente, pessoa física ou jurídica | Campo obrigatório                                   |
| CPF/CNPJ | Documento de identificação                 | Deve ser único; utilizar somente exemplos fictícios |
| Telefone | Telefone para contato                      | Campo obrigatório                                   |
| Endereço | Endereço do cliente                        | Pode ser informado conforme necessidade do processo |

### Entidade: Funcionário

| Atributo     | Descrição                        | Regra de negócio associada                    |
| ------------ | -------------------------------- | --------------------------------------------- |
| Nome         | Nome do funcionário              | Campo obrigatório                             |
| Cargo/função | Função exercida pelo funcionário | Deve permitir identificar o perfil de atuação |

### Entidade: Marca

| Atributo | Descrição                     | Regra de negócio associada |
| -------- | ----------------------------- | -------------------------- |
| Nome     | Nome do fabricante da máquina | Campo obrigatório          |

### Entidade: Categoria

| Atributo  | Descrição                    | Regra de negócio associada |
| --------- | ---------------------------- | -------------------------- |
| Descrição | Tipo ou categoria da máquina | Campo obrigatório          |

### Entidade: Máquina

| Atributo          | Descrição                                         | Regra de negócio associada                 |
| ----------------- | ------------------------------------------------- | ------------------------------------------ |
| Modelo            | Modelo comercial do equipamento                   | Campo obrigatório                          |
| Número de série   | Identificação individual da máquina               | Não pode ser repetido                      |
| Situação de linha | Indica se o modelo está em linha ou fora de linha | Deve ser considerada na análise de locação |
| Status            | Situação atual da máquina                         | Deve representar uma única situação atual  |

### Entidade: Locação

| Atributo          | Descrição                                     | Regra de negócio associada                     |
| ----------------- | --------------------------------------------- | ---------------------------------------------- |
| Data de retirada  | Data em que a máquina foi entregue ao cliente | Obrigatória                                    |
| Data de devolução | Data de retorno da máquina                    | Deve ser registrada quando ocorrer a devolução |

### Entidade: Item de Locação

| Atributo        | Descrição                            | Regra de negócio associada                  |
| --------------- | ------------------------------------ | ------------------------------------------- |
| Valor da diária | Valor cobrado pela diária da máquina | Deve representar o valor aplicado à locação |

### Entidade: Venda

| Atributo    | Descrição                         | Regra de negócio associada                |
| ----------- | --------------------------------- | ----------------------------------------- |
| Data        | Data em que a venda foi realizada | Obrigatória                               |
| Valor total | Valor total da venda              | Deve ser compatível com os itens vendidos |

### Entidade: Item de Venda

| Atributo       | Descrição                             | Regra de negócio associada |
| -------------- | ------------------------------------- | -------------------------- |
| Valor de venda | Valor pelo qual a máquina foi vendida | Deve ser maior que zero    |

### Entidade: Ordem de Serviço

| Atributo    | Descrição                                     | Regra de negócio associada                    |
| ----------- | --------------------------------------------- | --------------------------------------------- |
| Diagnóstico | Descrição do problema identificado na máquina | Deve ser registrado durante a avaliação       |
| Status      | Situação atual da ordem de serviço            | Deve representar a etapa atual do atendimento |

### Entidade: Item de Ordem de Serviço

| Atributo             | Descrição                                | Regra de negócio associada                      |
| -------------------- | ---------------------------------------- | ----------------------------------------------- |
| Quantidade utilizada | Quantidade de peças utilizada no serviço | Deve gerar a respectiva movimentação de estoque |

### Entidade: Peça

| Atributo              | Descrição                     | Regra de negócio associada |
| --------------------- | ----------------------------- | -------------------------- |
| Descrição             | Nome ou descrição da peça     | Campo obrigatório          |
| Quantidade em estoque | Quantidade disponível da peça | Não pode ficar negativa    |

### Entidade: Movimentação de Estoque

| Atributo   | Descrição                           | Regra de negócio associada |
| ---------- | ----------------------------------- | -------------------------- |
| Tipo       | Identifica entrada ou saída de peça | Campo obrigatório          |
| Quantidade | Quantidade movimentada              | Deve ser maior que zero    |

### Entidade: Pagamento

| Atributo           | Descrição                      | Regra de negócio associada |
| ------------------ | ------------------------------ | -------------------------- |
| Valor              | Valor recebido no pagamento    | Deve ser maior que zero    |
| Forma de pagamento | Forma utilizada para pagamento | Campo obrigatório          |

---

## 6. Modelagem Conceitual

### 6.1 Entidades reconhecidas

| Entidade                 | Justificativa                                                                                               |
| ------------------------ | ----------------------------------------------------------------------------------------------------------- |
| Cliente                  | Pessoa que aluga máquinas, compra máquinas usadas ou leva equipamentos para manutenção.                     |
| Funcionário              | Responsável pelo registro e/ou execução dos processos de locação, venda e assistência técnica.              |
| Marca                    | Fabricante da máquina, utilizada para classificação dos equipamentos.                                       |
| Categoria                | Classificação do tipo de máquina, utilizada para organizar os equipamentos.                                 |
| Máquina                  | Equipamento que pode passar pelos processos de locação, venda e manutenção. É a entidade central do modelo. |
| Locação                  | Representa o processo de aluguel de uma ou mais máquinas.                                                   |
| Item de Locação          | Identifica a máquina pertencente a uma determinada locação e registra o valor aplicado.                     |
| Venda                    | Representa o processo de venda de uma máquina usada.                                                        |
| Item de Venda            | Identifica a máquina pertencente a uma venda e registra o valor aplicado.                                   |
| Ordem de Serviço         | Representa o atendimento realizado pela oficina/assistência técnica.                                        |
| Item de Ordem de Serviço | Registra as peças utilizadas em uma ordem de serviço.                                                       |
| Peça                     | Componente utilizado na manutenção das máquinas e controlado pelo estoque.                                  |
| Movimentação de Estoque  | Registra as entradas e saídas das peças, permitindo rastreamento.                                           |
| Pagamento                | Registra os valores pagos relacionados aos processos de venda, locação ou ordem de serviço.                 |

### 6.2 Relacionamentos

* Cliente **1:N** Locação.
* Cliente **1:N** Venda.
* Cliente **1:N** Ordem de Serviço.
* Funcionário **1:N** Locação.
* Funcionário **1:N** Venda.
* Funcionário **1:N** Ordem de Serviço.
* Marca **1:N** Máquina.
* Categoria **1:N** Máquina.
* Locação **1:N** Item de Locação.
* Máquina **1:N** Item de Locação.
* Venda **1:N** Item de Venda.
* Máquina **1:1** Item de Venda.
* Máquina **1:N** Ordem de Serviço.
* Ordem de Serviço **1:N** Item de Ordem de Serviço.
* Peça **1:N** Item de Ordem de Serviço.
* Peça **1:N** Movimentação de Estoque.
* Pagamento deve estar relacionado a **um único processo de origem**: Venda, Locação ou Ordem de Serviço.

### 6.3 Restrições aplicadas ao modelo

* A **Máquina** funciona como entidade central, pois pode participar dos processos de locação, venda e manutenção ao longo de sua utilização.
* O atributo **status** da Máquina representa sua situação atual, evitando que diferentes processos mantenham informações conflitantes sobre disponibilidade.
* A entidade **Peça** representa o estoque atual, enquanto **Movimentação de Estoque** registra o histórico de entradas e saídas.
* As entidades de **Item** permitem representar os elementos envolvidos em uma locação, venda ou ordem de serviço sem duplicar os dados principais.
* A questão de compatibilidade entre peças e modelos de máquinas é reconhecida como uma necessidade do negócio, porém sua representação detalhada deverá ser validada na pesquisa de campo antes de ser incorporada ao modelo lógico.

---

## 7. Diagrama Entidade-Relacionamento (DER)

![Diagrama Entidade-Relacionamento](DER/DER.png)

O DER representa as 14 entidades identificadas na modelagem conceitual, seus principais atributos e as cardinalidades dos relacionamentos.

A entidade **Máquina** ocupa posição central porque participa dos principais processos analisados: locação, venda e assistência técnica.

O diagrama representa a visão conceitual do sistema. A definição detalhada de **chaves primárias, chaves estrangeiras, tipos de dados e restrições técnicas** será realizada posteriormente na etapa do Modelo Lógico.

---

## 8. Justificativa Técnica

A modelagem foi construída a partir dos processos identificados na FELAP e dos problemas relatados pelo grupo, principalmente relacionados à disponibilidade das máquinas, controle de estoque e integração entre os setores.

A entidade **Máquina** foi definida como elemento central porque o mesmo equipamento pode participar de diferentes processos ao longo de sua utilização: pode estar disponível, ser alugado, passar por manutenção e posteriormente ser vendido.

Por esse motivo, o atributo **status** foi mantido na própria entidade Máquina. Dessa maneira, a situação atual do equipamento não fica espalhada em diferentes processos, reduzindo o risco de inconsistência entre locação, venda e manutenção.

A **situação de linha** também foi incluída na Máquina porque existe um problema operacional relacionado à locação de equipamentos fora de linha. Essa informação permite que a situação do modelo seja considerada antes da locação.

As entidades **Locação, Venda e Ordem de Serviço** foram separadas porque representam processos diferentes e possuem características próprias. A criação das entidades de **Item** permite detalhar quais máquinas ou peças participam de cada processo.

A separação entre **Peça** e **Movimentação de Estoque** também foi adotada de forma intencional. A quantidade atual da peça representa o saldo disponível, enquanto as movimentações permitem registrar o histórico de entradas e saídas. Essa estrutura facilita futuras consultas de auditoria e investigação de divergências de estoque.

A utilização de um cadastro único de **Cliente** e **Máquina** evita a duplicação de informações entre os módulos. Assim, os diferentes processos utilizam as mesmas entidades principais.

Uma entidade genérica chamada **Transação** não foi utilizada porque venda, locação e ordem de serviço possuem características diferentes. A utilização de uma entidade única poderia gerar atributos que não seriam aplicáveis a todos os processos e aumentar a quantidade de informações sem utilização.

O **Pagamento** foi mantido como entidade independente porque representa o registro financeiro relacionado a um processo específico. Na etapa lógica, será definida a melhor forma técnica de implementar a associação exclusiva com Venda, Locação ou Ordem de Serviço.

As regras relacionadas à **compatibilidade entre máquinas e peças** foram mantidas como necessidade do negócio, mas não foram acrescentadas artificialmente ao DER sem validação. Essa decisão evita que uma hipótese levantada durante a elaboração seja apresentada como uma informação confirmada pela empresa.

Dessa forma, o modelo conceitual procura representar os processos atualmente conhecidos, mantendo espaço para ajustes após a entrevista e a pesquisa de campo.

---

## 9. Uso de Inteligência Artificial

O grupo utilizou ferramentas de Inteligência Artificial durante a elaboração do trabalho. As respostas foram utilizadas como apoio à organização das informações, mas as decisões finais foram analisadas pelo grupo.

### Uso 1 — Estruturação inicial

| Item                             | Registro                                                                                                                                                                                                |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Ferramenta e etapa               | Claude — ideação inicial de slides e de um diagrama de banco de dados para uma empresa genérica de máquinas e equipamentos                                                                              |
| Motivação                        | Organizar ideias iniciais sobre entidades e processos antes de ter acesso ao roteiro exato da disciplina                                                                                                |
| Prompt(s) utilizados             | Pedido de apresentação de slides e diagrama de banco de dados para uma empresa fictícia de máquinas e equipamentos, com locação, estoque de peças, venda de máquinas novas/usadas e assistência técnica |
| Resposta recebida                | Estrutura de slides, lista de entidades genéricas e um diagrama inicialmente apresentado como modelo lógico                                                                                             |
| Fontes consultadas e verificadas | Não se aplica — resposta baseada em conhecimento geral de modelagem de dados                                                                                                                            |
| Trechos rejeitados ou corrigidos | O nome fictício da empresa foi rejeitado, pois o trabalho exige uma organização real. O diagrama inicialmente apresentado como lógico também foi ajustado para atender à etapa conceitual               |
| Justificativa da escolha final   | Foram mantidas somente as ideias compatíveis com o escopo definido pelo grupo                                                                                                                           |
| Reflexão crítica                 | A resposta inicial era genérica e não representava os processos reais da FELAP, servindo apenas como ponto de partida                                                                                   |

### Uso 2 — Adaptação do modelo para a FELAP

| Item                             | Registro                                                                                                                                                                                                      |
| -------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Ferramenta e etapa               | Claude — definição de requisitos, regras de negócio, entidades, atributos, relacionamentos, dicionário de dados, DER conceitual e justificativa técnica                                                       |
| Motivação                        | Organizar, junto com o conhecimento de um integrante que trabalha na FELAP, as informações da empresa no formato exigido pela disciplina                                                                      |
| Prompt(s) utilizados             | Informações fornecidas pelo integrante sobre a FELAP, seus setores, sistema GESCOM, problemas de locação, estoque e máquinas não localizadas, com solicitação de continuidade do trabalho etapa por etapa     |
| Resposta recebida                | Requisitos funcionais e não funcionais, regras de negócio, entidades, atributos, relacionamentos, dicionário de dados, DER e justificativa técnica                                                            |
| Fontes consultadas e verificadas | As informações utilizadas sobre os processos internos vieram do conhecimento direto do integrante e deverão ser confirmadas na pesquisa de campo                                                              |
| Trechos rejeitados ou corrigidos | Elementos fora do escopo definido pelo grupo foram removidos. Também foram revisadas partes que não estavam totalmente coerentes entre o DER, o dicionário e as regras de negócio                             |
| Justificativa da escolha final   | O modelo foi mantido somente quando considerado compatível com os processos conhecidos pelo grupo                                                                                                             |
| Reflexão crítica                 | A IA não possui acesso direto aos processos internos da empresa. Portanto, as regras de negócio e decisões de modelagem ainda precisam ser confirmadas na pesquisa de campo antes da implementação definitiva |

### Uso 3 — Revisão do modelo conceitual

| Item                             | Registro                                                                                                                                                                                       |
| -------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Ferramenta e etapa               | ChatGPT — revisão da Entrega 1 e identificação de inconsistências entre DER, dicionário, requisitos e regras de negócio                                                                        |
| Motivação                        | Verificar a coerência interna do modelo antes de iniciar a transformação para o Modelo Lógico e posteriormente para SQL                                                                        |
| Prompt(s) utilizados             | Solicitação de revisão do README da Entrega 1, identificação dos pontos inconsistentes e correção do documento mantendo as informações reais fornecidas pelo grupo                             |
| Resposta recebida                | Foram identificados pontos de atenção relacionados à compatibilidade entre peças e máquinas, atributos do dicionário, relacionamento de pagamentos e coerência entre as justificativas e o DER |
| Fontes consultadas e verificadas | README fornecido pelo grupo, DER e informações já levantadas sobre a organização                                                                                                               |
| Trechos rejeitados ou corrigidos | Foram evitadas afirmações que apresentassem como fato confirmado informações que ainda dependem da entrevista de campo                                                                         |
| Justificativa da escolha final   | As correções foram feitas para deixar o modelo conceitual mais consistente sem inventar informações sobre a empresa                                                                            |
| Reflexão crítica                 | A revisão com IA foi utilizada como apoio técnico. A validação final das regras de negócio continua sendo responsabilidade do grupo e deverá ocorrer junto à organização                       |

---

## Observação sobre a pesquisa de campo

A pesquisa de campo ainda deverá ser realizada para validar as informações levantadas pelo grupo.

Após a entrevista, deverão ser revisados principalmente:

* processos reais de locação;
* critérios utilizados para máquinas fora de linha;
* controle e disponibilidade de peças;
* relacionamento entre máquinas e peças compatíveis;
* funcionamento dos pagamentos;
* responsabilidades dos funcionários em cada processo;
* informações do GESCOM utilizadas pelos setores;
* eventuais alterações necessárias no DER e no dicionário de dados.

As informações obtidas na entrevista deverão substituir ou complementar os pontos provisórios deste documento antes da implementação definitiva do banco de dados.
