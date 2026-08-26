---
name: backend-dotnet-triage
description: Converte um defeito reportado de fora em um ticket implementável, ou na constatação de que a regra está funcionando.
disable-model-invocation: true
---

# Triage Backend .NET

Um defeito relatado de fora chega como sintoma, não como decisão. A triagem converte o sintoma
em um desfecho: ou um ticket com causa raiz suspeita e critério de aceite falseável, ou a
constatação de que não há defeito.

Um pedido externo que **não** é defeito — feature nova, mudança de contrato, migração — não
entra aqui: ele tem requisito, não causa raiz. Leve-o para `backend-dotnet-grill`.

## 1. Reproduza e localize

Confirme os passos de reprodução com quem relatou, ou a partir dos dados disponíveis (log,
exceção, caso de teste que falha). Identifique a camada provável — domínio, aplicação,
infraestrutura — onde a causa mora.

**Concluído quando:** existe um passo a passo de reprodução (ou a evidência que o substitui) e
uma camada candidata para a causa raiz.

## 2. Classifique

Decida entre três causas:

- **Regra funcionando, mal comunicada**: o comportamento relatado é a regra de negócio operando
  como projetada. Não há defeito.
- **Falha de infraestrutura**: dependência externa, persistência ou contrato quebrado.
- **Defeito de implementação**: o código não faz o que a regra manda.

**Concluído quando:** a causa está classificada em uma das três categorias, com o trecho de
código ou o contrato que sustenta a classificação.

## 3. Escolha o desfecho

A classificação decide o que sai da triagem, e os dois desfechos são diferentes.

**Regra funcionando, mal comunicada.** Não há comportamento a corrigir, logo não há ticket de
implementação nem teste que falha antes e passa depois. O desfecho é comunicação: a mensagem de
erro que enganou o relator, a documentação ausente, ou a resposta que fecha o relato. Registre o
trecho de código ou o contrato que mostra a regra operando como esperado. Se a comunicação em si
exigir mudança de código — reescrever uma mensagem de erro, por exemplo — isso vira um ticket
próprio, de comunicação, não de correção de defeito.

**Falha de infraestrutura ou defeito de implementação.** Produza um ticket autocontido no mesmo
formato de `backend-dotnet-tickets`: título, descrição, passos de reprodução, causa raiz
suspeita e critério de aceite. O critério de aceite precisa ser um teste que falha antes da
correção e passa depois — não uma descrição vaga de "funcionando".

**Concluído quando:** o desfecho corresponde à causa classificada, e é autossuficiente: o ticket
é implementável sem depender do relato original, ou a constatação de "sem defeito" cita a
evidência que a sustenta.

## 4. Decida se o ticket precisa de grill

Vale apenas para o desfecho de ticket. Quando a causa raiz envolver uma invariante nova, uma
mudança de contrato ou um trade-off de robustez ainda não decidido pelo time, diga ao usuário
para rodar `backend-dotnet-grill` sobre o ticket antes de implementar — o banco de dimensões
**Bug com decisão nova** cobre exatamente esse caso. Nos demais casos, siga direto para
`backend-dotnet-implementation`.

**Concluído quando:** a decisão de grillar ou não está registrada no ticket com o motivo.
