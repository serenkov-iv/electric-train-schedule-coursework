using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class VTodayStatus
{
    public int? ScheduleId { get; set; }

    public string? TrainNumber { get; set; }

    public string? TrainName { get; set; }

    public string? DepartureStation { get; set; }

    public string? ArrivalStation { get; set; }

    public TimeOnly? ScheduledDeparture { get; set; }

    public TimeOnly? ScheduledArrival { get; set; }

    public string? Status { get; set; }

    public int? DelayMinutes { get; set; }

    public TimeOnly? ActualDeparture { get; set; }

    public string? Note { get; set; }
}
