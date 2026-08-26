# APIs .NET

Esta referência reúne os padrões de URI, resposta, JSON, métodos HTTP, Swagger e autenticação adotados pelas APIs RESTful da empresa.

## URIs e recursos

Um recurso é uma coleção de elementos com identificador único (normalmente uma entidade de negócio).

| Verbo | Path | CRUD | Uso |
|---|---|---|---|
| GET | `/usuarios` | Listar | Retorna a coleção |
| GET | `/usuarios/{codigo}` | Recuperar | Retorna um elemento da coleção |
| POST | `/usuarios` | Criar | Cria um elemento na coleção |
| PUT | `/usuarios/{codigo}` | Atualizar | Atualiza um elemento da coleção |
| DELETE | `/usuarios/{codigo}` | Excluir | Exclui ou inativa um elemento da coleção |

Regras de nomenclatura do recurso:

- Substantivo no plural, nunca um verbo: use `/vendas`, não `/vendas/gerar` ou `/vendas/{codigo}/editar`.
- Sempre lowercase: `/vendas`, não `/Vendas` ou `/VENDAS`.
- Nomes compostos em spinal-case: `/ordens-pagamentos`, não `/ordenspagamentos`.

**Entidade forte** existe por conta própria (`/api/{prefixo}/usuarios/{codigo}`). **Entidade fraca** depende de uma entidade forte para existir e aparece aninhada sob ela, por exemplo um item de pedido em `/api/{prefixo}/pedidos/{codigo}/itens/{codigoItem}`.

### Prefixos de consumidor

| Prefixo | Significado |
|---|---|
| `int-app` | Consumida por uma aplicação interna |
| `web-app` | Consumida por uma aplicação disponível na web |
| `int-itg` | Consumida por integração interna (API chamando API) |
| `web-itg` | Consumida por integração externa (parceiros) |

Esses prefixos aplicam-se apenas a APIs de uso interno (ex.: portal de aplicações). Não fazem sentido para APIs de uso exclusivo de uma aplicação própria (ex.: Vistoria.mobi, Opini.one).

**Concluído quando:** o path usa substantivo plural em spinal-case lowercase, a relação entidade forte/fraca está refletida na URI e o prefixo de consumidor está presente quando a API for de uso interno multiaplicação.

## Códigos e formato de resposta

| Código | Significado | Quando |
|---|---|---|
| 200 | Ok | Sucesso na requisição |
| 400 | Bad Request | Erro de negócio tratado |
| 401 | Unauthorized | Usuário não autenticado |
| 403 | Forbidden | Usuário sem permissão |
| 404 | Not Found | URI/recurso não existe |
| 500 | Internal Server Error | Erro não previsto |

Corpo de erro para 400 e 500:

```json
{
    "Message" : "Descrição da mensagem de erro."
}
```

401 e 403 respondem corpo vazio (`""`). 200 responde `""` ou o objeto/coleção solicitado.

**Concluído quando:** cada resposta usa o código previsto para o seu caso, e o corpo de erro
segue o formato acima em vez de um formato próprio do endpoint.

## Formato de JSON

- Atributos com a primeira letra maiúscula (`Codigo`, não `codigo`).
- Atributos compostos em CamelCase (`CodigoTipo`, não `codigotipo` ou `codigo_tipo`).
- Entidades relacionadas são objetos aninhados, não campos achatados:

```json
{
    "Codigo" : 1,
    "Descricao" : "Testâncio Testácio",
    "Perfil" : {
        "Codigo" : 5,
        "Descricao" : "Administrador"
    }
}
```

**Concluído quando:** atributos seguem a capitalização acima e entidades relacionadas aparecem
como objetos aninhados, não como campos achatados.

## Métodos HTTP

**GET** recupera dados. Parâmetros de path (`/api/usuarios/123`) identificam um recurso por ID; query params (`/api/usuarios?nome=...&pg=1&qt=50`) especificam filtros. Todo recurso de listagem deve ser paginado. Um recurso do tipo path não encontrado retorna 404.

