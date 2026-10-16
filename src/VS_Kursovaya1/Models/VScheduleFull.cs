using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class VScheduleFull
{
    public int? ScheduleId { get; set; }

    public string? TrainNumber { get; set; }

    public string? TrainName { get; set; }

    public string? DepartureStation { get; set; }

    public string? DepartureCity { get; set; }

    public string? ArrivalStation { get; set; }

    public string? ArrivalCity { get; set; }

    public TimeOnly? DepartureTime { get; set; }

    public TimeOnly? ArrivalTime { get; set; }

    public string? DaysOfWeek { get; set; }

    public decimal? DistanceKm { get; set; }

    public decimal? DurationMinutes { get; set; }
}
