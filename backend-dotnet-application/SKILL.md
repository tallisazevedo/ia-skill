---
name: backend-dotnet-application
description: Implementa contratos e orquestração da camada de aplicação .NET. Use quando o trabalho envolver Request, Response, AppService, chamadas de I/O assíncronas ou CancellationToken.
---

# Camada de Aplicação

Consulte `../backend-dotnet/references/naming.md`, `../backend-dotnet/references/architecture.md`, `../backend-dotnet/references/domain.md` e, para endpoints expostos por controllers, `../backend-dotnet/references/api.md`.

## Contratos

Nomeie Requests como `<Entidade><Acao>Request` e Responses como `<Entidade><Acao>Response` ou `<Entidade>Response`. Use a ação no singular e no final do nome: `UsuarioCadastroRequest`, `UsuarioEdicaoResponse`. Requests e Responses são objetos de transporte: não herdam atributos ou métodos de outras classes, exceto o padrão de paginação adotado pela solução.

Componha Requests com outros Requests quando o payload representar estruturas aninhadas. Não replique campos de uma estrutura composta sem necessidade.

**Concluído quando:** arquivos, classes, propriedades e composição refletem o contrato da API e não há regra de negócio escondida no DTO.

Exemplo de composição:

```csharp
public class UsuarioEdicaoRequest
{
	public string Nome { get; set; }
	public string Email { get; set; }
	public EnderecoEdicaoRequest Endereco { get; set; }
}

public class EnderecoEdicaoRequest
{
	public string Logradouro { get; set; }
	public int Numero { get; set; }
}
```

## Assíncrono e cancelamento

Use `async` para I/O suportado pela biblioteca e considere-o para processamento intenso fora da regra de negócio. Propague o `CancellationToken` recebido para cada operação que aceita cancelamento, incluindo chamadas de repositório, cliente HTTP e persistência. Não crie `CancellationTokenSource` em cada método sem possuir a responsabilidade de controlar o ciclo de vida; use a fonte do fluxo quando ela já existir.

**Concluído quando:** cada chamada de I/O foi classificada como síncrona ou assíncrona com justificativa, o token chega a todos os colaboradores compatíveis e o cancelamento do cliente não é engolido.

## Orquestração

Mantenha o AppService responsável por coordenar o caso de uso, converter contratos e chamar abstrações. Deixe invariantes no domínio e detalhes de acesso a dados na infraestrutura.

**Concluído quando:** o caso de uso pode ser lido de cima para baixo, suas dependências são explícitas e os caminhos de sucesso, erro e cancelamento estão tratados.

## Comandos, filtros e consultas

Use comandos para intenções de alteração e filtros/consultas para intenções de leitura. Mantenha esses objetos compostos com os dados necessários ao caso de uso e sem regras de persistência. Para decidir se a intenção merece um objeto Comando próprio, siga `../backend-dotnet/references/domain.md`.

**Concluído quando:** o contrato de entrada diferencia alteração de leitura e cada objeto é aplicado no ponto correto do fluxo.

## Endpoints de API

Ao expor um AppService por uma controller HTTP, siga `../backend-dotnet/references/api.md` para URI, código e formato de resposta, paginação, JSON, Swagger e autenticação.

**Concluído quando:** o endpoint segue a nomenclatura de recurso, os códigos e formatos de resposta esperados, e está documentado e autenticado conforme a referência.
