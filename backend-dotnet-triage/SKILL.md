---
name: backend-dotnet-triage
description: Transforma um bug ou pedido externo vago em um ticket backend .NET implementável, sem passar pelo grill nem pela spec. Use manualmente quando o pedido já chegar pronto (não é uma ideia nova para grillar), antes de `backend-dotnet-implementation`.
disable-model-invocation: true
---

# Triage Backend .NET

Um bug relatado de fora chega como sintoma, não como decisão. A triagem converte o sintoma em um ticket com causa raiz suspeita e critério de aceite falseável, sem reabrir todo o grill.

## 1. Reproduza e localize

Confirme os passos de reprodução com quem relatou, ou a partir dos dados disponíveis (log, exceção, caso de teste que falha). Identifique a camada provável — domínio, aplicação, infraestrutura — onde a causa mora.

**Concluído quando:** existe um passo a passo de reprodução (ou a evidência que o substitui) e uma camada candidata para a causa raiz.

## 2. Classifique

Decida entre três causas: regra de negócio violada (o comportamento é a regra funcionando, só mal comunicada), falha de infraestrutura (dependência externa, persistência, contrato quebrado) ou defeito real de implementação.

**Concluído quando:** a causa está classificada em uma das três categorias, com o trecho de código ou o contrato que sustenta a classificação.

## 3. Escreva o ticket

Produza um ticket autocontido no mesmo formato de `backend-dotnet-tickets`: título, descrição, passos de reprodução, causa raiz suspeita e critério de aceite. O critério de aceite precisa ser um teste que falha antes da correção e passa depois — não uma descrição vaga de "funcionando".

**Concluído quando:** o ticket é implementável sem depender do relato original, e o critério de aceite descreve um teste falseável.

## 4. Decida se o ticket precisa de grill

Rode `backend-dotnet-grill` sobre o ticket antes de implementar quando a causa raiz envolver uma invariante nova, uma mudança de contrato ou um trade-off de robustez ainda não decidido pelo time. Nos demais casos, siga direto para `backend-dotnet-implementation`.

**Concluído quando:** a decisão de grillar ou não está registrada no ticket com o motivo.
