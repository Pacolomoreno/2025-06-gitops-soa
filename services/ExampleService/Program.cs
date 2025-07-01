var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/api/example", () => "Hello World!");

app.Run();
