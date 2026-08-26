# Backend .NET Skills

Fluxo corporativo de desenvolvimento backend .NET, com os padrões da equipe de arquitetura
aplicados em qualquer tarefa — feature nova, migração, bug ou discovery. O fluxo está em
[`SKILL.md`](SKILL.md).

A família é autossuficiente: não depende de nenhuma skill externa.

## Invocação

**Só por nome** (`disable-model-invocation: true`) — os portões que você abre. O roteador só
consegue indicá-los, nunca dispará-los.

| Skill | Para |
|---|---|
| `backend-dotnet` | escolher o fluxo |
| `backend-dotnet-grill` | interrogar um trabalho antes de implementar |
| `backend-dotnet-triage` | transformar um defeito reportado em ticket |
| `backend-dotnet-spec` | virar a conversa de grill em spec escrita |
| `backend-dotnet-tickets` | quebrar a spec em tickets independentes |

**Alcançadas pelo agente** — o trabalho que precisa acontecer sem você digitar.

| Skill | Dispara em |
|---|---|
| `backend-dotnet-padroes` | qualquer código backend .NET escrito ou revisado |
| `backend-dotnet-implementation` | implementar uma funcionalidade ou correção |
| `backend-dotnet-code-review` | revisar antes do commit; chamada por `implementation` |

## Padrões

`references/` é a fonte única de verdade das regras compartilhadas, exposta por
`backend-dotnet-padroes`. Cada referência carrega seus próprios critérios de conclusão.

| Arquivo | Cobre |
|---|---|
| `architecture.md` | responsabilidade de cada camada |
| `naming.md` | nomenclatura e linguagem ubíqua |
| `domain.md` | entidades, serviços de domínio, comandos, validação |
| `application.md` | Request, Response, AppService, async e cancelamento |
| `api.md` | URI, resposta, paginação, JSON, Swagger, autenticação |
| `persistence.md` | NHibernate, repositórios, Unit of Work, Dapper, HttpClient |
| `ioc.md` | registro de dependências e ciclo de vida |
| `testing.md` | testes de domínio e cobertura |
| `observability.md` | logs estruturados e dados sensíveis |

Quando uma regra corporativa mudar, atualize a referência correspondente. Registre em cada
referência de qual documento da equipe de arquitetura ela veio e em que data — sem isso as
regras divergem do Confluence em silêncio.
