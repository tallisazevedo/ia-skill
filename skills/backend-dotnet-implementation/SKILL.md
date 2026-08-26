---
name: backend-dotnet-implementation
description: Conduz uma mudança backend .NET do requisito até a validação. Use quando o usuário pedir para implementar uma funcionalidade, corrigir um bug, criar um endpoint ou alterar uma solução backend seguindo os padrões da empresa.
---

# Implementação Backend .NET

Comece em uma conversa nova, recebendo só o ticket. Se o ticket não bastar sozinho, o problema
está no ticket — diga isso em vez de reconstruir o contexto por suposição.

## 1. Delimite

Leia o ticket, a solução e os testes próximos. Identifique o contexto de negócio, o fluxo de
entrada e saída, as áreas tocadas e as regras que precisam permanecer verdadeiras.

Chame a ferramenta Skill com "backend-dotnet-padroes" e carregue a referência de cada área que a
mudança toca.

**Concluído quando:** existe um resumo curto com requisito, contexto, áreas tocadas, símbolos a
criar ou alterar e casos de validação esperados.

## 2. Implemente por contrato

Modele primeiro as regras de domínio, depois conecte as demais áreas conforme o fluxo exigir.
Aplique a referência de cada área enquanto escreve o código, não depois — os critérios de
conclusão dela valem como parte do trabalho.

Preserve a linguagem ubíqua em português para conceitos de negócio e use inglês apenas para
padrões de projeto.

**Concluído quando:** a mudança está implementada em todas as áreas necessárias, sem
responsabilidade de uma área vazando para outra, e cada dependência nova possui uma origem e um
consumidor claros.

## 3. Verifique

Execute o teste mais estreito que pode falsificar a hipótese da implementação. Em seguida execute
os testes da solução, análise estática, build ou comando equivalente disponível. Revise diff,
nomes, cancelamento assíncrono, persistência, registro de dependências e logs.

**Concluído quando:** os comandos executados estão registrados, todos passam ou cada falha
externa está identificada, e a revisão cobre todos os arquivos modificados e todos os contratos
tocados.

## 4. Revise

Chame a ferramenta Skill com "backend-dotnet-code-review" sobre a mudança. Ela confronta o diff
com os padrões da
empresa e com o ticket que originou o trabalho.

**Concluído quando:** o code review rodou e nenhum item bloqueante ficou em aberto.

## 5. Entregue

Produza um resumo com comportamento alterado, áreas tocadas, validações executadas, cobertura,
decisões de nomenclatura e riscos residuais. Marque explicitamente as áreas não tocadas como não
aplicáveis, com o motivo.

A entrega é o resumo. O commit é do usuário — pare aqui e deixe a mudança no diretório de
trabalho para ele revisar.

**Concluído quando:** outra pessoa consegue reproduzir a validação e localizar qualquer pendência
sem depender de contexto implícito, e a mudança está entregue sem ter sido commitada.
