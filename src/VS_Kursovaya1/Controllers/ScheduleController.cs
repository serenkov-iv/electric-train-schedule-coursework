using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VS_Kursovaya1.Data;

namespace VS_Kursovaya1.Controllers;

public class ScheduleController : Controller
{
    private readonly RailwayContext _context;

    public ScheduleController(RailwayContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index(string? search)
    {
        var query = _context.VScheduleFulls.AsQueryable();

        if (!string.IsNullOrWhiteSpace(search))
        {
            query = query.Where(x =>
                x.DepartureStation!.ToLower().Contains(search.ToLower()) ||
                x.ArrivalStation!.ToLower().Contains(search.ToLower()) ||
                x.DepartureCity!.ToLower().Contains(search.ToLower()) ||
                x.ArrivalCity!.ToLower().Contains(search.ToLower()) ||
                x.TrainNumber!.ToLower().Contains(search.ToLower()));
        }

        var schedule = await query
            .OrderBy(x => x.DepartureTime)
            .ToListAsync();

        ViewBag.Search = search;

        return View(schedule);
    }
}