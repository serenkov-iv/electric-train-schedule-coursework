using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class RouteStop
{
    public int RouteStopId { get; set; }

    public int RouteId { get; set; }

    public int StationId { get; set; }

    public int StopOrder { get; set; }

    public TimeOnly? ArrivalTime { get; set; }

    public TimeOnly? DepartureTime { get; set; }

    public virtual Route Route { get; set; } = null!;

    public virtual Station Station { get; set; } = null!;
}
