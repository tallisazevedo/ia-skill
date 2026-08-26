# Domínio .NET

## Entidades

- Entidades são sempre válidas após o construtor.
- Validações de criação e alteração devem ficar próximas do estado que protegem.
- Regras de negócio devem ser expressas por métodos com intenção clara.
- Evite construtores e métodos com quantidade excessiva de parâmetros; agrupe dados que formam um conceito do domínio.
- Propriedades e métodos devem respeitar o padrão já adotado no contexto e preservar invariantes.

### Entidade válida desde a criação

O construtor deve executar as validações necessárias antes de disponibilizar a instância. Uma entidade recém-instanciada não deve depender de uma chamada posterior para se tornar válida.

```csharp
public Heroi(string nome, string email)
{
	SetNome(nome);
	SetEmail(email);
}
```

### Regras de estado

- Concentre cada validação no método que altera o estado protegido.
- Use métodos com intenção clara para atualizar propriedades.
- Diferencie validações de obrigatoriedade, tamanho, formato, faixa e transição de estado.
- Mantenha o número de parâmetros de construtores e métodos compatível com a legibilidade do conceito; agrupe dados que formam um objeto do domínio.

## Serviços

Use serviço de domínio de entidade quando a operação pertence a uma entidade, mas sua complexidade ou colaboração justifica uma classe própria. Use serviço de domínio de contexto quando a regra relaciona entidades ou conceitos do contexto. A localização deve responder à pergunta: qual objeto conhece os dados e a regra sem depender de detalhes externos?

Serviços podem organizar operações de instanciar, validar e atualizar quando esse é o vocabulário adotado pelo domínio. Não use serviços para esconder DTOs, consultas simples ou lógica de infraestrutura.

### Serviço de entidade

Use-o quando a regra pertence principalmente a uma entidade, mas sua complexidade, colaboração ou ciclo de operação justifica uma classe separada. Métodos comuns podem representar `Instanciar`, `Validar` e `Atualizar`, desde que esses nomes expressem o vocabulário do contexto.

### Serviço de contexto

Use-o quando a regra relacionar mais de uma entidade ou conceitos do contexto. O serviço deve coordenar a regra sem assumir responsabilidades de banco, HTTP ou framework.

### Localização da regra

Para decidir onde colocar uma regra, pergunte qual objeto possui os dados e o conhecimento necessários. Se a regra preserva um invariante de uma entidade, coloque-a na entidade. Se relaciona entidades, use serviço de domínio. Se coordena entrada, saída ou persistência, use aplicação ou infraestrutura.

## Comandos

Comandos representam uma intenção de alteração. Nomeie-os com a linguagem do domínio e mantenha-os simples, contendo os dados necessários para a operação. Use-os quando a intenção, validação ou tratamento da operação ganhar clareza com um objeto próprio; não crie comandos apenas para envolver uma chamada trivial.

Comandos não devem carregar acesso a banco, HTTP ou serviços de infraestrutura. Quando forem apenas classes anêmicas sem regra, permaneçam no escopo de transporte e não recebam testes unitários de domínio por padrão.
