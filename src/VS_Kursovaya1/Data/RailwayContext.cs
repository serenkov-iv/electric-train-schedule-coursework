using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using VS_Kursovaya1.Models;
using DbRoute = VS_Kursovaya1.Models.Route;

namespace VS_Kursovaya1.Data;

public partial class RailwayContext : DbContext
{
    public RailwayContext()
    {
    }

    public RailwayContext(DbContextOptions<RailwayContext> options)
        : base(options)
    {
    }

    public virtual DbSet<DbRoute> Routes { get; set; }

    public virtual DbSet<RouteStop> RouteStops { get; set; }

    public virtual DbSet<Schedule> Schedules { get; set; }

    public virtual DbSet<Station> Stations { get; set; }

    public virtual DbSet<Train> Trains { get; set; }

    public virtual DbSet<TripStatus> TripStatuses { get; set; }

    public virtual DbSet<VExportSchedule> VExportSchedules { get; set; }

    public virtual DbSet<VRouteWithStop> VRouteWithStops { get; set; }

    public virtual DbSet<VScheduleFull> VScheduleFulls { get; set; }

    public virtual DbSet<VTodayStatus> VTodayStatuses { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseNpgsql("Host=localhost;Port=5432;Database=kursovaya;Username=postgres;Password=postgres");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<DbRoute>(entity =>
        {
            entity.HasKey(e => e.RouteId).HasName("routes_pkey");

            entity.ToTable("routes");

            entity.Property(e => e.RouteId).HasColumnName("route_id");
            entity.Property(e => e.ArrivalStationId).HasColumnName("arrival_station_id");
            entity.Property(e => e.DepartureStationId).HasColumnName("departure_station_id");
            entity.Property(e => e.DistanceKm)
                .HasPrecision(6, 2)
                .HasColumnName("distance_km");

            entity.HasOne(d => d.ArrivalStation).WithMany(p => p.RouteArrivalStations)
                .HasForeignKey(d => d.ArrivalStationId)
                .HasConstraintName("fk_arrival_station");

            entity.HasOne(d => d.DepartureStation).WithMany(p => p.RouteDepartureStations)
                .HasForeignKey(d => d.DepartureStationId)
                .HasConstraintName("fk_departure_station");
        });

        modelBuilder.Entity<RouteStop>(entity =>
        {
            entity.HasKey(e => e.RouteStopId).HasName("route_stops_pkey");

            entity.ToTable("route_stops");

            entity.HasIndex(e => new { e.RouteId, e.StopOrder }, "route_stops_route_id_stop_order_key").IsUnique();

            entity.Property(e => e.RouteStopId).HasColumnName("route_stop_id");
            entity.Property(e => e.ArrivalTime).HasColumnName("arrival_time");
            entity.Property(e => e.DepartureTime).HasColumnName("departure_time");
            entity.Property(e => e.RouteId).HasColumnName("route_id");
            entity.Property(e => e.StationId).HasColumnName("station_id");
            entity.Property(e => e.StopOrder).HasColumnName("stop_order");

            entity.HasOne(d => d.Route).WithMany(p => p.RouteStops)
                .HasForeignKey(d => d.RouteId)
                .HasConstraintName("route_stops_route_id_fkey");

            entity.HasOne(d => d.Station).WithMany(p => p.RouteStops)
                .HasForeignKey(d => d.StationId)
                .OnDelete(DeleteBehavior.ClientSetNull)
                .HasConstraintName("route_stops_station_id_fkey");
        });

        modelBuilder.Entity<Schedule>(entity =>
        {
            entity.HasKey(e => e.ScheduleId).HasName("schedule_pkey");

            entity.ToTable("schedule");

            entity.Property(e => e.ScheduleId).HasColumnName("schedule_id");
            entity.Property(e => e.ArrivalTime).HasColumnName("arrival_time");
            entity.Property(e => e.DaysOfWeek)
                .HasMaxLength(50)
                .HasColumnName("days_of_week");
            entity.Property(e => e.DepartureTime).HasColumnName("departure_time");
            entity.Property(e => e.RouteId).HasColumnName("route_id");
            entity.Property(e => e.TrainId).HasColumnName("train_id");

            entity.HasOne(d => d.Route).WithMany(p => p.Schedules)
                .HasForeignKey(d => d.RouteId)
                .HasConstraintName("fk_route");

            entity.HasOne(d => d.Train).WithMany(p => p.Schedules)
                .HasForeignKey(d => d.TrainId)
                .HasConstraintName("fk_train");
        });

        modelBuilder.Entity<Station>(entity =>
        {
            entity.HasKey(e => e.StationId).HasName("stations_pkey");

            entity.ToTable("stations");

            entity.Property(e => e.StationId).HasColumnName("station_id");
            entity.Property(e => e.City)
                .HasMaxLength(100)
                .HasColumnName("city");
            entity.Property(e => e.StationName)
                .HasMaxLength(150)
                .HasColumnName("station_name");
        });

        modelBuilder.Entity<Train>(entity =>
        {
            entity.HasKey(e => e.TrainId).HasName("trains_pkey");

            entity.ToTable("trains");

            entity.HasIndex(e => e.TrainNumber, "trains_train_number_key").IsUnique();

            entity.Property(e => e.TrainId).HasColumnName("train_id");
            entity.Property(e => e.TrainName)
                .HasMaxLength(100)
                .HasColumnName("train_name");
            entity.Property(e => e.TrainNumber)
                .HasMaxLength(20)
                .HasColumnName("train_number");
        });

        modelBuilder.Entity<TripStatus>(entity =>
        {
            entity.HasKey(e => e.TripStatusId).HasName("trip_status_pkey");

            entity.ToTable("trip_status");

            entity.HasIndex(e => new { e.ScheduleId, e.ActualDate }, "trip_status_schedule_id_actual_date_key").IsUnique();

            entity.Property(e => e.TripStatusId).HasColumnName("trip_status_id");
            entity.Property(e => e.ActualDate).HasColumnName("actual_date");
            entity.Property(e => e.DelayMinutes)
                .HasDefaultValue(0)
                .HasColumnName("delay_minutes");
            entity.Property(e => e.Note)
                .HasMaxLength(300)
                .HasColumnName("note");
            entity.Property(e => e.ScheduleId).HasColumnName("schedule_id");
            entity.Property(e => e.Status)
                .HasMaxLength(20)
                .HasDefaultValueSql("'on_time'::character varying")
                .HasColumnName("status");

            entity.HasOne(d => d.Schedule).WithMany(p => p.TripStatuses)
                .HasForeignKey(d => d.ScheduleId)
                .HasConstraintName("trip_status_schedule_id_fkey");
        });

        modelBuilder.Entity<VExportSchedule>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("v_export_schedule");

            entity.Property(e => e.Arrival)
                .HasMaxLength(150)
                .HasColumnName("arrival");
            entity.Property(e => e.ArrivalTime).HasColumnName("arrival_time");
            entity.Property(e => e.DaysOfWeek)
                .HasMaxLength(50)
                .HasColumnName("days_of_week");
            entity.Property(e => e.Departure)
                .HasMaxLength(150)
                .HasColumnName("departure");
            entity.Property(e => e.DepartureTime).HasColumnName("departure_time");
            entity.Property(e => e.DistanceKm)
                .HasPrecision(6, 2)
                .HasColumnName("distance_km");
            entity.Property(e => e.TrainName)
                .HasMaxLength(100)
                .HasColumnName("train_name");
            entity.Property(e => e.TrainNumber)
                .HasMaxLength(20)
                .HasColumnName("train_number");
        });

        modelBuilder.Entity<VRouteWithStop>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("v_route_with_stops");

            entity.Property(e => e.ArrivalStation)
                .HasMaxLength(150)
                .HasColumnName("arrival_station");
            entity.Property(e => e.DepartureStation)
                .HasMaxLength(150)
                .HasColumnName("departure_station");
            entity.Property(e => e.RouteId).HasColumnName("route_id");
            entity.Property(e => e.StopArrival).HasColumnName("stop_arrival");
            entity.Property(e => e.StopDeparture).HasColumnName("stop_departure");
            entity.Property(e => e.StopOrder).HasColumnName("stop_order");
            entity.Property(e => e.StopStation)
                .HasMaxLength(150)
                .HasColumnName("stop_station");
            entity.Property(e => e.StopType).HasColumnName("stop_type");
            entity.Property(e => e.TrainName)
                .HasMaxLength(100)
                .HasColumnName("train_name");
            entity.Property(e => e.TrainNumber)
                .HasMaxLength(20)
                .HasColumnName("train_number");
        });

        modelBuilder.Entity<VScheduleFull>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("v_schedule_full");

            entity.Property(e => e.ArrivalCity)
                .HasMaxLength(100)
                .HasColumnName("arrival_city");
            entity.Property(e => e.ArrivalStation)
                .HasMaxLength(150)
                .HasColumnName("arrival_station");
            entity.Property(e => e.ArrivalTime).HasColumnName("arrival_time");
            entity.Property(e => e.DaysOfWeek)
                .HasMaxLength(50)
                .HasColumnName("days_of_week");
            entity.Property(e => e.DepartureCity)
                .HasMaxLength(100)
                .HasColumnName("departure_city");
            entity.Property(e => e.DepartureStation)
                .HasMaxLength(150)
                .HasColumnName("departure_station");
            entity.Property(e => e.DepartureTime).HasColumnName("departure_time");
            entity.Property(e => e.DistanceKm)
                .HasPrecision(6, 2)
                .HasColumnName("distance_km");
            entity.Property(e => e.DurationMinutes).HasColumnName("duration_minutes");
            entity.Property(e => e.ScheduleId).HasColumnName("schedule_id");
            entity.Property(e => e.TrainName)
                .HasMaxLength(100)
                .HasColumnName("train_name");
            entity.Property(e => e.TrainNumber)
                .HasMaxLength(20)
                .HasColumnName("train_number");
        });

        modelBuilder.Entity<VTodayStatus>(entity =>
        {
            entity
                .HasNoKey()
                .ToView("v_today_status");

            entity.Property(e => e.ActualDeparture).HasColumnName("actual_departure");
            entity.Property(e => e.ArrivalStation)
                .HasMaxLength(150)
                .HasColumnName("arrival_station");
            entity.Property(e => e.DelayMinutes).HasColumnName("delay_minutes");
            entity.Property(e => e.DepartureStation)
                .HasMaxLength(150)
                .HasColumnName("departure_station");
            entity.Property(e => e.Note)
                .HasMaxLength(300)
                .HasColumnName("note");
            entity.Property(e => e.ScheduleId).HasColumnName("schedule_id");
            entity.Property(e => e.ScheduledArrival).HasColumnName("scheduled_arrival");
            entity.Property(e => e.ScheduledDeparture).HasColumnName("scheduled_departure");
            entity.Property(e => e.Status)
                .HasColumnType("character varying")
                .HasColumnName("status");
            entity.Property(e => e.TrainName)
                .HasMaxLength(100)
                .HasColumnName("train_name");
            entity.Property(e => e.TrainNumber)
                .HasMaxLength(20)
                .HasColumnName("train_number");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
