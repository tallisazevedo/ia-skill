---
name: backend-dotnet-implementation
description: Conduz uma mudança backend .NET do requisito até a validação. Use quando o usuário pedir para implementar uma funcionalidade, corrigir um bug, criar um endpoint ou alterar uma solução backend seguindo os padrões da empresa.
---

# Implementação Backend .NET

## 1. Delimite

Leia a solicitação, a solução e os testes próximos. Identifique o contexto de negócio, o fluxo de entrada e saída, as camadas tocadas e as regras que precisam permanecer verdadeiras.

Invoque `backend-dotnet-padroes` e carregue a referência de cada área que a mudança toca.

**Concluído quando:** existe um resumo curto com requisito, contexto, camadas tocadas, símbolos a criar ou alterar e casos de validação esperados.

## 2. Implemente por contrato

Siga a ordem do tronco comum definida em `../backend-dotnet/SKILL.md`, encaminhando cada camada tocada à skill correspondente e registrando a razão de cada etapa pulada. Preserve a linguagem ubíqua em português para conceitos de negócio e use inglês apenas para padrões de projeto.

**Concluído quando:** a mudança está implementada em todas as camadas necessárias, sem responsabilidade de uma camada vazando para outra, e cada dependência nova possui uma origem e um consumidor claros.

## 3. Verifique

Execute o teste mais estreito que pode falsificar a hipótese da implementação. Em seguida execute os testes da solução, análise estática, build ou comando equivalente disponível. Revise diff, nomes, cancelamento assíncrono, persistência, registro de dependências e logs.

**Concluído quando:** os comandos executados estão registrados, todos passam ou cada falha externa está identificada, e a revisão cobre todos os arquivos modificados e todos os contratos tocados.

## 4. Revise

Invoque `backend-dotnet-code-review` sobre a mudança. Ela confronta o diff com os padrões da
empresa e com o ticket que originou o trabalho.

**Concluído quando:** o code review rodou e nenhum item bloqueante ficou em aberto.

## 5. Entregue

Produza um resumo com comportamento alterado, camadas tocadas, validações executadas, cobertura, decisões de nomenclatura e riscos residuais. Inclua explicitamente as etapas do roteador que foram puladas e por quê.

**Concluído quando:** outra pessoa consegue reproduzir a validação e localizar qualquer pendência sem depender de contexto implícito.
