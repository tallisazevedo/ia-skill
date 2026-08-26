# Skills de desenvolvimento backend .NET

Oito skills que levam um trabalho backend da ideia solta até o commit, aplicando os padrões da
equipe de arquitetura em cada linha de código escrita pelo caminho.

Documentação completa de onboarding: [`docs/onboarding.html`](docs/onboarding.html).

## Instalar

```bash
git clone https://github.com/tallisazevedo/ia-skill.git ~/ia-skill

mkdir -p ~/.claude/skills
for d in ~/ia-skill/backend-dotnet*/; do
  ln -s "$d" ~/.claude/skills/$(basename "$d")
done
```

Com links simbólicos, `git pull` em `~/ia-skill` atualiza todas as skills de uma vez. Para
confirmar, digite `/backend-dotnet` no Claude Code.

**Não instale uma skill sozinha.** Elas apontam para as referências por caminho relativo
(`../backend-dotnet/references/`) e precisam ser irmãs na mesma pasta. Uma skill isolada não
falha com erro — ela simplesmente não encontra os padrões e segue sem eles.

## As oito skills

Acionadas **só por nome** — os portões que você abre. O roteador consegue indicá-las, nunca
dispará-las.

| Skill | Para |
|---|---|
| `backend-dotnet` | escolher o fluxo |
| `backend-dotnet-grill` | interrogar um trabalho antes de implementar |
| `backend-dotnet-triage` | converter um defeito reportado em ticket |
| `backend-dotnet-spec` | virar a conversa de grill em spec escrita |
| `backend-dotnet-tickets` | quebrar a spec em tickets independentes |

Alcançadas **pelo agente** — o trabalho que precisa acontecer sem você digitar.

| Skill | Dispara em |
|---|---|
| `backend-dotnet-padroes` | qualquer código backend .NET escrito ou revisado |
| `backend-dotnet-implementation` | implementar uma funcionalidade ou correção |
| `backend-dotnet-code-review` | antes do commit; chamada por `implementation` |

## Fluxo

Duas entradas levam ao mesmo tronco:

- **Trabalho novo** — `grill` → `spec` → `tickets`, na mesma conversa.
- **Defeito reportado** — `triage` produz o ticket diretamente.

A partir de um ticket, abra uma **conversa nova** e rode `implementation`. Ela aplica os padrões,
verifica, e chama `code-review` antes do commit.

O grill atende quatro tipos de trabalho — feature nova, migração, bug com decisão nova e
discovery — e o tipo escolhe as dimensões que a entrevista percorre. Um **discovery** termina no
próprio grill, entregando entendimento em vez de ticket.

## Os padrões

`backend-dotnet/references/` é a fonte única de verdade, exposta por `backend-dotnet-padroes`.
Cada referência carrega seus próprios critérios de conclusão.

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

## Contribuir

Quando o time de arquitetura mudar uma regra, atualize a **referência** — não a skill. As skills
apontam para as referências justamente para existir um lugar só a editar.

Antes de abrir PR:

- A regra nova tem **um** lugar, ou você criou uma segunda fonte de verdade?
- A seção nova termina em um critério de conclusão verificável?
- Os caminhos relativos ainda resolvem?
- Se mexeu na invocação de uma skill, o README e o roteador ainda dizem a verdade?

Registre em cada referência de qual documento da equipe de arquitetura ela veio e em que data.
Sem isso, elas divergem do Confluence em silêncio.
