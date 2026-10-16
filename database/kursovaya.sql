--
-- PostgreSQL database dump
--

\restrict PBRkXhnZtsfGBsEkBFc4eIvQEPXpTWA58hLOLeKQO1IHWSF6kHT0tG3J1BmHV6o

-- Dumped from database version 17.8
-- Dumped by pg_dump version 17.8

-- Started on 2026-10-16 21:41:18

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 16675)
-- Name: route_stops; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.route_stops (
    route_stop_id integer NOT NULL,
    route_id integer NOT NULL,
    station_id integer NOT NULL,
    stop_order integer NOT NULL,
    arrival_time time without time zone,
    departure_time time without time zone
);


--
-- TOC entry 225 (class 1259 OID 16674)
-- Name: route_stops_route_stop_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.route_stops_route_stop_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 225
-- Name: route_stops_route_stop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.route_stops_route_stop_id_seq OWNED BY public.route_stops.route_stop_id;


--
-- TOC entry 222 (class 1259 OID 16569)
-- Name: routes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.routes (
    route_id integer NOT NULL,
    departure_station_id integer NOT NULL,
    arrival_station_id integer NOT NULL,
    distance_km numeric(6,2),
    CONSTRAINT chk_different_stations CHECK ((departure_station_id <> arrival_station_id))
);


--
-- TOC entry 221 (class 1259 OID 16568)
-- Name: routes_route_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.routes_route_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 221
-- Name: routes_route_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.routes_route_id_seq OWNED BY public.routes.route_id;


--
-- TOC entry 224 (class 1259 OID 16587)
-- Name: schedule; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schedule (
    schedule_id integer NOT NULL,
    train_id integer NOT NULL,
    route_id integer NOT NULL,
    departure_time time without time zone NOT NULL,
    arrival_time time without time zone NOT NULL,
    days_of_week character varying(50) NOT NULL,
    CONSTRAINT chk_time CHECK ((arrival_time > departure_time))
);


--
-- TOC entry 223 (class 1259 OID 16586)
-- Name: schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4987 (class 0 OID 0)
-- Dependencies: 223
-- Name: schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schedule_schedule_id_seq OWNED BY public.schedule.schedule_id;


--
-- TOC entry 218 (class 1259 OID 16553)
-- Name: stations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stations (
    station_id integer NOT NULL,
    station_name character varying(150) NOT NULL,
    city character varying(100) NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 16552)
-- Name: stations_station_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stations_station_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4988 (class 0 OID 0)
-- Dependencies: 217
-- Name: stations_station_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stations_station_id_seq OWNED BY public.stations.station_id;


--
-- TOC entry 220 (class 1259 OID 16560)
-- Name: trains; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trains (
    train_id integer NOT NULL,
    train_number character varying(20) NOT NULL,
    train_name character varying(100)
);


--
-- TOC entry 219 (class 1259 OID 16559)
-- Name: trains_train_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trains_train_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4989 (class 0 OID 0)
-- Dependencies: 219
-- Name: trains_train_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trains_train_id_seq OWNED BY public.trains.train_id;


--
-- TOC entry 228 (class 1259 OID 16694)
-- Name: trip_status; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trip_status (
    trip_status_id integer NOT NULL,
    schedule_id integer NOT NULL,
    actual_date date NOT NULL,
    status character varying(20) DEFAULT 'on_time'::character varying NOT NULL,
    delay_minutes integer DEFAULT 0,
    note character varying(300),
    CONSTRAINT trip_status_status_check CHECK (((status)::text = ANY ((ARRAY['on_time'::character varying, 'delayed'::character varying, 'cancelled'::character varying])::text[])))
);


--
-- TOC entry 227 (class 1259 OID 16693)
-- Name: trip_status_trip_status_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.trip_status_trip_status_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 4990 (class 0 OID 0)
-- Dependencies: 227
-- Name: trip_status_trip_status_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.trip_status_trip_status_id_seq OWNED BY public.trip_status.trip_status_id;


--
-- TOC entry 232 (class 1259 OID 16725)
-- Name: v_export_schedule; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_export_schedule AS
 SELECT t.train_number,
    t.train_name,
    dep.station_name AS departure,
    arr.station_name AS arrival,
    s.departure_time,
    s.arrival_time,
    s.days_of_week,
    r.distance_km
   FROM ((((public.schedule s
     JOIN public.trains t ON ((s.train_id = t.train_id)))
     JOIN public.routes r ON ((s.route_id = r.route_id)))
     JOIN public.stations dep ON ((r.departure_station_id = dep.station_id)))
     JOIN public.stations arr ON ((r.arrival_station_id = arr.station_id)));


