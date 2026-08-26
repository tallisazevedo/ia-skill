---
name: backend-dotnet-tickets
description: Corta uma spec em tickets verticais independentes, cada um com suas dependências explícitas.
disable-model-invocation: true
---

# Tickets Backend .NET

Um ticket é a menor fatia da spec que alguém consegue implementar sem reler a spec inteira nem a
conversa do grill.

## 1. Corte em fatias independentes

Percorra a spec seção por seção e identifique fatias verticais: cada fatia entrega e valida uma
parte coerente do comportamento (uma regra de domínio com seu contrato de API, por exemplo), não
uma camada isolada.

**Concluído quando:** toda seção de "Regras e invariantes" e "Contratos" da spec está coberta por
pelo menos uma fatia, e nenhuma fatia mistura funcionalidades sem relação entre si.

## 2. Escreva cada ticket

Para cada fatia, produza um bloco autocontido com:

- **Título**: frase verbal curta descrevendo o incremento.
- **Descrição**: o suficiente para implementar sem abrir a spec ou a conversa original.
- **Critérios de aceite**: os casos de validação da spec que essa fatia precisa satisfazer.
- **Dependências**: outros tickets que precisam estar concluídos antes deste.

**Concluído quando:** um ticket lido isoladamente é implementável, cada critério de aceite veio de
um caso de validação da spec, e toda dependência aponta para outro ticket desta mesma leva.

## 3. Ordene pelo grafo de dependências

Liste os tickets em ordem topológica e marque quais podem rodar em paralelo por não dependerem um
do outro.

**Concluído quando:** a ordem não contém ciclos, e cada ticket paralelizável está identificado
como tal.

## Entrega

Salve os tickets em `specs/<slug-da-funcionalidade>/tickets/<NN>-<titulo>.md`, um arquivo por
fatia. O `<slug-da-funcionalidade>` é o da pasta onde `backend-dotnet-spec` salvou o `spec.md` —
não invente um novo, é o que mantém a spec e seus tickets juntos. Cada
`backend-dotnet-implementation` seguinte começa em conversa nova, recebendo apenas o arquivo do
ticket — não a spec inteira nem o histórico do grill.

**Concluído quando:** cada ticket está salvo em arquivo próprio dentro da pasta da spec que o
originou, e o conjunto de arquivos é suficiente para iniciar qualquer implementação sem contexto
adicional.
