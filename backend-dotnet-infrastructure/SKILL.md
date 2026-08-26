---
name: backend-dotnet-infrastructure
description: Implementa persistência e integrações da infraestrutura .NET, especialmente NHibernate. Use quando o usuário pedir repositórios, mapeamentos, consultas, relacionamentos, Unit of Work ou alterações de banco na solução backend.
---

# Camada de Infraestrutura

Consulte `../backend-dotnet/references/architecture.md` e `../backend-dotnet/references/persistence.md`; valide os padrões existentes na solução antes de escolher uma extensão NHibernate.

## Mapeamento

Nomeie o mapeamento como `<Entidade>Map.cs` e faça a classe mapear a entidade correspondente. Declare tabela, identificador, colunas e relacionamentos explicitamente. Para relacionamentos, confirme cardinalidade, coluna estrangeira, nulabilidade e comportamento de entidade ausente antes de usar `References`, coleções ou `NotFound.Ignore()`.

**Concluído quando:** cada propriedade persistida tem mapeamento intencional, cada relacionamento tem cardinalidade e carregamento verificados, e o mapeamento está incluído na configuração da sessão.

## Repositórios e Unit of Work

Mantenha o contrato do repositório separado da implementação. Coloque consultas e comandos de persistência na infraestrutura; deixe regras de negócio no domínio. Preserve a transação e o ciclo de vida definidos pelo Unit of Work existente.

Propague `CancellationToken` nas operações assíncronas suportadas pelo provedor. Não invente uma abstração de persistência quando o contexto já possuir uma.

**Concluído quando:** a implementação usa as abstrações já adotadas, a transação é consistente com o fluxo e as operações novas têm teste ou validação de integração disponível.

## Dapper, HttpClient, filtros e consultas

Use Dapper somente quando o contexto já adotar SQL explícito e valide parâmetros, conexão, transação e mapeamento. Para APIs externas, separe Response externo da entidade interna e concentre conversão, timeout, cancelamento e tratamento de erro no repositório. Use filtros e consultas como objetos de leitura, mantendo suas composições livres de detalhes acidentais.

**Concluído quando:** a tecnologia escolhida coincide com o padrão do contexto, os parâmetros são seguros, o contrato externo não vaza para o domínio e a operação foi exercitada.

## Verificação

Execute build, testes aplicáveis e uma validação do mapeamento ou consulta contra o ambiente seguro disponível. Inspecione SQL ou plano de consulta quando a mudança puder alterar cardinalidade ou desempenho.

**Concluído quando:** o caminho de leitura/escrita foi exercitado, os relacionamentos não geram dados duplicados inesperados e nenhuma credencial ou dado sensível foi adicionado ao código ou ao log.
