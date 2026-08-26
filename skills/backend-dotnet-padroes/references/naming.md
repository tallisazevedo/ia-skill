# Nomenclatura .NET

Todas as classes de negócio são escritas em português, alinhadas à linguagem ubíqua. Isso mantém
no código os conceitos usados pelos especialistas do domínio: `Pedido`, `Cliente`, `Produto`,
`NotaFiscal`, `OrdemDeServico`.

Classes que implementam padrões de projeto usam a nomenclatura internacional em inglês:
`Repository`, `Service`, `Factory`, `Adapter`, `Observer`, `Strategy`.

## Tipos, interfaces e métodos

- Nomeie classes e estruturas com substantivos ou frases nominais em PascalCase.
- Nomeie métodos com frases verbais, por exemplo `ValidarCpf`, enquanto a classe correspondente
  deve ser `ValidadorDeCpf`.
- Nomeie interfaces com frases adjetivas ou, ocasionalmente, substantivos/frases nominais.
- Prefixe sempre interfaces com `I`.
- Quando houver um par classe-interface cuja classe seja a implementação padrão, os nomes devem
  diferir apenas pelo prefixo `I`: `IClienteAppService` e `ClienteAppService`.
- Considere terminar classes derivadas com o nome da classe base quando isso esclarecer o
  relacionamento, como em `ArgumentoInvalidoException`.
- Não use prefixos artificiais em classes, como `C`.
- Não abrevie nomes nem economize palavras necessárias para explicar a responsabilidade do tipo.
- Use o termo real do domínio: se o negócio usa "credenciado", prefira `Credenciado` a uma
  tradução ou abreviação.

## Convenções por artefato

- Requests seguem `<Entidade><Acao>Request`.
- Responses seguem `<Entidade><Acao>Response` ou `<Entidade>Response`; a ação é preferível, mas
  opcional.
- Mapeamentos NHibernate seguem `<Entidade>Map`.
- Testes seguem `<ClasseTestada>Tests`.

## Exemplos

```csharp
public class Testes
{
}

public interface IClienteAppService
{
}

public class ClienteAppService : IClienteAppService
{
}

public class OrdemDeServico
{
}
```

Evite `ValidarCpf` como nome de classe, `Os` como abreviação de Ordem de Serviço e nomes de
pluralização incorreta como `UsuariosResponse`.

**Concluído quando:** cada símbolo novo usa o idioma correto para o seu tipo, segue a convenção
do seu artefato, e nenhum nome foi abreviado ou traduzido para longe do vocabulário do negócio.
