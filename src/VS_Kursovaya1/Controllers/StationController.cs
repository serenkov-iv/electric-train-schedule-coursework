using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using VS_Kursovaya1.Data;

namespace VS_Kursovaya1.Controllers;

public class StationController : Controller
{
    private readonly RailwayContext _context;

    public StationController(RailwayContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index()
    {
        var allStations = await _context.Stations
            .OrderBy(x => x.StationName)
            .ToListAsync();

        var stations = allStations
            .GroupBy(x => new { x.StationName, x.City })
            .Select(g => g.First())
            .ToList();

        return View(stations);
    }
}