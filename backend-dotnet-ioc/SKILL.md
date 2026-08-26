---
name: backend-dotnet-ioc
description: Registra e organiza dependências no IoC de soluções .NET. Use quando uma classe nova precisar de injeção, quando um serviço mudar de ciclo de vida ou quando a configuração de serviços precisar ser reorganizada.
---

# Camada de IoC

Consulte `../backend-dotnet/references/architecture.md`.

## Registro

Localize o `NativeInjectorBootstrapper.cs` do projeto. Ele deve chamar extension methods de configuração, como NHibernate, Redis, Polly, HttpClients, serviços, AWS, Kafka, AutoMapper e MVC, conforme os recursos realmente utilizados pela solução.

Coloque registros específicos em uma classe de configuração co-localizada, por exemplo `ServicosConfiguracoes.cs`, e exponha uma extension method como `AddServicos`. Mantenha o bootstrapper como composição legível, sem esconder regras de registro em locais inesperados.

**Concluído quando:** toda dependência nova aparece em um registro rastreável, o bootstrapper chama a configuração correta e a classe consumidora pode ser construída pelo contêiner.

Exemplo de composição:

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

Exemplo de configuração específica:

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

## Ciclo de vida

Escolha `Singleton`, `Scoped` ou `Transient` conforme o estado e as dependências do serviço. Serviços ligados a request, sessão, Unit of Work ou contexto de banco não devem escapar do escopo correspondente.

**Concluído quando:** o ciclo de vida é compatível com cada dependência transitiva e não há captura de serviço scoped por singleton.

## Verificação

Execute o build e um teste de composição ou inicialização que resolva o serviço novo. Confirme que não há registro duplicado conflitante e que o ambiente consegue inicializar com suas configurações válidas.

**Concluído quando:** a resolução do grafo passa no ambiente de validação e a mudança está documentada no resumo da implementação.
