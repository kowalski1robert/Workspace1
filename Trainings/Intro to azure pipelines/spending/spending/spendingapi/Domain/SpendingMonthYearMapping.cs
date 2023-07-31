

using spendingapi.Domain;

public class SpendingToMonthYearMapping
{
    public int Month { get; set; }
    public int Year { get; set; }
    public List<Spending> Spendings { get; set; }
}