---
name: backend-dotnet-domain
description: Implementa ou revisa entidades e serviços de domínio em soluções .NET com DDD. Use quando uma mudança criar ou alterar regras de negócio, invariantes, entidades, serviços de domínio ou exceções de domínio.
---

# Camada de Domínio

Consulte `../backend-dotnet/references/naming.md` e `../backend-dotnet/references/architecture.md`. `../backend-dotnet/references/domain.md` é a fonte única para as regras de entidade, serviço e comando: aplique-a em cada etapa abaixo em vez de reconstruir a regra.

## Entidades

Aplique a seção "Entidades" de `domain.md`: a entidade nasce válida e cada mutação preserva as invariantes.

**Concluído quando:** cada caminho de criação e mutação foi inspecionado, as invariantes estão protegidas, as exceções esperadas são explícitas e os nomes refletem o vocabulário do negócio.

## Serviços de domínio

Aplique a seção "Serviços" de `domain.md` para decidir entre serviço de entidade, serviço de contexto ou regra na própria entidade.

**Concluído quando:** o serviço contém apenas decisão/orquestração de domínio, seus colaboradores estão claros e nenhuma regra foi duplicada em outra camada.

## Comandos

Aplique a seção "Comandos" de `domain.md` para decidir se a intenção de alteração merece um objeto próprio.

**Concluído quando:** cada comando novo representa uma intenção real, tem dados mínimos e é consumido por um fluxo de aplicação ou domínio identificável.

## Validação

Cubra sucesso, entradas nulas ou vazias, limites, combinações inválidas, transições de estado e dependências ausentes. Transforme condicionais complexas em operações nomeadas quando isso tornar a regra mais legível.

**Concluído quando:** cada regra nova tem pelo menos um caso válido e um caso inválido, e os testes de domínio passam conforme `../backend-dotnet/references/testing.md`.
