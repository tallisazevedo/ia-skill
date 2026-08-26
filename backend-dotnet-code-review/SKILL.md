---
name: backend-dotnet-code-review
description: Revisa uma mudança backend .NET antes do commit, checando a adesão aos padrões da empresa e ao ticket ou spec que a originou. Use sempre antes de commitar uma mudança backend .NET, e ao final de `backend-dotnet-implementation`.
---

# Code Review Backend .NET

Duas perguntas fecham o ciclo, e nenhuma substitui a outra: o código segue os padrões da
empresa, e o código entrega o que o ticket pediu.

## 1. Verifique os padrões

Invoque `backend-dotnet-padroes` e, para cada arquivo tocado no diff, confira contra a
referência correspondente:

| O arquivo toca | Referência |
|---|---|
| Nome de classe, interface, método, Request/Response, Map, teste | `naming.md` |
| Responsabilidade de camada | `architecture.md` |
| Entidade, invariante, serviço de domínio, comando | `domain.md` |
| Request, Response, AppService, async, `CancellationToken` | `application.md` |
| Endpoint, código e formato de resposta, paginação, Swagger, autenticação | `api.md` |
| Mapeamento, repositório, Unit of Work, Dapper, HttpClient | `persistence.md` |
| Registro de dependência, ciclo de vida | `ioc.md` |
| Teste de entidade ou serviço de domínio, cobertura | `testing.md` |
| Log estruturado, EventoId, dado sensível | `observability.md` |

As referências trazem seus próprios critérios de conclusão; um critério não satisfeito é um
desvio como qualquer outro. Cite arquivo e trecho para cada um — uma impressão geral sem
localização não é um achado.

**Concluído quando:** todo arquivo modificado foi confrontado com a referência aplicável, e cada
desvio encontrado tem arquivo e trecho citados.

## 2. Verifique a adesão ao ticket

Para cada critério de aceite do ticket (ou da spec, quando não houver ticket), localize a
evidência no diff — código ou teste — que o satisfaz.

Sinalize dois desvios distintos: um critério sem evidência no diff, e uma mudança no diff que não
corresponde a nenhum critério do ticket.

**Concluído quando:** todo critério de aceite tem evidência citada ou está marcado como não
atendido, e toda mudança fora do escopo do ticket está identificada.

## 3. Consolide

Junte os achados das duas verificações em uma lista única, cada item marcado como bloqueante ou
sugestão, com arquivo e trecho.

**Concluído quando:** a lista existe, cada item tem sua origem (padrão ou aderência ao ticket) e
sua severidade explícitas, e a mudança só está liberada para commit quando não há item bloqueante
pendente.