--
-- TOC entry 231 (class 1259 OID 16720)
-- Name: v_route_with_stops; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_route_with_stops AS
 SELECT r.route_id,
    t.train_number,
    t.train_name,
    dep.station_name AS departure_station,
    arr.station_name AS arrival_station,
    rs.stop_order,
    st.station_name AS stop_station,
    rs.arrival_time AS stop_arrival,
    rs.departure_time AS stop_departure,
        CASE
            WHEN (rs.stop_order = 1) THEN 'начальная'::text
            WHEN (rs.stop_order = ( SELECT max(rs2.stop_order) AS max
               FROM public.route_stops rs2
              WHERE (rs2.route_id = r.route_id))) THEN 'конечная'::text
            ELSE 'промежуточная'::text
        END AS stop_type
   FROM ((((((public.routes r
     JOIN public.schedule s ON ((r.route_id = s.route_id)))
     JOIN public.trains t ON ((s.train_id = t.train_id)))
     JOIN public.stations dep ON ((r.departure_station_id = dep.station_id)))
     JOIN public.stations arr ON ((r.arrival_station_id = arr.station_id)))
     JOIN public.route_stops rs ON ((r.route_id = rs.route_id)))
     JOIN public.stations st ON ((rs.station_id = st.station_id)));


--
-- TOC entry 229 (class 1259 OID 16710)
-- Name: v_schedule_full; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_schedule_full AS
 SELECT s.schedule_id,
    t.train_number,
    t.train_name,
    dep.station_name AS departure_station,
    dep.city AS departure_city,
    arr.station_name AS arrival_station,
    arr.city AS arrival_city,
    s.departure_time,
    s.arrival_time,
    s.days_of_week,
    r.distance_km,
    (EXTRACT(epoch FROM (s.arrival_time - s.departure_time)) / (60)::numeric) AS duration_minutes
   FROM ((((public.schedule s
     JOIN public.trains t ON ((s.train_id = t.train_id)))
     JOIN public.routes r ON ((s.route_id = r.route_id)))
     JOIN public.stations dep ON ((r.departure_station_id = dep.station_id)))
     JOIN public.stations arr ON ((r.arrival_station_id = arr.station_id)));


--
-- TOC entry 230 (class 1259 OID 16715)
-- Name: v_today_status; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.v_today_status AS
 SELECT s.schedule_id,
    t.train_number,
    t.train_name,
    dep.station_name AS departure_station,
    arr.station_name AS arrival_station,
    s.departure_time AS scheduled_departure,
    s.arrival_time AS scheduled_arrival,
    COALESCE(ts.status, 'on_time'::character varying) AS status,
    COALESCE(ts.delay_minutes, 0) AS delay_minutes,
    (s.departure_time + ((COALESCE(ts.delay_minutes, 0))::double precision * '00:01:00'::interval)) AS actual_departure,
    ts.note
   FROM (((((public.schedule s
     JOIN public.trains t ON ((s.train_id = t.train_id)))
     JOIN public.routes r ON ((s.route_id = r.route_id)))
     JOIN public.stations dep ON ((r.departure_station_id = dep.station_id)))
     JOIN public.stations arr ON ((r.arrival_station_id = arr.station_id)))
     LEFT JOIN public.trip_status ts ON (((s.schedule_id = ts.schedule_id) AND (ts.actual_date = CURRENT_DATE))));


