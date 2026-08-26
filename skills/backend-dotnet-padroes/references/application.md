# Camada de Aplicação .NET

A aplicação recebe e entrega contratos, coordena o caso de uso e chama abstrações. Para nomes
de Request e Response consulte `naming.md`; para endpoints expostos por controller consulte
`api.md`; para a decisão entre regra na entidade, serviço de domínio ou comando consulte
`domain.md`.

## Contratos

Requests e Responses são objetos de transporte: não herdam atributos ou métodos de outras
classes, exceto o padrão de paginação adotado pela solução, e não carregam regra de negócio.

Componha Requests com outros Requests quando o payload representar estruturas aninhadas, em vez
de replicar os campos da estrutura composta:

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

**Concluído quando:** arquivos, classes, propriedades e composição refletem o contrato da API e
não há regra de negócio escondida no DTO.

## Assíncrono e cancelamento

Use `async` para I/O suportado pela biblioteca e considere-o para processamento intenso fora da
regra de negócio. Propague o `CancellationToken` recebido para cada operação que aceita
cancelamento, incluindo chamadas de repositório, cliente HTTP e persistência.

Use a fonte de cancelamento que já existe no fluxo. Crie `CancellationTokenSource` apenas onde
você é dono do ciclo de vida do cancelamento.

**Concluído quando:** cada chamada de I/O foi classificada como síncrona ou assíncrona com
justificativa, o token chega a todos os colaboradores compatíveis e o cancelamento do cliente
não é engolido.

## Orquestração

O AppService coordena o caso de uso, converte contratos e chama abstrações. Invariantes ficam
no domínio; detalhes de acesso a dados ficam na infraestrutura.

**Concluído quando:** o caso de uso pode ser lido de cima para baixo, suas dependências são
explícitas e os caminhos de sucesso, erro e cancelamento estão tratados.

## Comandos, filtros e consultas

Comandos expressam intenção de alteração; filtros e consultas expressam intenção de leitura.
Mantenha esses objetos compostos com os dados necessários ao caso de uso e sem regras de
persistência.

**Concluído quando:** o contrato de entrada diferencia alteração de leitura e cada objeto é
aplicado no ponto correto do fluxo.

## Endpoints de API

Ao expor um AppService por uma controller HTTP, aplique `api.md` para URI, código e formato de
resposta, paginação, JSON, Swagger e autenticação.

**Concluído quando:** o endpoint segue a nomenclatura de recurso, os códigos e formatos de
resposta esperados, e está documentado e autenticado conforme `api.md`.
