using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class Schedule
{
    public int ScheduleId { get; set; }

    public int TrainId { get; set; }

    public int RouteId { get; set; }

    public TimeOnly DepartureTime { get; set; }

    public TimeOnly ArrivalTime { get; set; }

    public string DaysOfWeek { get; set; } = null!;

    public virtual Route Route { get; set; } = null!;

    public virtual Train Train { get; set; } = null!;

    public virtual ICollection<TripStatus> TripStatuses { get; set; } = new List<TripStatus>();
}
