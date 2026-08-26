# Arquitetura Backend .NET

Esta referência descreve a separação de responsabilidades adotada nas soluções backend .NET.

## Domínio

O domínio contém entidades e serviços que expressam regras de negócio. Entidades devem ser válidas
desde a construção. Serviços de domínio orquestram regras que envolvem mais de uma entidade ou não
pertencem naturalmente a uma entidade. O domínio não depende de HTTP, banco ou detalhes de
framework.

## Aplicação

A aplicação recebe e entrega contratos, coordena o caso de uso e chama abstrações. Requests e
Responses são objetos de transporte. I/O deve ser assíncrono quando suportado, com propagação de
`CancellationToken`. Quando o caso de uso é exposto por uma controller HTTP, o endpoint segue os
padrões de `api.md` (URI, resposta, paginação, JSON, Swagger e autenticação).

## Infraestrutura

A infraestrutura implementa persistência e integrações. Mapeamentos NHibernate fazem a relação
entre entidade e tabela. Repositórios concentram consultas e comandos de persistência. Unit of
Work controla o ciclo transacional adotado pela solução.

## IoC

`NativeInjectorBootstrapper.cs` compõe o registro chamando extension methods de arquivos de
configuração específicos. Registros devem ficar co-localizados por contexto e declarar ciclo de
vida compatível com suas dependências.

## Logs

Logs podem ser injetados em qualquer camada quando houver um evento operacional relevante,
respeitando a referência de observabilidade e a proteção de dados.

## Classes anêmicas

Filtros, consultas e comandos simples que apenas transportam dados são objetos de contrato ou
suporte. Eles não devem receber regras de negócio apenas para evitar colocá-las no domínio.

**Concluído quando:** cada responsabilidade nova está na camada que possui os dados e o
conhecimento para exercê-la, e nenhuma camada assumiu detalhe de outra para evitar uma
indireção.
