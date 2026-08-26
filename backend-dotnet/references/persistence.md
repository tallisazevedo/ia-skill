# Persistência e Integrações .NET

Esta referência reúne os padrões de persistência e integração da infraestrutura.

## NHibernate

Classes de mapeamento seguem `<Entidade>Map.cs` e fazem a ligação entre entidade e tabela.

```csharp
public class ModuloMap : ClassMap<Modulo>
{
	public ModuloMap()
	{
		Table("modulos");
		Id(p => p.Codigo).Column("codigo").GeneratedBy.Sequence("modulos-sequence");
		Map(p => p.Nome).Column("nome");
	}
}
```

Para um relacionamento um-para-um, mapeie a referência e a coluna estrangeira explicitamente:

```csharp
public class FuncaoMap : ClassMap<Funcao>
{
	public FuncaoMap()
	{
		Table("funcoes");
		Id(p => p.Codigo).Column("codigo").GeneratedBy.Sequence("funcoes-sequence");
		Map(p => p.Nome).Column("nome");
		References(p => p.Modulo).Column("codigo_modulo").NotFound.Ignore();
	}
}
```

Para um-para-muitos, confirme a coleção, a coluna estrangeira e a estratégia de cascata antes de mapear. Para muitos-para-muitos, confirme a tabela de junção, as duas chaves e o comportamento de remoção.

## Repositórios

Repositórios de backend implementam contratos de acesso a dados e devem seguir o nome da entidade/contexto adotado na solução. Escolha a tecnologia já usada pelo contexto:

- NHibernate + Fluent para entidades mapeadas e Unit of Work da solução.
- Dapper para consultas SQL quando o contexto adotar esse caminho.
- HttpClient para repositórios que consomem APIs externas.

Para APIs externas, mantenha entidade interna e Response externo separados; converta o contrato no repositório e propague cancelamento, timeout e erros conforme o padrão do cliente.

Repositórios concentram consultas e comandos de persistência, mas não regras de negócio. O contrato pode viver no domínio ou na aplicação conforme a arquitetura da solução; a implementação fica na infraestrutura.

## Consultas e filtros

Filtros representam critérios de seleção e consultas representam a intenção de leitura. Nomeie e componha esses objetos conforme a entidade ou contexto. Deixe critérios reutilizáveis e sem regra de mutação; o repositório aplica o filtro/consulta na tecnologia escolhida.

## Acesso a banco

Siga o padrão de acesso a banco definido pela solution, incluindo a estratégia alternativa quando o contexto exigir. Em Dapper, valide parâmetros, mapeamento de retorno, transação e ciclo de vida da conexão. Nunca concatene entrada externa em SQL.

**Concluído quando:** tecnologia, conexão, transação, parâmetros, mapeamento de retorno e comportamento de erro foram verificados para cada operação nova.

## Dapper

Antes de usar Dapper, confirme os pré-requisitos e o padrão de acesso do contexto. Parametrize toda entrada, mantenha conexão e transação sob o ciclo de vida correto e valide o mapeamento do resultado para o modelo esperado. Não concatene entrada externa em SQL.

## HttpClient

Repositórios que consomem APIs devem encapsular o cliente, o contrato externo, autenticação, timeout, cancelamento e tratamento de erros. O Response da API não deve vazar diretamente para o domínio; converta-o para a entidade ou modelo interno.

## Filtros e consultas

Filtros representam critérios reutilizáveis de seleção. Consultas representam uma intenção de leitura. Ambos devem ser compostos com dados e critérios, sem mutação inesperada ou dependência direta do mecanismo de persistência quando isso não for necessário.
