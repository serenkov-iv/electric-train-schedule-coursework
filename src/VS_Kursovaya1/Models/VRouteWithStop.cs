using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class VRouteWithStop
{
    public int? RouteId { get; set; }

    public string? TrainNumber { get; set; }

    public string? TrainName { get; set; }

    public string? DepartureStation { get; set; }

    public string? ArrivalStation { get; set; }

    public int? StopOrder { get; set; }

    public string? StopStation { get; set; }

    public TimeOnly? StopArrival { get; set; }

    public TimeOnly? StopDeparture { get; set; }

    public string? StopType { get; set; }
}
