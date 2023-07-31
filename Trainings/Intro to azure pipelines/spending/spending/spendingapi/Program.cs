using spendingapi.Domain;

var builder = WebApplication.CreateBuilder(args);

var spendinglist = new List<Spending>() {
    new Spending() { Id = 1, Description = "Food", Amount = 100 },
    new Spending() { Id = 2, Description = "Clothes", Amount = 200 },
    new Spending() { Id = 3, Description = "Car", Amount = 300 },
    new Spending() { Id = 4, Description = "House", Amount = 400 },
    new Spending() { Id = 5, Description = "Phone", Amount = 500 },
    new Spending() { Id = 6, Description = "Computer", Amount = 600 },
    new Spending() { Id = 7, Description = "Gift", Amount = 700 },
    new Spending() { Id = 8, Description = "Other", Amount = 800 },
};



// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// add singleton service
builder.Services.AddSingleton<List<Spending>>(spendinglist);


var app = builder.Build();



// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
