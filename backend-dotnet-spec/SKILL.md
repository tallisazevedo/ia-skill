---
name: backend-dotnet-spec
description: Organiza a conversa de grill de uma funcionalidade backend .NET em uma spec escrita, sem publicar em rastreador. Use manualmente logo após `backend-dotnet-grill`, na mesma conversa, antes de `backend-dotnet-tickets`.
disable-model-invocation: true
---

# Spec Backend .NET

A spec é a transcrição decidida do grill, não uma nova entrevista. Ela organiza o que já foi respondido; não inventa o que não foi.

## 1. Reúna as decisões

Percorra a árvore de decisão entregue por `backend-dotnet-grill` (ou a conversa de alinhamento equivalente). Toda decisão precisa de uma resposta rastreável; toda dimensão marcada como não aplicável precisa do motivo já registrado.

Se alguma decisão ainda estiver em aberto, volte para `backend-dotnet-grill` e resolva-a lá — não preencha a lacuna com uma suposição sua na spec.

**Concluído quando:** cada decisão da árvore tem origem rastreável na conversa, e nenhuma lacuna foi preenchida por suposição.

## 2. Escreva a spec

Estruture um documento Markdown com estas seções:

- **Objetivo**: o problema de negócio e por que ele importa.
- **Regras e invariantes**: o que a entidade ou o fluxo deve garantir sempre, na linguagem ubíqua do domínio.
- **Contratos**: Requests, Responses, endpoints ou eventos afetados, seguindo `../backend-dotnet/references/naming.md` e `../backend-dotnet/references/api.md`.
- **Casos de validação**: sucesso, entradas inválidas, limites e falhas de dependência externa, um por decisão relevante do grill.
- **Fora de escopo**: o que foi deliberadamente descartado, e por quê.
- **Riscos residuais**: decisões marcadas como "não sei" no grill, com a investigação pendente registrada.

Salve o arquivo em `specs/<slug-da-funcionalidade>.md` na raiz do repositório da solução, a menos que o repositório já tenha uma convenção diferente.

**Concluído quando:** toda seção existe e reflete apenas decisões já tomadas, o arquivo foi salvo no repositório, e nenhuma seção genérica substitui uma decisão específica do grill.

## Entrega

Mantenha esta spec na mesma conversa que produziu o grill — não limpe nem compacte o contexto antes de rodar `backend-dotnet-tickets`.

**Concluído quando:** a spec está salva, e a conversa que a originou segue disponível para a etapa seguinte.
