using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VS_Kursovaya1.Data;

namespace VS_Kursovaya1.Controllers;

public class StatusController : Controller
{
    private readonly RailwayContext _context;

    public StatusController(RailwayContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index()
    {
        var statuses = await _context.VTodayStatuses
            .OrderBy(x => x.ScheduledDeparture)
            .ToListAsync();

        return View(statuses);
    }
}