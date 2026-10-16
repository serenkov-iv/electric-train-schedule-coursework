using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class VExportSchedule
{
    public string? TrainNumber { get; set; }

    public string? TrainName { get; set; }

    public string? Departure { get; set; }

    public string? Arrival { get; set; }

    public TimeOnly? DepartureTime { get; set; }

    public TimeOnly? ArrivalTime { get; set; }

    public string? DaysOfWeek { get; set; }

    public decimal? DistanceKm { get; set; }
}
