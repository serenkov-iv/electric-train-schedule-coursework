using System;
using System.Collections.Generic;

namespace VS_Kursovaya1.Models;

public partial class Train
{
    public int TrainId { get; set; }

    public string TrainNumber { get; set; } = null!;

    public string? TrainName { get; set; }

    public virtual ICollection<Schedule> Schedules { get; set; } = new List<Schedule>();
}
