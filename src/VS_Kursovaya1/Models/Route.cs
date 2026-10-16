using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class Route
{
    public int RouteId { get; set; }

    public int DepartureStationId { get; set; }

    public int ArrivalStationId { get; set; }

    public decimal? DistanceKm { get; set; }

    public virtual Station ArrivalStation { get; set; } = null!;

    public virtual Station DepartureStation { get; set; } = null!;

    public virtual ICollection<RouteStop> RouteStops { get; set; } = new List<RouteStop>();

    public virtual ICollection<Schedule> Schedules { get; set; } = new List<Schedule>();
}
