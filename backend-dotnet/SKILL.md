---
name: backend-dotnet
description: Roteia o desenvolvimento backend .NET da empresa por tipo de trabalho, do grill de uma ideia até o code review final. Use esta skill manualmente para escolher o fluxo corporativo adequado.
disable-model-invocation: true
---

# Backend .NET

Use este roteador para selecionar uma skill operacional. Aplique as referências compartilhadas em `references/` quando o fluxo escolhido pedir nomenclatura, arquitetura, API, testes ou observabilidade.

## Seleção

- **Ideia nova ainda solta, com riscos de robustez não mapeados**: comece por `backend-dotnet-grill`.
- **Bug ou pedido externo que já chegou pronto**: comece por `backend-dotnet-triage`.
- **Organizar uma conversa de grill em uma especificação escrita**: use `backend-dotnet-spec`.
- **Quebrar uma spec em tickets independentes**: use `backend-dotnet-tickets`.
- **Implementar uma funcionalidade ou correção backend**: use `backend-dotnet-implementation`.
- **Criar ou alterar entidade, serviço ou regra de negócio**: use `backend-dotnet-domain`.
- **Criar ou alterar request, response, app service, endpoint de API ou chamada assíncrona**: use `backend-dotnet-application`.
- **Criar ou alterar persistência, mapeamento NHibernate, repositório ou Unit of Work**: use `backend-dotnet-infrastructure`.
- **Registrar dependências ou reorganizar configurações do contêiner**: use `backend-dotnet-ioc`.
- **Criar ou atualizar testes de entidades e serviços de domínio**: use `backend-dotnet-tests`.
- **Adicionar ou revisar logs estruturados**: use `backend-dotnet-logging`.
- **Revisar a mudança antes do commit**: use `backend-dotnet-code-review`.

## Fluxo completo

O fluxo tem duas entradas e um tronco comum:

- **Ideia nova**: `backend-dotnet-grill` → `backend-dotnet-spec` → `backend-dotnet-tickets`. Mantenha essas três etapas na mesma conversa, sem limpar nem compactar o contexto.
- **Bug ou pedido externo**: `backend-dotnet-triage` produz o ticket diretamente; só volta para `backend-dotnet-grill` quando a causa raiz exigir uma decisão de robustez nova.

A partir de um ticket, abra uma conversa nova e execute o tronco comum nesta ordem:

1. `backend-dotnet-implementation`: delimite a mudança, seus contratos e evidências a partir só do ticket.
2. `backend-dotnet-domain`: modele ou valide as regras de negócio.
3. `backend-dotnet-application`: modele entrada, saída, cancelamento e orquestração.
4. `backend-dotnet-infrastructure`: implemente persistência e mapeamentos necessários.
5. `backend-dotnet-ioc`: registre as dependências.
6. `backend-dotnet-tests`: cubra entidades e serviços de domínio.
7. `backend-dotnet-logging`: registre eventos operacionais relevantes e seguros.
8. Execute novamente a validação final de `backend-dotnet-implementation`.
9. `backend-dotnet-code-review`: feche o ciclo antes do commit.

Pule uma etapa do tronco comum somente quando a mudança não tocar seu contrato. Registre a razão no resumo final da mudança.

**Concluído quando:** a entrada escolhida (ideia nova ou triagem) está explícita, cada etapa aplicável do tronco comum foi encaminhada à skill correspondente, cada etapa pulada tem uma razão registrada, e `backend-dotnet-code-review` rodou antes do commit.

## Critério de conclusão

O fluxo está completo quando cada camada tocada tem implementação e validação próprias, cada camada não tocada foi explicitamente marcada como não aplicável, todos os testes relevantes passam, a cobertura segue `references/testing.md`, os logs não expõem dados sensíveis, e `backend-dotnet-code-review` não deixou item bloqueante em aberto.
