# Persistência e Integrações .NET

Padrões de persistência e integração da infraestrutura. Valide os padrões já existentes na
solução antes de escolher uma extensão NHibernate ou introduzir uma tecnologia nova.

## Mapeamento NHibernate

Classes de mapeamento seguem `<Entidade>Map.cs` e ligam entidade a tabela. Declare tabela,
identificador, colunas e relacionamentos explicitamente.

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

Para um-para-um, mapeie a referência e a coluna estrangeira explicitamente:

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

Antes de usar `References`, coleções ou `NotFound.Ignore()`, confirme cardinalidade, coluna
estrangeira, nulabilidade e comportamento de entidade ausente. Para um-para-muitos, confirme a
coleção, a coluna estrangeira e a estratégia de cascata. Para muitos-para-muitos, confirme a
tabela de junção, as duas chaves e o comportamento de remoção.

**Concluído quando:** cada propriedade persistida tem mapeamento intencional, cada
relacionamento tem cardinalidade e carregamento verificados, e o mapeamento está incluído na
configuração da sessão.

## Repositórios e Unit of Work

Repositórios implementam contratos de acesso a dados e seguem o nome da entidade ou contexto
adotado na solução. O contrato pode viver no domínio ou na aplicação conforme a arquitetura da
solução; a implementação fica na infraestrutura. Repositórios concentram consultas e comandos
de persistência, nunca regras de negócio.

Preserve a transação e o ciclo de vida definidos pelo Unit of Work existente, e propague
`CancellationToken` nas operações assíncronas suportadas pelo provedor. Use a abstração de
persistência que o contexto já possui em vez de introduzir uma nova.

**Concluído quando:** a implementação usa as abstrações já adotadas, a transação é consistente
com o fluxo e as operações novas têm teste ou validação de integração disponível.

## Escolha da tecnologia

Escolha a tecnologia que o contexto já adota:

- **NHibernate + Fluent** para entidades mapeadas sob o Unit of Work da solução.
- **Dapper** quando o contexto já adota SQL explícito. Parametrize toda entrada, mantenha
  conexão e transação sob o ciclo de vida correto e valide o mapeamento do resultado para o
  modelo esperado. Toda entrada externa vai como parâmetro, nunca concatenada no SQL.
- **HttpClient** para repositórios que consomem APIs externas. Encapsule cliente, contrato
  externo, autenticação, timeout, cancelamento e tratamento de erro. Converta o Response
  externo para a entidade ou modelo interno dentro do repositório.

**Concluído quando:** a tecnologia escolhida coincide com o padrão do contexto, os parâmetros
são seguros, o contrato externo não vaza para o domínio e a operação foi exercitada.

## Filtros e consultas

Filtros representam critérios reutilizáveis de seleção; consultas representam uma intenção de
leitura. Ambos são compostos com dados e critérios, sem regra de mutação e sem dependência
direta do mecanismo de persistência quando isso não for necessário. O repositório aplica o
filtro ou a consulta na tecnologia escolhida.

**Concluído quando:** critérios estão nomeados pela entidade ou contexto, são reutilizáveis e
não carregam detalhes acidentais da tecnologia.

## Verificação

Execute build, testes aplicáveis e uma validação do mapeamento ou consulta contra o ambiente
seguro disponível. Inspecione SQL ou plano de consulta quando a mudança puder alterar
cardinalidade ou desempenho.

**Concluído quando:** o caminho de leitura e escrita foi exercitado, os relacionamentos não
geram dados duplicados inesperados e nenhuma credencial ou dado sensível foi adicionado ao
código ou ao log.
