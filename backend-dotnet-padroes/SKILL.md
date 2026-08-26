---
name: backend-dotnet-padroes
description: Padrões de desenvolvimento backend .NET da empresa. Use ao escrever ou revisar código backend .NET, em qualquer tarefa - feature nova, migração, bug ou investigação. Cobre entidade, invariante, regra de negócio e serviço de domínio; Request, Response, AppService, async e CancellationToken; endpoint, controller, URI, código de resposta, paginação, Swagger e autenticação; repositório, mapeamento NHibernate, Unit of Work, Dapper e HttpClient; registro de dependência e ciclo de vida no IoC; teste de domínio e cobertura; log estruturado e EventoId; nomenclatura e responsabilidade de camada.
---

# Padrões Backend .NET

Estes são os padrões da equipe de arquitetura da empresa. Carregue a referência da área que a
mudança toca e aplique-a enquanto escreve o código, não depois.

Estes padrões valem para as soluções backend da empresa. Em um repositório que siga outro
padrão, o padrão do repositório vence — registre a divergência no resumo da mudança.

## Referências

| A mudança toca | Referência |
|---|---|
| Entidade, invariante, regra de negócio, serviço de domínio, comando | `../backend-dotnet/references/domain.md` |
| Request, Response, AppService, orquestração, async, `CancellationToken` | `../backend-dotnet/references/application.md` |
| Endpoint, controller, URI, código e formato de resposta, paginação, JSON, Swagger, autenticação | `../backend-dotnet/references/api.md` |
| Repositório, mapeamento NHibernate, Unit of Work, Dapper, HttpClient, filtro, consulta | `../backend-dotnet/references/persistence.md` |
| Registro de dependência, ciclo de vida, bootstrapper | `../backend-dotnet/references/ioc.md` |
| Teste de entidade ou serviço de domínio, cobertura | `../backend-dotnet/references/testing.md` |
| Log estruturado, EventoId, nível, dado sensível | `../backend-dotnet/references/observability.md` |
| Nome de classe, interface, método, Request/Response, Map, teste | `../backend-dotnet/references/naming.md` |
| Onde a responsabilidade mora entre domínio, aplicação, infraestrutura e IoC | `../backend-dotnet/references/architecture.md` |

Cada referência traz seus próprios critérios de conclusão. Eles valem como parte do trabalho:
uma área tocada sem seu critério satisfeito não está pronta.

## Duas regras que atravessam todas as áreas

**Linguagem ubíqua em português.** Conceitos de negócio usam o termo real do domínio
(`Pedido`, `Credenciado`, `OrdemDeServico`), nunca a tradução em inglês. Inglês fica reservado
para nomes de padrões de projeto (`Repository`, `Factory`, `Strategy`). Detalhe em `naming.md`.

**Dados sensíveis não circulam.** Senha, token, segredo e credencial não entram em log, corpo
de erro ou mensagem de fila. Detalhe em `observability.md`.

**Concluído quando:** cada área tocada pela mudança teve sua referência carregada e seu critério
de conclusão satisfeito, e cada área não tocada foi explicitamente marcada como não aplicável.
