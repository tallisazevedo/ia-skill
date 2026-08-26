---
name: backend-dotnet-logging
description: Adiciona ou revisa logging estruturado em aplicações .NET com eventos pesquisáveis e proteção de dados. Use quando uma operação importante precisar de observabilidade, quando um log estiver ilegível ou quando houver risco de informação sensível.
---

# Logs .NET

Consulte `../backend-dotnet/references/observability.md`.

## Objetivo

Defina primeiro o evento que precisa ser observado, seu consumidor técnico e a decisão que o log permitirá tomar. Registre eventos relevantes ao funcionamento das operações; não transforme cada linha de execução em telemetria.

**Concluído quando:** cada log novo tem evento, propósito, nível e consumidor identificados.

## Mensagem estruturada

Mantenha a mensagem breve e expressiva. Use o formato `<EventoId> resumo curto` e campos estruturados para os detalhes consultáveis. Prefira `ForContext`/desestruturação controlada quando isso for necessário para investigação.

Escolha `Information` para eventos relevantes a observadores externos, `Warning` para possível problema ou degradação, `Error` para falha da aplicação e `Fatal` para falha crítica total.

**Concluído quando:** o EventoId é estável e indexável, os campos permitem busca sem depender de parsing de texto e a mensagem não carrega um objeto inteiro sem necessidade.

## Segurança e injeção

Nunca registre senha, token, segredo, credencial ou dado sensível. Injete `ILogger` no construtor e deixe o contêiner resolver a dependência. Se a solução possuir uma abstração `ILog` conflitante, resolva o conflito conforme o padrão do projeto antes de adicionar o novo registro.

**Concluído quando:** uma revisão de dados sensíveis foi feita nos campos e argumentos, o logger é resolvido por IoC e o acesso aos logs permanece restrito às equipes de TI.

## Verificação

Exercite o caminho que produz o evento e confirme no sink disponível que o EventoId, nível e propriedades aparecem estruturados. Verifique também o comportamento de erro e cancelamento.

**Concluído quando:** o evento pode ser encontrado por EventoId, não expõe dados proibidos e o resumo final registra o objetivo e os níveis usados.
