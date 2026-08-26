---
name: backend-dotnet
description: Roteia o desenvolvimento backend .NET da empresa por tipo de trabalho, do grill de uma ideia até o code review final.
disable-model-invocation: true
---

# Backend .NET

Use este roteador para escolher o fluxo. Os padrões de código são aplicados por
`backend-dotnet-padroes`, que o agente alcança sozinho em qualquer etapa — você não precisa
encaminhá-los.

## Seleção

- **Trabalho ainda solto, com decisões em aberto**: comece por `backend-dotnet-grill`. Ele
  cobre feature nova, migração, bug com decisão nova e discovery — o tipo escolhe as dimensões
  que a entrevista percorre.
- **Defeito reportado de fora**: comece por `backend-dotnet-triage`. Pedido externo que não é
  defeito — feature, mudança de contrato, migração — entra pelo grill.
- **Organizar uma conversa de grill em uma especificação escrita**: use `backend-dotnet-spec`.
- **Quebrar uma spec em tickets independentes**: use `backend-dotnet-tickets`.
- **Implementar a partir de um ticket**: use `backend-dotnet-implementation`.
- **Revisar a mudança antes do commit**: use `backend-dotnet-code-review`.

## Fluxo

Duas entradas levam ao mesmo tronco:

- **Trabalho novo**: `backend-dotnet-grill` → `backend-dotnet-spec` → `backend-dotnet-tickets`.
  Mantenha essas três etapas na mesma conversa, sem limpar nem compactar o contexto.
- **Defeito reportado**: `backend-dotnet-triage` produz o ticket diretamente; só passa por
  `backend-dotnet-grill` quando a causa raiz exigir uma decisão nova. Quando a triagem conclui
  que a regra está funcionando, o desfecho é comunicação e o fluxo termina ali.

A partir de um ticket, abra uma conversa nova e rode `backend-dotnet-implementation`. Ela
delimita a mudança, aplica os padrões pela `backend-dotnet-padroes`, verifica e fecha chamando
`backend-dotnet-code-review` antes do commit.

Um **discovery** é a exceção: ele termina no próprio grill, entregando entendimento em vez de
ticket. As decisões que ele revelar entram em um grill posterior.

**Concluído quando:** a entrada escolhida está explícita, o ticket foi implementado com os
padrões de cada área tocada aplicados, e `backend-dotnet-code-review` não deixou item bloqueante
em aberto antes do commit.
