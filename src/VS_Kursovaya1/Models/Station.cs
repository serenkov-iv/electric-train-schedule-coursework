using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class Station
{
    public int StationId { get; set; }

    public string StationName { get; set; } = null!;

    public string City { get; set; } = null!;

    public virtual ICollection<Route> RouteArrivalStations { get; set; } = new List<Route>();

    public virtual ICollection<Route> RouteDepartureStations { get; set; } = new List<Route>();

    public virtual ICollection<RouteStop> RouteStops { get; set; } = new List<RouteStop>();
}
