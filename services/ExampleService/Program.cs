var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// A handler that reads the various parts of the HTTP requests
// And echo it back to the sender to allow for easy debugging and exploration
app.MapGet("/{**catchall}", async (HttpContext context) => {
  var request = context.Request;

  // Collect all headers
  var headers = request.Headers.ToDictionary(
      header => header.Key,
      header => header.Value.ToString()
  );

  // Read body (if any)
  string body = "";
  if (request.ContentLength > 0)
  {
      using var reader = new StreamReader(request.Body);
      body = await reader.ReadToEndAsync();
  }

  // Prepare response object
  var echo = new
  {
      Method = request.Method,
      Path = request.Path,
      Query = request.Query.ToDictionary(q => q.Key, q => q.Value.ToString()),
      Headers = headers,
      Body = body
  };

  // Return JSON
  context.Response.ContentType = "application/json";
  await context.Response.WriteAsJsonAsync(echo);
});

app.Run();
