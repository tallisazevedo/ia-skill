# Testes .NET

- O foco dos testes unitários é o projeto `Domain`, especialmente entidades e serviços.
- Classes anêmicas como filtros, consultas e comandos ficam fora do escopo unitário padrão, salvo risco específico.
- O projeto segue `<Solution>.Domain.Tests` e espelha os namespaces do domínio.
- Bibliotecas padrão: xUnit, NBuilder, NSubstitute e FluentAssertions.
- Classe de teste: `<ClasseTestada>Tests`.
- Instância reaproveitada: `sut`, inicializada no construtor.
- Casos do construtor ficam em `Construtor`; métodos em `<Nome>Metodo`; propriedades em `<Nome>Propriedade`.
- Cada caso começa com `Quando` ou `Dado`.
- Conjunções permitidas: `Espero`, `Entao` e `Quando`, separadas por underscore.
- Descrições usam PascalCase após os marcadores.
- Prefira uma assertiva por teste; extraia condicionais para casos separados.
- Rode `powershell dotnet cake --target testreport` quando o alvo existir.
- Soluções .NET Core devem alcançar 80% de cobertura. Em .NET Framework, código novo relevante deve ter testes.
- Interprete cobertura considerando os filtros corporativos que excluem exceções, comandos, filtros e consultas quando aplicável.

**Concluído quando:** o projeto correto foi identificado, suas dependências estão disponíveis e
a classe de teste espelha o namespace da classe testada.

## Estrutura esperada

O projeto de testes fica na pasta lógica `Testes`, com namespaces que espelham o projeto de domínio:

```text
Autoglass.Template.Projeto.Domain.Tests
├── Dependências
├── Artistas
│   ├── Commands
│   ├── Entities
│   ├── Events
│   ├── Exceptions
│   └── Services
└── Autoglass.Template.Projeto.Sandbox
```

## Modelo de classe

```csharp
namespace Autoglass.Spotiglass.Domain.Tests.Musicas.Entities
{
	public class MusicaTests
	{
		private readonly Musica sut;

		public MusicaTests()
		{
			sut = Builder<Musica>.CreateNew().Build();
		}

		public class Construtor
		{
		}

		public class SetNomeMetodo
		{
		}

		public class SetAlbumMetodo
		{
		}
	}
}
```

## Exemplos de casos

```csharp
[Theory]
[InlineData(null)]
[InlineData("")]
[InlineData(" ")]
public void Quando_NomeForNuloOuVazio_Espero_AtributoObrigatorioExcecao(string nome)
{
	sut.Invoking(x => x.SetNome(nome))
		.Should().Throw<AtributoObrigatorioExcecao>();
}

[Fact]
public void Dado_NomeMaiorDoQue100Caracteres_Espero_TamanhoDeAtributoInvalidoExcecao()
{
	sut.Invoking(x => x.SetNome(new string('*', 101)))
		.Should().Throw<TamanhoDeAtributoInvalidoExcecao>();
}

[Fact]
public void Quando_NomeForValido_Espero_PropriedadePreenchida()
{
	sut.SetNome("Arise");

	sut.Nome.Should().Be("Arise");
}
```

Casos podem ser descritos como `Quando_EmailForValido_Espero_AtributoPreenchido`, `Quando_EmailForInvalido_Espero_EmailInvalidoExcecao`, `Dado_NotaFiscalInvalida_Espero_EnvioDeEmailParaRepresentante` e `Dado_VendaCancelada_Quando_ValorDeVendaMaiorDoQue2000_Entao_EnviarEmailParaGerenteDeUnidade`.

**Concluído quando:** todos os caminhos relevantes da entidade ou serviço têm casos de sucesso,
falha e limite, e os nomes tornam o comportamento legível sem abrir a implementação.

## Cobertura

O relatório tradicional usa filtros equivalentes a:

```csharp
var openCoverSettings = new OpenCoverSettings
{
	OldStyle = true,
	MergeOutput = true,
	ArgumentCustomization = args => args.Append("-skipautoprops")
}
.WithFilter("+[" + solution + ".Domain*]*")
.WithFilter("-[" + projeto + "]*")
.WithFilter("-[" + solution + ".Domain*]*Exceptions*")
.WithFilter("-[" + solution + ".Domain*]*Commands*")
.WithFilter("-[" + solution + ".Domain*]*Filters*")
.WithFilter("-[" + solution + ".Domain*]*Queries*");
```

**Concluído quando:** os testes passam, a cobertura foi gerada ou a indisponibilidade foi
registrada, e toda regra nova de entidade ou serviço está representada nos testes.
