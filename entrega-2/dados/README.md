# Massa de Dados Fictícia — FELAP

## 1. Objetivo

Esta documentação apresenta a massa de dados utilizada para os testes do banco de dados desenvolvido para a FELAP Máquinas e Equipamentos LTDA.

Os dados utilizados são fictícios e foram criados exclusivamente para fins acadêmicos.

Nenhum dado pessoal real de clientes, funcionários ou terceiros foi utilizado no banco de dados.

---

## 2. Características dos dados

A massa de dados foi criada para representar situações próximas aos processos identificados no projeto:

- cadastro de clientes;
- cadastro de funcionários;
- cadastro de marcas;
- cadastro de categorias;
- cadastro de máquinas;
- locação de máquinas;
- venda de máquinas;
- ordens de serviço;
- utilização de peças;
- movimentação de estoque;
- pagamentos.

Os registros foram distribuídos de forma a permitir a realização de consultas, JOINs, atualizações, auditorias e análises gerenciais.

---

## 3. Dados cadastrados

A massa de dados contém registros fictícios para as principais tabelas do banco.

### Clientes

Foram cadastrados 5 clientes fictícios.

### Funcionários

Foram cadastrados 4 funcionários fictícios, representando funções como:

- Atendente;
- Técnico;
- Vendedor;
- Responsável pelo estoque.

### Marcas

Foram cadastradas 4 marcas:

- JCB;
- Caterpillar;
- Komatsu;
- Bobcat.

### Categorias

Foram cadastradas categorias de máquinas, como:

- Retroescavadeira;
- Escavadeira;
- Pá Carregadeira;
- Mini Carregadeira.

### Peças

Foram cadastradas peças fictícias utilizadas no controle de estoque e nas ordens de serviço.

### Máquinas

Foram cadastradas 6 máquinas fictícias, com diferentes situações e status operacionais.

Foram utilizados status como:

- DISPONIVEL;
- ALUGADA;
- EM_MANUTENCAO;
- VENDIDA;
- INDISPONIVEL.

### Locações

Foram cadastradas locações fictícias envolvendo clientes, funcionários e máquinas.

### Vendas

Foram cadastradas vendas fictícias de máquinas usadas.

### Ordens de Serviço

Foram cadastradas ordens de serviço fictícias relacionadas à manutenção das máquinas.

### Movimentações de estoque

Foram registradas entradas e saídas fictícias de peças.

### Pagamentos

Foram cadastrados pagamentos fictícios relacionados a vendas, locações e ordens de serviço.

---

## 4. Coerência dos dados

Os dados foram criados considerando os relacionamentos definidos no modelo lógico.

Exemplos:

- uma locação está vinculada a um cliente e a um funcionário;
- cada item de locação está vinculado a uma máquina;
- uma venda está vinculada a um cliente e a um funcionário;
- cada item de venda está vinculado a uma máquina;
- uma ordem de serviço está vinculada a um cliente, funcionário e máquina;
- os itens da ordem de serviço identificam as peças utilizadas;
- as movimentações de estoque estão vinculadas às peças;
- os pagamentos possuem uma única origem entre venda, locação ou ordem de serviço.

Dessa forma, os dados permitem testar os relacionamentos e as restrições estabelecidas no banco.

---

## 5. Utilização de Inteligência Artificial

A Inteligência Artificial foi utilizada como ferramenta de apoio durante a elaboração da massa de dados.

### Ferramenta utilizada

ChatGPT.

### Objetivo da utilização

A IA foi utilizada para auxiliar na criação de registros fictícios e coerentes com o modelo lógico do banco de dados.

O objetivo foi evitar a utilização de dados pessoais reais e, ao mesmo tempo, produzir registros suficientes para testar os relacionamentos e consultas SQL.

---

## 6. Prompt utilizado

Foi utilizado um prompt semelhante ao seguinte:

> Crie uma massa de dados fictícia e coerente para um banco de dados de uma empresa de máquinas e equipamentos, considerando clientes, funcionários, máquinas, locações, vendas, ordens de serviço, peças, estoque e pagamentos. Os dados devem ser exclusivamente fictícios e adequados para testes acadêmicos em MySQL.

---

## 7. Validação dos dados gerados

Os dados sugeridos pela IA não foram utilizados de forma automática.

Foi realizada uma análise da estrutura para verificar:

- compatibilidade com as tabelas;
- compatibilidade com as chaves primárias;
- compatibilidade com as chaves estrangeiras;
- coerência entre os relacionamentos;
- compatibilidade com os tipos de dados;
- atendimento às restrições definidas no banco.

Quando necessário, os dados foram ajustados antes de serem inseridos no script SQL.

---

## 8. Partes rejeitadas ou corrigidas

Durante a construção da massa de dados, algumas sugestões poderiam não estar de acordo com o modelo lógico ou com as regras definidas no projeto.

Essas informações foram revisadas antes da utilização.

Foram priorizados dados que:

- não utilizassem informações pessoais reais;
- respeitassem as relações entre as tabelas;
- permitissem realizar consultas SQL;
- representassem situações de gestão e auditoria;
- fossem adequados para demonstração acadêmica.

---

## 9. Finalidade dos dados

A massa de dados será utilizada para demonstrar o funcionamento do banco durante a apresentação da Entrega 2.

Entre as possibilidades de demonstração estão:

- consultas com JOIN;
- consulta de máquinas disponíveis;
- consulta de máquinas alugadas;
- consulta de máquinas vendidas;
- consulta de máquinas em manutenção;
- consulta de peças com estoque baixo;
- consulta de ordens de serviço;
- consulta de pagamentos;
- consultas de auditoria;
- consultas para apoio à gestão.

---

## 10. Observação sobre privacidade

Todos os nomes, documentos, telefones, endereços, números de série e demais informações utilizadas na massa de dados são fictícios.

Os dados não representam clientes ou funcionários reais da FELAP.

A utilização de dados fictícios tem como objetivo preservar a privacidade e permitir a demonstração do projeto em ambiente acadêmico.

---

## 11. Conclusão

A massa de dados fictícia foi desenvolvida para permitir testes práticos do modelo lógico e do script SQL.

Os registros foram organizados de forma a representar os principais processos do projeto e possibilitar consultas de operação, gestão e auditoria.

A utilização de Inteligência Artificial ocorreu como apoio à criação dos dados, sendo realizada posteriormente a análise e validação das informações para adequação ao modelo desenvolvido.
