---
name: backend-dotnet-grill
description: Interroga um plano de funcionalidade backend .NET antes da implementação, usando rodadas de perguntas sobre invariantes, concorrência, falhas, transação e observabilidade para garantir robustez. Use manualmente antes de `backend-dotnet-implementation` quando o requisito ainda for uma ideia solta ou tiver riscos de robustez não mapeados.
disable-model-invocation: true
---

# Grill de Robustez Backend .NET

Consulte `../backend-dotnet/references/domain.md`, `../backend-dotnet/references/persistence.md`, `../backend-dotnet/references/observability.md` e `../backend-dotnet/references/api.md` conforme os ramos abaixo forem tocados.

`grill` é a entrevista que testa a resistência de um plano antes de qualquer código: mapeia a funcionalidade como uma **árvore de decisão** ramificada pelas dimensões de robustez abaixo, e interroga rodada por rodada até nada restar como suposição silenciosa.

## 1. Monte a árvore

Percorra a funcionalidade proposta e marque quais das dimensões abaixo têm decisão em aberto. Descarte explicitamente as que não se aplicam; não pule uma sem registrar o motivo.

- **Invariantes de domínio**: quais estados a entidade nunca pode assumir, e quem garante isso.
- **Concorrência e transição de estado**: o que acontece quando duas operações competem pela mesma entidade, ou quando a transição pedida não é permitida no estado atual.
- **Idempotência e reentrância**: o que acontece se a mesma requisição chegar duas vezes (retry de cliente, timeout, reprocessamento de fila).
- **Fronteira de transação e Unit of Work**: o que precisa ser atômico, o que pode ser eventualmente consistente, e o que acontece se uma etapa intermediária falhar.
- **Dependências externas e cancelamento**: como a funcionalidade se comporta quando uma API, fila ou banco externo falha, expira ou é cancelado pelo cliente.
- **Taxonomia de exceções**: quais falhas são esperadas (regra de negócio violada) versus inesperadas (infraestrutura), e quem trata cada uma.
- **Observabilidade**: qual evento precisa ser encontrado depois em produção, e por qual EventoId.
- **Dados sensíveis**: quais campos não podem vazar para log, resposta de erro ou mensagem de fila.
- **Compatibilidade e migração**: o que quebra em consumidores existentes ou em dados já persistidos.
- **Cobertura de teste**: quais desses ramos só ficam garantidos se existir um teste automatizado específico.

**Concluído quando:** cada dimensão tem uma marcação explícita (relevante ou não aplicável, com motivo), e cada dimensão relevante virou ao menos uma pergunta na fronteira.

## 2. Pergunte por rodada

Uma **rodada** pergunta toda a **fronteira** de uma vez: toda decisão cujos pré-requisitos já foram respondidos, e nada além disso. Duas perguntas nunca dividem a mesma rodada se uma depende da resposta da outra.

Formate cada pergunta como:

```
❓ N. <título curto>
<corpo da pergunta>
➡️ <sua recomendação, uma linha>
```

Quando a resposta for um fato que o próprio código ou ambiente pode revelar (schema existente, contrato de API já publicado, comportamento atual de um repositório), vá verificar sozinho em vez de perguntar; não bloqueie a rodada inteira por isso, apenas as perguntas que dependem do resultado.

**Concluído quando:** a rodada foi enviada por completo, nenhuma pergunta da rodada depende de outra pergunta da mesma rodada, e todo fato verificável foi verificado em vez de perguntado.

## 3. Espere a decisão

Cada pergunta é do usuário, não sua. Não responda por ele, mesmo quando a recomendação pareça óbvia. "Não sei" é uma resposta válida e é sinal de que aquele ramo precisa de um spike ou protótipo antes de virar decisão — nunca de uma suposição sua.

**Concluído quando:** toda pergunta da rodada tem resposta explícita do usuário, e cada "não sei" virou uma ação de investigação registrada em vez de uma suposição sua.

## 4. Repita até a fronteira esvaziar

Depois de cada resposta, recalcule a fronteira: as respostas podem liberar novas perguntas ou fechar ramos inteiros. Continue até não haver mais decisão em aberto.

**Concluído quando:** a fronteira está vazia, você pediu confirmação explícita de que o entendimento é compartilhado, e nenhuma implementação começou antes dessa confirmação.

## Entrega

Ao final, entregue a árvore com cada ramo marcado como decidido (com a decisão) ou não aplicável (com o motivo). Essa árvore alimenta a Etapa 1 (Delimite) de `backend-dotnet-implementation` como o resumo de requisito, contexto, camadas tocadas e casos de validação esperados.

**Concluído quando:** a árvore cobre as dez dimensões, cada decisão está rastreável a uma resposta do usuário, e a entrega pode ser lida por outra pessoa sem depender da conversa original.

## Sinais de que está funcionando

- Você discordou de pelo menos uma recomendação; uma sessão sem nenhum contraponto seu é uma sessão dispensável.
- As perguntas chegam em poucas rodadas, e cada rodada usa o que a anterior respondeu.
- Uma pergunta revelou uma decisão que você estava tomando implicitamente.
- Ao final, você conseguiria defender cada decisão para alguém que não participou da sessão.