Requisição paginada:

```json
{
    "Qt" : 10,
    "Pg" : 1,
    "TpOrd" : "Desc",
    "CpOrd" : "Codigo"
}
```

Se `Qt`/`Pg` não forem informados, o default é `Qt=10`, `Pg=1`. O máximo de registros por página é 100; pedidos acima disso retornam os 100 primeiros.

Resposta paginada:

```json
{
    "Registros" : [],
    "Total" : 0
}
```

**POST** insere dados e sempre retorna o objeto criado.

**PUT** edita dados: o código do recurso vai na URL, nunca no corpo; o corpo carrega os dados alterados e a resposta retorna o objeto atualizado.

**DELETE** exclui ou inativa um recurso pelo código na URL e responde string vazia com 200.

**Concluído quando:** cada endpoint usa o verbo correto para sua intenção, listagens são paginadas com os defaults acima, e PUT/DELETE recebem o código apenas pela URL.

## Documentação Swagger

- A página inicial (index) da API redireciona para a documentação Swagger.
- O título do Swagger expressa o contexto da API, por exemplo `Autoglass.Vendas.API`.
- Toda descrição de recurso é obrigatória e escrita no infinitivo, por exemplo "Listar vendedores", "Inserir um novo vendedor".
- Recursos são agrupados pelo trecho da URL que os identifica (ex.: `vendas`).
- Todo recurso que retorna objeto no response declara o model schema correspondente.
- Todo parâmetro (path, query ou body) é documentado como obrigatório ou opcional.
- APIs autenticadas declaram o parâmetro `Token_Autorizacao` do tipo `header` como obrigatório.
- Toda operação documenta as response messages possíveis (400, 401, 403, 500) com seu significado.

**Concluído quando:** o Swagger da API tem título com contexto, cada recurso documentado tem descrição no infinitivo, model schema, parâmetros e response messages.

## Autenticação

APIs não públicas devem estar autenticadas via token expirável enviado no cabeçalho `Token_Autorizacao`. Um filtro de requisição HTTP recupera e valida esse token antes da ação do controlador. Se o token estiver ausente, inválido ou expirado, a API retorna 401 sem mensagem.

### Token fixo para integração (.NET Framework)

Quando o consumidor for um sistema parceiro (não uma sessão de usuário), use um token fixo em vez de login/senha:

- Registre o token na tabela `DELTA.GEN_ACESSOEXTERNOAPI` (código, descrição do consumidor, data de cadastro, token em GUID, tipo de persona, código da persona, código do usuário associado às transações).
- Gere o GUID com `[guid]::NewGuid()` no PowerShell.
- Registre o mesmo token no Redis (homologação e produção) com chave `Sessao-Fixo:<guid>` e valor `{ "Id": 1, "Info": { "Nome": "<descrição do consumidor>" } }`.
- Use códigos de token diferentes entre produção e os demais ambientes; misturar ambientes permite que uma requisição de produção autentique num endpoint de teste (ou o inverso).
- Na controller, aplique o atributo de rota de integração (`RouteIntranetIntegracao` ou `RouteWebIntegracao`) e o atributo de autenticação de integração (`PoliticaAcessoEnum.IntranetIntegracao` ou `PoliticaAcessoEnum.WebIntegracao`):

```csharp
[HttpGet]
[RouteIntranetIntegracao("teste")]
[Autenticada(PoliticaAcessoEnum.IntranetIntegracao)]
[ResponseType(typeof(ResultadoConsultaPaginacaoResponse<ClasseResponse>))]
public IHttpActionResult ListarTeste([FromUri]ClasseRequest request)
{
	var response = pesquisaDeTeste.Listar(request);
	return Ok(response);
}
```

**Concluído quando:** toda API não pública exige `Token_Autorizacao`, tokens fixos de integração estão registrados na tabela e no Redis com chave por ambiente, e a controller declara os atributos de rota e autenticação de integração corretos.
