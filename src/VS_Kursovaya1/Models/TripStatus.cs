using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class TripStatus
{
    public int TripStatusId { get; set; }

    public int ScheduleId { get; set; }

    public DateOnly ActualDate { get; set; }

    public string Status { get; set; } = null!;

    public int? DelayMinutes { get; set; }

    public string? Note { get; set; }

    public virtual Schedule Schedule { get; set; } = null!;
}