--
-- TOC entry 4787 (class 2604 OID 16678)
-- Name: route_stops route_stop_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_stops ALTER COLUMN route_stop_id SET DEFAULT nextval('public.route_stops_route_stop_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 16572)
-- Name: routes route_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routes ALTER COLUMN route_id SET DEFAULT nextval('public.routes_route_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 16590)
-- Name: schedule schedule_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.schedule_schedule_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 16556)
-- Name: stations station_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stations ALTER COLUMN station_id SET DEFAULT nextval('public.stations_station_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 16563)
-- Name: trains train_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trains ALTER COLUMN train_id SET DEFAULT nextval('public.trains_train_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 16697)
-- Name: trip_status trip_status_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_status ALTER COLUMN trip_status_id SET DEFAULT nextval('public.trip_status_trip_status_id_seq'::regclass);


--
-- TOC entry 4977 (class 0 OID 16675)
-- Dependencies: 226
-- Data for Name: route_stops; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.route_stops (route_stop_id, route_id, station_id, stop_order, arrival_time, departure_time) FROM stdin;
94	1	1	1	\N	08:00:00
95	1	2	2	08:13:00	08:14:00
96	1	3	3	08:20:00	08:21:00
97	1	4	4	08:50:00	\N
98	2	1	1	\N	09:15:00
99	2	2	2	09:28:00	09:29:00
100	2	3	3	09:55:00	09:56:00
101	2	7	4	10:35:00	10:36:00
102	2	4	5	11:45:00	\N
103	3	1	1	\N	10:00:00
104	3	2	2	10:13:00	10:14:00
105	3	3	3	10:20:00	10:21:00
106	3	5	4	11:10:00	\N
107	4	1	1	\N	16:30:00
108	4	2	2	16:43:00	16:44:00
109	4	3	3	17:10:00	17:11:00
110	4	7	4	17:50:00	\N
111	5	1	1	\N	18:00:00
112	5	2	2	18:13:00	\N
113	6	3	1	\N	07:30:00
114	6	3	2	07:58:00	07:59:00
115	6	2	3	08:05:00	08:06:00
116	6	1	4	08:20:00	\N
117	7	4	1	\N	17:00:00
118	7	7	2	18:05:00	18:06:00
119	7	3	3	18:45:00	18:46:00
120	7	1	4	19:30:00	\N
\.


--
-- TOC entry 4973 (class 0 OID 16569)
-- Dependencies: 222
-- Data for Name: routes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.routes (route_id, departure_station_id, arrival_station_id, distance_km) FROM stdin;
1	1	3	45.50
2	1	4	167.00
3	1	5	65.00
4	1	7	89.00
5	1	2	18.00
6	3	1	45.50
7	4	1	167.00
53	1	5	65.00
54	1	7	89.00
55	1	2	18.00
56	3	1	45.50
57	4	1	167.00
\.


--
-- TOC entry 4975 (class 0 OID 16587)
-- Dependencies: 224
-- Data for Name: schedule; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.schedule (schedule_id, train_id, route_id, departure_time, arrival_time, days_of_week) FROM stdin;
1	1	1	08:00:00	08:50:00	Пн-Пт
2	2	2	09:15:00	11:45:00	Ежедневно
3	3	3	10:00:00	11:10:00	Ежедневно
4	4	4	16:30:00	17:50:00	Пн-Сб
5	5	5	18:00:00	18:13:00	Ежедневно
6	6	6	07:30:00	08:20:00	Пн-Пт
7	7	7	17:00:00	19:30:00	Ежедневно
8	1	1	08:00:00	08:50:00	Сб,Вс
21	3	3	10:00:00	11:10:00	Ежедневно
22	4	4	16:30:00	17:50:00	Пн-Сб
23	5	5	18:00:00	18:13:00	Ежедневно
24	6	6	07:30:00	08:20:00	Пн-Пт
25	7	7	17:00:00	19:30:00	Ежедневно
26	1	1	08:00:00	08:50:00	Сб,Вс
\.


--
-- TOC entry 4969 (class 0 OID 16553)
-- Dependencies: 218
-- Data for Name: stations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.stations (station_id, station_name, city) FROM stdin;
1	Ленинградский вокзал	Москва
2	Химки	Химки
3	Крюково	Зеленоград
4	Тверь	Тверь
5	Сходня	Химки
6	Подсолнечная	Солнечногорск
7	Клин	Клин
54	Сходня	Химки
55	Подсолнечная	Солнечногорск
56	Клин	Клин
\.


--
-- TOC entry 4971 (class 0 OID 16560)
-- Dependencies: 220
-- Data for Name: trains; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trains (train_id, train_number, train_name) FROM stdin;
1	6501	Москва–Крюково
2	6710	Москва–Тверь
5	7603	Москва–Химки
6	6505	Крюково–Москва
7	6718	Тверь–Москва
61	6503	Москва–Подсолнечная
62	6712	Москва–Клин
63	7601	Москва–Химки
64	6502	Крюково–Москва
65	6711	Тверь–Москва
3	6506	Москва–Подсолнечная
4	6716	Москва–Клин
\.


--
-- TOC entry 4979 (class 0 OID 16694)
-- Dependencies: 228
-- Data for Name: trip_status; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.trip_status (trip_status_id, schedule_id, actual_date, status, delay_minutes, note) FROM stdin;
18	1	2026-06-05	delayed	15	Ожидание отправления
19	2	2026-06-05	cancelled	0	Технические причины
20	3	2026-06-05	on_time	0	Без отклонений
21	4	2026-06-05	delayed	8	Ремонт путей
22	5	2026-06-05	cancelled	0	Отмена поезда
23	6	2026-06-05	delayed	10	Ожидание состава
\.


--
-- TOC entry 4991 (class 0 OID 0)
-- Dependencies: 225
-- Name: route_stops_route_stop_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.route_stops_route_stop_id_seq', 120, true);


--
-- TOC entry 4992 (class 0 OID 0)
-- Dependencies: 221
-- Name: routes_route_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.routes_route_id_seq', 57, true);


--
-- TOC entry 4993 (class 0 OID 0)
-- Dependencies: 223
-- Name: schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.schedule_schedule_id_seq', 26, true);


--
-- TOC entry 4994 (class 0 OID 0)
-- Dependencies: 217
-- Name: stations_station_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stations_station_id_seq', 56, true);


--
-- TOC entry 4995 (class 0 OID 0)
-- Dependencies: 219
-- Name: trains_train_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trains_train_id_seq', 65, true);


--
-- TOC entry 4996 (class 0 OID 0)
-- Dependencies: 227
-- Name: trip_status_trip_status_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.trip_status_trip_status_id_seq', 23, true);


--
-- TOC entry 4805 (class 2606 OID 16680)
-- Name: route_stops route_stops_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_stops
    ADD CONSTRAINT route_stops_pkey PRIMARY KEY (route_stop_id);


--
-- TOC entry 4807 (class 2606 OID 16682)
-- Name: route_stops route_stops_route_id_stop_order_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_stops
    ADD CONSTRAINT route_stops_route_id_stop_order_key UNIQUE (route_id, stop_order);


--
-- TOC entry 4801 (class 2606 OID 16575)
-- Name: routes routes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT routes_pkey PRIMARY KEY (route_id);


--
-- TOC entry 4803 (class 2606 OID 16593)
-- Name: schedule schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT schedule_pkey PRIMARY KEY (schedule_id);


--
-- TOC entry 4795 (class 2606 OID 16558)
-- Name: stations stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (station_id);


--
-- TOC entry 4797 (class 2606 OID 16565)
-- Name: trains trains_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trains
    ADD CONSTRAINT trains_pkey PRIMARY KEY (train_id);


--
-- TOC entry 4799 (class 2606 OID 16567)
-- Name: trains trains_train_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trains
    ADD CONSTRAINT trains_train_number_key UNIQUE (train_number);


--
-- TOC entry 4809 (class 2606 OID 16702)
-- Name: trip_status trip_status_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_status
    ADD CONSTRAINT trip_status_pkey PRIMARY KEY (trip_status_id);


--
-- TOC entry 4811 (class 2606 OID 16704)
-- Name: trip_status trip_status_schedule_id_actual_date_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_status
    ADD CONSTRAINT trip_status_schedule_id_actual_date_key UNIQUE (schedule_id, actual_date);


--
-- TOC entry 4812 (class 2606 OID 16581)
-- Name: routes fk_arrival_station; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT fk_arrival_station FOREIGN KEY (arrival_station_id) REFERENCES public.stations(station_id) ON DELETE CASCADE;


--
-- TOC entry 4813 (class 2606 OID 16576)
-- Name: routes fk_departure_station; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.routes
    ADD CONSTRAINT fk_departure_station FOREIGN KEY (departure_station_id) REFERENCES public.stations(station_id) ON DELETE CASCADE;


--
-- TOC entry 4814 (class 2606 OID 16599)
-- Name: schedule fk_route; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT fk_route FOREIGN KEY (route_id) REFERENCES public.routes(route_id) ON DELETE CASCADE;


--
-- TOC entry 4815 (class 2606 OID 16594)
-- Name: schedule fk_train; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schedule
    ADD CONSTRAINT fk_train FOREIGN KEY (train_id) REFERENCES public.trains(train_id) ON DELETE CASCADE;


--
-- TOC entry 4816 (class 2606 OID 16683)
-- Name: route_stops route_stops_route_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_stops
    ADD CONSTRAINT route_stops_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.routes(route_id) ON DELETE CASCADE;


--
-- TOC entry 4817 (class 2606 OID 16688)
-- Name: route_stops route_stops_station_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.route_stops
    ADD CONSTRAINT route_stops_station_id_fkey FOREIGN KEY (station_id) REFERENCES public.stations(station_id);


--
-- TOC entry 4818 (class 2606 OID 16705)
-- Name: trip_status trip_status_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.trip_status
    ADD CONSTRAINT trip_status_schedule_id_fkey FOREIGN KEY (schedule_id) REFERENCES public.schedule(schedule_id) ON DELETE CASCADE;


-- Completed on 2026-10-16 21:41:19

--
-- PostgreSQL database dump complete
--

\unrestrict PBRkXhnZtsfGBsEkBFc4eIvQEPXpTWA58hLOLeKQO1IHWSF6kHT0tG3J1BmHV6o

