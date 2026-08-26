# IoC .NET

Registro e organização de dependências no contêiner. Para a responsabilidade da camada consulte
`architecture.md`.

## Registro

`NativeInjectorBootstrapper.cs` compõe o registro chamando extension methods de configuração —
NHibernate, Redis, Polly, HttpClients, serviços, AWS, Kafka, AutoMapper e MVC — conforme os
recursos realmente utilizados pela solução. Mantenha o bootstrapper como composição legível:

```csharp
services.AddNHibernate(configuration, env);
services.AddRedis(configuration);
services.AddPoliticasPolly();
services.AddHttpClients(configuration);
services.AddServicos();
services.AddAws(configuration, env);
services.AddKafka(configuration, env);
services.AddAutoMapper(typeof(ArtistasProfile).Assembly);
```

Registros específicos ficam em uma classe de configuração co-localizada, por exemplo
`ServicosConfiguracoes.cs`, expondo uma extension method como `AddServicos`:

```csharp
internal static class ConfigurationServices
{
	public static IServiceCollection AddServicos(this IServiceCollection services)
	{
		services.AddSingleton<IHttpContextAccessor, HttpContextAccessor>();
		services.AddScoped<IUnitOfWork, UnitOfWork>();
		services.AddScoped<IUsuario, AspNetUser>();
		services.AddScoped<IEmailServico, EmailServico>();

		services.Scan(scan => scan
			.FromAssemblyOf<ArtistasAppServico>()
			.AddClasses()
			.AsImplementedInterfaces()
			.WithScopedLifetime());

		return services;
	}
}
```

**Concluído quando:** toda dependência nova aparece em um registro rastreável, o bootstrapper
chama a configuração correta e a classe consumidora pode ser construída pelo contêiner.

## Ciclo de vida

Escolha `Singleton`, `Scoped` ou `Transient` conforme o estado e as dependências do serviço.
Serviços ligados a request, sessão, Unit of Work ou contexto de banco permanecem dentro do
escopo correspondente.

**Concluído quando:** o ciclo de vida é compatível com cada dependência transitiva e nenhum
singleton captura um serviço scoped.

## Verificação

Execute o build e um teste de composição ou inicialização que resolva o serviço novo. Confirme
que não há registro duplicado conflitante e que o ambiente inicializa com suas configurações
válidas.

**Concluído quando:** a resolução do grafo passa no ambiente de validação e a mudança está
documentada no resumo da implementação.
