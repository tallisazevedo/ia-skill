---
name: backend-dotnet-tests
description: Cria e revisa testes unitários de domínio em plataformas .NET usando xUnit, NBuilder, NSubstitute e FluentAssertions. Use quando uma entidade ou serviço de domínio for criado ou alterado, ou quando a cobertura de negócio precisar ser verificada.
---

# Testes de Domínio .NET

Consulte `../backend-dotnet/references/testing.md` antes de criar o projeto ou os casos.

## Preparação

Use o projeto de testes de domínio existente ou crie-o com o padrão `<Solution>.Domain.Tests`. Espelhe a estrutura de namespaces do projeto de domínio. Use xUnit, NBuilder para stubs, NSubstitute para mocks e FluentAssertions para as asserções, quando essas bibliotecas forem o padrão da solução.

**Concluído quando:** o projeto correto foi identificado, suas dependências estão disponíveis e a classe de teste espelha o namespace da classe testada.

## Casos

Nomeie a classe como `<ClasseTestada>Tests`. Mantenha uma instância `sut` reutilizável, inicializada no construtor. Agrupe casos de construtor sob `Construtor` e casos de método/propriedade sob `<Nome>Metodo` e `<Nome>Propriedade`.

Nomeie cada caso começando por `Quando` ou `Dado`, separando conjunções com underscore e usando apenas `Espero`, `Entao` e `Quando` como conjunções. Escreva em PascalCase após os marcadores. Prefira uma assertiva por teste e extraia condicionais dos testes para métodos separados.

**Concluído quando:** todos os caminhos relevantes da entidade ou serviço têm casos de sucesso, falha e limite, e os nomes tornam o comportamento legível sem abrir a implementação.

## Cobertura

Gere o relatório de cobertura e confirme o mínimo corporativo aplicável seguindo `../backend-dotnet/references/testing.md`, usando o comando de build indicado lá. Confirme os filtros de cobertura antes de interpretar o percentual.

**Concluído quando:** os testes passam, a cobertura foi gerada ou a indisponibilidade foi registrada, e toda regra nova de entidade/serviço está representada nos testes.
