# Bancos de dimensão

Carregue **um** banco, o do tipo de trabalho confirmado na Etapa 1 de [`SKILL.md`](SKILL.md).
Cada dimensão é um ramo candidato da árvore de decisão, não um item de checklist a preencher.

## Feature nova

Comportamento que ainda não existe. O risco é decidir errado o que ainda está aberto.

- **Invariantes de domínio**: quais estados a entidade nunca pode assumir, e quem garante isso.
- **Concorrência e transição de estado**: o que acontece quando duas operações competem pela
  mesma entidade, ou quando a transição pedida não é permitida no estado atual.
- **Idempotência e reentrância**: o que acontece se a mesma requisição chegar duas vezes (retry
  de cliente, timeout, reprocessamento de fila).
- **Fronteira de transação e Unit of Work**: o que precisa ser atômico, o que pode ser
  eventualmente consistente, e o que acontece se uma etapa intermediária falhar.
- **Dependências externas e cancelamento**: como a funcionalidade se comporta quando uma API,
  fila ou banco externo falha, expira ou é cancelado pelo cliente.
- **Taxonomia de exceções**: quais falhas são esperadas (regra de negócio violada) versus
  inesperadas (infraestrutura), e quem trata cada uma.
- **Observabilidade**: qual evento precisa ser encontrado depois em produção, e por qual EventoId.
- **Dados sensíveis**: quais campos não podem vazar para log, resposta de erro ou mensagem de fila.
- **Compatibilidade**: o que quebra em consumidores existentes ou em dados já persistidos.
- **Cobertura de teste**: quais desses ramos só ficam garantidos se existir um teste específico.

## Migração

Comportamento que já existe em produção e vai mudar de lugar, versão ou stack. O risco é
diferente: não é decidir errado o que está aberto, é **não enxergar** o que já está decidido e
em uso. Ramifique por endpoint, por contrato ou por fatia de dado, uma unidade migrável por vez.

- **Paridade de comportamento**: o que o código atual faz de fato, incluindo o que ninguém
  documentou e algum consumidor já depende. Levante isso do código e dos logs, não da memória.
- **Consumidores e contrato publicado**: quem chama hoje, o que no contrato está congelado por
  eles, e o que pode mudar sem quebrar ninguém.
- **Convivência**: as duas versões rodam ao mesmo tempo? Por quanto tempo, e quem decide o corte?
- **Cutover e rollback**: como a virada acontece, e como se volta atrás depois dela.
- **Dados legados e em trânsito**: o que já está persistido no formato antigo, e o que está no
  meio do caminho durante a virada.
- **Autenticação e autorização**: o legado usa token fixo de integração, persona ou sessão? Isso
  muda na versão nova? Chame a ferramenta Skill com "backend-dotnet-padroes" para a
  referência de API.
- **Fora de escopo**: o que deliberadamente **não** migra, e o que acontece com quem depende disso.
- **Invariantes de domínio**: quais regras estavam implícitas no legado e precisam virar
  explícitas na versão nova.
- **Fronteira de transação e Unit of Work**: o que era atômico no legado e precisa continuar.
- **Taxonomia de exceções**: quais erros o consumidor já trata hoje e espera continuar recebendo.
- **Observabilidade**: como saber, depois da virada, que a versão nova está se comportando como
  a antiga — e por qual EventoId.
- **Cobertura de teste**: qual teste prova a paridade antes da virada.

## Bug com decisão nova

A causa raiz já foi classificada por `backend-dotnet-triage` e exige uma decisão que o time
ainda não tomou. Se não exigir, pule o grill e vá direto para `backend-dotnet-implementation`.

- **Invariante violada**: qual regra deveria ter impedido esse estado, e onde ela deveria morar.
- **Escopo do conserto**: corrigir só este sintoma, ou a classe inteira de defeito que ele revela.
- **Compatibilidade**: alguém já depende do comportamento errado? O conserto quebra esse alguém?
- **Taxonomia de exceções**: a falha vira exceção de negócio esperada ou continua inesperada.
- **Observabilidade**: o que faltava no log para esse bug ter sido encontrado antes.
- **Cobertura de regressão**: o teste que falha antes da correção e passa depois.

## Discovery

Entender como algo funciona hoje, sem decidir mudança ainda. A fronteira inverte: ela é feita de
**desconhecidos sobre o código**, e resolvê-los é seu trabalho, não do usuário. Investigue, e
traga ao usuário só o que a investigação não conseguiu responder, ou o que ela revelou como
decisão futura.

- **Comportamento atual**: o que o código faz hoje, caminho feliz e caminhos de erro.
- **Contratos e consumidores**: o que é exposto, e quem consome.
- **Regras de negócio embutidas**: quais invariantes existem de fato, e onde elas moram.
- **Pontos de acoplamento**: o que quebra junto se isso mudar.
- **Dívida e riscos**: o que está frágil, o que não tem teste, o que não tem log.
- **O que ninguém documentou**: o comportamento que só existe no código e na cabeça de alguém.

**Concluído quando:** cada dimensão foi investigada e respondida a partir do código, e as
perguntas que sobraram estão registradas como decisões para um grill futuro.
