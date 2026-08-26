---
name: backend-dotnet-grill
description: Interroga um trabalho backend .NET antes da implementação, rodada por rodada, até nada restar como suposição silenciosa.
disable-model-invocation: true
---

# Grill Backend .NET

`grill` é a entrevista que testa a resistência de um trabalho antes de qualquer código. Mapeia
o trabalho como uma **árvore de decisão** e interroga rodada por rodada até nada restar como
suposição silenciosa.

## 1. Determine o tipo de trabalho

O tipo decide quais dimensões a árvore percorre. Pergunte ao usuário qual é, ou proponha o que
a solicitação indica e confirme antes de seguir:

- **Feature nova**: comportamento que ainda não existe.
- **Migração**: comportamento que já existe em produção e vai mudar de lugar, versão ou stack.
- **Bug com decisão nova**: a causa raiz exige uma invariante, contrato ou trade-off novo.
- **Discovery**: entender como algo funciona hoje, sem decidir mudança ainda.

**Concluído quando:** o tipo está confirmado pelo usuário e o banco de dimensões correspondente
em [`dimensoes.md`](dimensoes.md) foi carregado.

## 2. Monte a árvore

Percorra o trabalho e marque quais dimensões do banco carregado têm decisão em aberto. Descarte
explicitamente as que não se aplicam, com o motivo. Uma dimensão fora do banco que o trabalho
exigir entra na árvore do mesmo jeito — o banco é o piso, não o teto.

**Concluído quando:** cada dimensão do banco tem marcação explícita (relevante, ou não aplicável
com motivo), e cada dimensão relevante virou ao menos uma pergunta na fronteira.

## 3. Pergunte por rodada

Uma **rodada** pergunta toda a **fronteira** de uma vez: toda decisão cujos pré-requisitos já
foram respondidos, e nada além disso. Duas perguntas nunca dividem a mesma rodada se uma depende
da resposta da outra.

Formate cada pergunta como:

```
❓ N. <título curto>
<corpo da pergunta>
➡️ <sua recomendação, uma linha>
```

Quando a resposta for um fato que o código ou o ambiente pode revelar — schema existente,
contrato já publicado, comportamento atual de um repositório — vá verificar sozinho em vez de
perguntar. Descobrir **fatos** é seu trabalho; as **decisões** são do usuário. Não bloqueie a
rodada inteira por uma verificação, apenas as perguntas que dependem dela.

**Concluído quando:** a rodada foi enviada por completo, nenhuma pergunta da rodada depende de
outra pergunta da mesma rodada, e todo fato verificável foi verificado em vez de perguntado.

## 4. Espere a decisão

Cada pergunta é do usuário, não sua. Não responda por ele, mesmo quando a recomendação pareça
óbvia. "Não sei" é uma resposta válida e sinaliza que aquele ramo precisa de um spike ou
protótipo antes de virar decisão — nunca de uma suposição sua.

**Concluído quando:** toda pergunta da rodada tem resposta explícita do usuário, e cada "não sei"
virou uma ação de investigação registrada em vez de uma suposição sua.

## 5. Repita até a fronteira esvaziar

Depois de cada resposta, recalcule a fronteira: as respostas podem liberar novas perguntas ou
fechar ramos inteiros. Continue até não haver mais decisão em aberto.

**Concluído quando:** a fronteira está vazia, você pediu confirmação explícita de que o
entendimento é compartilhado, e nenhuma implementação começou antes dessa confirmação.

## Entrega

Entregue a árvore com cada ramo marcado como decidido (com a decisão) ou não aplicável (com o
motivo). Ela alimenta `backend-dotnet-spec` como o resumo de requisito, contexto, camadas
tocadas e casos de validação esperados.

Em um **discovery** a entrega é diferente: não há decisões do usuário para registrar, e sim o
entendimento levantado. Entregue o mapa do comportamento atual, e a lista de decisões que
ficaram visíveis para um grill futuro.

**Concluído quando:** a árvore cobre o banco de dimensões do tipo de trabalho, cada decisão é
rastreável a uma resposta do usuário, e a entrega pode ser lida por outra pessoa sem depender da
conversa original.

## Sinais de que está funcionando

- Você discordou de pelo menos uma recomendação; uma sessão sem nenhum contraponto seu é uma
  sessão dispensável.
- As perguntas chegam em poucas rodadas, e cada rodada usa o que a anterior respondeu.
- Uma pergunta revelou uma decisão que você estava tomando implicitamente.
- Ao final, você conseguiria defender cada decisão para alguém que não participou da sessão.
