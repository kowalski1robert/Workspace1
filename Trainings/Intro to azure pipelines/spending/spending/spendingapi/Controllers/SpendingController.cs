using Microsoft.AspNetCore.Mvc;
using spendingapi.Domain;

namespace spendingapi.Controllers;

[ApiController]
[Route("[controller]")]
public class SpendingController : ControllerBase
{
    private List<SpendingToMonthYearMapping> spendingToMonthYearMappingList;

    public SpendingController(List<SpendingToMonthYearMapping> spendingToMonthYearMappings)
    {
        spendingToMonthYearMappingList = spendingToMonthYearMappings;
    }

    [HttpGet]
    public List<Spending> Get(int year, int month) {
        var spendingToMonthYearMapping = spendingToMonthYearMappingList.FirstOrDefault(x => x.Month == month && x.Year == year);
        if (spendingToMonthYearMapping == null) {
            return new List<Spending>();
        }
        return spendingToMonthYearMapping.Spendings;
    }
}