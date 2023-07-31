using Xunit;
using spendingapi.Controllers;
using System.Collections.Generic;
using spendingapi.Domain;

namespace spendingapi.tests;

public class SpendingTest
{
    private int MONTH = 11;
    private int YEAR = 2022;
    private SpendingController spendingController;
    public SpendingTest()
    {
        var spendinglist = new List<Spending>() {
            new Spending() { Id = 1, Description = "Food", Amount = 100 },
            new Spending() { Id = 2, Description = "Clothes", Amount = 200 },
        };

        var spendingToMonthYearMappingList = new List<SpendingToMonthYearMapping>() {
            new SpendingToMonthYearMapping() { Month = MONTH, Year = YEAR, Spendings = spendinglist },
        };

        spendingController = new SpendingController(spendingToMonthYearMappingList);
    }

    [Fact]
    public void Should_Return_Spending_List()
    {
        var result = spendingController.Get(YEAR, MONTH);
        Assert.NotNull(result);
        Assert.Equal(2, result.Count);
    }

    [Fact]
    public void Should_Return_Empty_Spending_List()
    {
        var result = spendingController.Get(2021, 11);
        Assert.NotNull(result);
        Assert.Equal(0, result.Count);
    }
}