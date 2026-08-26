# Backend .NET Skills

Fluxo corporativo de desenvolvimento backend .NET, do grill de uma ideia até o code review
final. O fluxo completo — as duas entradas, o tronco comum e o critério de conclusão — está em
[`SKILL.md`](SKILL.md).

Digite `backend-dotnet` para escolher o fluxo manualmente. A família tem dois grupos de
invocação:

- **Só por nome** (`disable-model-invocation: true`): este roteador, `grill`, `triage`, `spec`,
  `tickets` e `code-review`. São os portões que você abre; o agente não os dispara sozinho e o
  roteador só consegue indicá-los.
- **Também descobertas pelo agente**: `implementation`, `domain`, `application`,
  `infrastructure`, `ioc`, `tests` e `logging`. São as etapas de trabalho do tronco comum, que
  precisam ser alcançadas durante a implementação sem você digitar cada uma. Em troca, suas
  descrições ficam carregadas em toda sessão.

A pasta `references/` é a fonte única de verdade para regras compartilhadas. Quando uma regra
corporativa mudar, atualize a referência correspondente e revise as skills que apontam para
ela.
