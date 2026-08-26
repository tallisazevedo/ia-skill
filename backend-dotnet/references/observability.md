# Observabilidade .NET

- Registre eventos importantes para o funcionamento das operações, com objetivo e consumidor definidos.
- Mensagens são breves e expressivas; detalhes ficam em propriedades estruturadas.
- Use o formato `<EventoId> resumo curto`.
- `EventoId` deve ser estável e indexável para busca no Elasticsearch/Kibana.
- `Information`: evento relevante para observadores externos.
- `Warning`: possível problema, degradação de serviço ou degradação de funcionalidade.
- `Error`: falha da aplicação.
- `Fatal`: erro crítico que causa falha total da aplicação.
- Injete `ILogger` no construtor e use o mecanismo de IoC.
- Nunca grave senha, token, segredo, credencial ou dado sensível.
- Não disponibilize links do Kibana para áreas de negócio; o acesso é exclusivo das equipes de TI.
- Se houver `ILog` legado conflitante, resolva a composição antes de introduzir `ILogger`.

## Planejamento

Antes de criar um log, responda:

- O que a equipe pretende alcançar com o registro?
- Qual é o propósito operacional?
- O evento atende investigação, auditoria técnica ou inteligência de negócio?

Sem esse objetivo, a aplicação tende a produzir mensagens mal formatadas e custosas de analisar.

**Concluído quando:** cada log novo tem evento, propósito, nível e consumidor identificados.

## Exemplo

```csharp
var usuario = new Usuario
{
	Nome = "João das Neves",
	Email = "joao.neves@empresa.com",
	Password = "não registrar"
};

logger.ForContext("User", usuario, destructureObjects: true)
	.Information("<{EventoId}> {Email}", "NovoUsuario", usuario.Email);
```

O resumo indexável deve expor o evento e o dado operacional mínimo. Não use o objeto inteiro como mensagem, pois isso torna o log extenso e pode expor campos proibidos.

**Concluído quando:** o EventoId é estável e indexável, os campos permitem busca sem depender de
parsing de texto e a mensagem não carrega um objeto inteiro sem necessidade.

## Registro em qualquer camada

Logs podem ser registrados em qualquer projeto da solution. Injete `ILogger` no construtor e permita que o IoC resolva a dependência:

```csharp
public class FavoritosAppService
{
	private readonly ILogger logger;

	public FavoritosAppService(ILogger logger)
	{
		this.logger = logger.ForContext<FavoritosAppService>();
	}
}
```

Se a solution possuir uma interface `ILog` implementada e houver conflito de resolução, remova ou substitua o registro legado antes de introduzir `ILogger`.

**Concluído quando:** uma revisão de dados sensíveis foi feita nos campos e argumentos, o logger
é resolvido por IoC e o acesso aos logs permanece restrito às equipes de TI.

## Verificação

Exercite o caminho que produz o evento e confirme no sink disponível que o EventoId, o nível e
as propriedades aparecem estruturados. Verifique também o comportamento de erro e cancelamento.

**Concluído quando:** o evento pode ser encontrado por EventoId, não expõe dados proibidos e o
resumo final registra o objetivo e os níveis usados.
