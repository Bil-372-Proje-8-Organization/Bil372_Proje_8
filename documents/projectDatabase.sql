--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5 (Ubuntu 12.5-1.pgdg16.04+1)
-- Dumped by pg_dump version 13.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: schema; Type: SCHEMA; Schema: -; Owner: heqvalntzxdxvf
--

CREATE SCHEMA schema;


ALTER SCHEMA schema OWNER TO heqvalntzxdxvf;

--
-- Name: drivetrain_enum; Type: TYPE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TYPE public.drivetrain_enum AS ENUM (
    '4x4',
    'front wheel',
    'rear wheel'
);


ALTER TYPE public.drivetrain_enum OWNER TO heqvalntzxdxvf;

--
-- Name: type_enum; Type: TYPE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TYPE public.type_enum AS ENUM (
    'automobile',
    'motorcycle',
    'truck'
);


ALTER TYPE public.type_enum OWNER TO heqvalntzxdxvf;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: advertisement; Type: TABLE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TABLE public.advertisement (
    ad_no integer NOT NULL,
    seller_id integer NOT NULL,
    ad_date date,
    seller_price integer NOT NULL,
    vehicle_no integer NOT NULL,
    km integer NOT NULL,
    color character varying(50) NOT NULL,
    damage integer,
    second_hand character varying(5) NOT NULL,
    warranty character varying(5) NOT NULL,
    exchange character varying(5) NOT NULL
);


ALTER TABLE public.advertisement OWNER TO heqvalntzxdxvf;

--
-- Name: advertisement_ad_no_seq; Type: SEQUENCE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE SEQUENCE public.advertisement_ad_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.advertisement_ad_no_seq OWNER TO heqvalntzxdxvf;

--
-- Name: advertisement_ad_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: heqvalntzxdxvf
--

ALTER SEQUENCE public.advertisement_ad_no_seq OWNED BY public.advertisement.ad_no;


--
-- Name: city; Type: TABLE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TABLE public.city (
    city_id integer NOT NULL,
    city_name character varying(100) NOT NULL,
    country_code character(3) NOT NULL
);


ALTER TABLE public.city OWNER TO heqvalntzxdxvf;

--
-- Name: city_city_id_seq; Type: SEQUENCE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE SEQUENCE public.city_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_city_id_seq OWNER TO heqvalntzxdxvf;

--
-- Name: city_city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: heqvalntzxdxvf
--

ALTER SEQUENCE public.city_city_id_seq OWNED BY public.city.city_id;


--
-- Name: country; Type: TABLE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TABLE public.country (
    country_code character(3) NOT NULL,
    country_name character varying(50) NOT NULL
);


ALTER TABLE public.country OWNER TO heqvalntzxdxvf;

--
-- Name: model; Type: TABLE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TABLE public.model (
    model_name character varying(50),
    brand_name character varying(50),
    brand_model character varying(100) NOT NULL
);


ALTER TABLE public.model OWNER TO heqvalntzxdxvf;

--
-- Name: users; Type: TABLE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(25) NOT NULL,
    hashed_pswd text NOT NULL
);


ALTER TABLE public.users OWNER TO heqvalntzxdxvf;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO heqvalntzxdxvf;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: heqvalntzxdxvf
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: users_info; Type: TABLE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TABLE public.users_info (
    users_id integer NOT NULL,
    name character varying(100),
    surname character varying(100),
    city character varying(150),
    district character varying(100),
    phone character varying(20),
    mail character varying(150),
    user_score integer
);


ALTER TABLE public.users_info OWNER TO heqvalntzxdxvf;

--
-- Name: users_info_users_id_seq; Type: SEQUENCE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE SEQUENCE public.users_info_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_info_users_id_seq OWNER TO heqvalntzxdxvf;

--
-- Name: users_info_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: heqvalntzxdxvf
--

ALTER SEQUENCE public.users_info_users_id_seq OWNED BY public.users_info.users_id;


--
-- Name: vehicle; Type: TABLE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE TABLE public.vehicle (
    vehicle_no integer NOT NULL,
    brand_model character varying(100),
    transmission character varying(50),
    engine_size double precision,
    package character varying(50),
    drive_train public.drivetrain_enum NOT NULL,
    num_cylinder integer NOT NULL,
    power integer NOT NULL,
    dealer_price integer NOT NULL,
    type public.type_enum NOT NULL,
    year integer NOT NULL
);


ALTER TABLE public.vehicle OWNER TO heqvalntzxdxvf;

--
-- Name: vehicle_vehicle_no_seq; Type: SEQUENCE; Schema: public; Owner: heqvalntzxdxvf
--

CREATE SEQUENCE public.vehicle_vehicle_no_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.vehicle_vehicle_no_seq OWNER TO heqvalntzxdxvf;

--
-- Name: vehicle_vehicle_no_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: heqvalntzxdxvf
--

ALTER SEQUENCE public.vehicle_vehicle_no_seq OWNED BY public.vehicle.vehicle_no;


--
-- Name: advertisement ad_no; Type: DEFAULT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.advertisement ALTER COLUMN ad_no SET DEFAULT nextval('public.advertisement_ad_no_seq'::regclass);


--
-- Name: city city_id; Type: DEFAULT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.city ALTER COLUMN city_id SET DEFAULT nextval('public.city_city_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: users_info users_id; Type: DEFAULT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.users_info ALTER COLUMN users_id SET DEFAULT nextval('public.users_info_users_id_seq'::regclass);


--
-- Name: vehicle vehicle_no; Type: DEFAULT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.vehicle ALTER COLUMN vehicle_no SET DEFAULT nextval('public.vehicle_vehicle_no_seq'::regclass);


--
-- Data for Name: advertisement; Type: TABLE DATA; Schema: public; Owner: heqvalntzxdxvf
--

COPY public.advertisement (ad_no, seller_id, ad_date, seller_price, vehicle_no, km, color, damage, second_hand, warranty, exchange) FROM stdin;
7	3	2020-12-07	70000	1	250000	Yellow	0	Yes	No	No
8	2	2020-12-08	960000	5	4800	Blue	0	Yes	Yes	No
11	3	2020-12-08	100000	4	1000	Blue	0	Yes	Yes	No
12	7	2020-12-08	960000	11	185000	Dark Blue	0	Yes	Yes	No
13	7	2020-12-08	3700000	12	200000	Black	0	Yes	Yes	No
14	7	2020-12-08	430000	7	213000	Black	0	Yes	Yes	Yes
15	12	2020-12-08	298000	9	120000	Black	79	Yes	No	No
17	12	2020-12-08	645000	5	279000	Green	0	Yes	No	No
18	13	2020-12-08	312000	9	145000	White	0	Yes	Yes	No
19	14	2020-12-08	382000	3	230000	Black	4000	Yes	Yes	Yes
20	14	2020-12-08	177000	13	120000	Black	0	Yes	Yes	No
21	14	2020-12-08	300000	8	200000	White	0	Yes	Yes	No
22	16	2020-12-08	199999	13	0	Black	0	No	Yes	No
23	2	2020-12-08	800000	4	1500	White	20000	Yes	Yes	No
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: heqvalntzxdxvf
--

COPY public.city (city_id, city_name, country_code) FROM stdin;
1	Ankara	1  
2	Istanbul	1  
\.


--
-- Data for Name: country; Type: TABLE DATA; Schema: public; Owner: heqvalntzxdxvf
--

COPY public.country (country_code, country_name) FROM stdin;
1  	Turkey
\.


--
-- Data for Name: model; Type: TABLE DATA; Schema: public; Owner: heqvalntzxdxvf
--

COPY public.model (model_name, brand_name, brand_model) FROM stdin;
Dogan slx	Tofas	Tofas-Dogan slx
e-250	Mercedes	Mercedes-e250
420	BMW	BMW-420
430	BMW	BMW-430
Doblo	Fiat	Fiat-Doblo
a5 coupe	audi	audi-a5 coupe
a3	audi	audi-a3
a5	audi	audi-a5
XC90	volvo	volvo-XC90
G 63	Mercedes	Mercedes-G 63
T-max	Yamaha	Yamaha-T-max
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: heqvalntzxdxvf
--

COPY public.users (id, username, hashed_pswd) FROM stdin;
1	admin	admin
2	cenk	cenk
3	test	test
4	deneme	deneme
7	elifnurafsr	elif1234
8	newtest	newtest
9	test2	test2
10	test3	test3
11	atahanunl	unal
12	berkselenay58	sivas58
13	YigitOner	yoner00
14	IremKilinc	ikilinc99
15	ATABERKKONUKSEVEN	ataberk99
16	ataberk_konukseven	ata99
17	Ahmet	ahmet
\.


--
-- Data for Name: users_info; Type: TABLE DATA; Schema: public; Owner: heqvalntzxdxvf
--

COPY public.users_info (users_id, name, surname, city, district, phone, mail, user_score) FROM stdin;
1	Admin	Admin	Ankara	Cankaya	0-500-000-0000	admin@admin.com	5
2	Cenk	Gok	Ankara	Cankaya	0-500-000-0000	cenk@cenk.com	5
3	Test	Test	Ankara	Cankaya	0-500-000-1234	t@t.com	5
4	Deneme	Deneme	Ankara	Cankaya	0-500-000-0000	d@deneme.com	\N
7	Elif Nur	AFSAR	Ankara	Kecioren	0-555-666-6666	eafsar@etu.edu.tr	10
8	NewT	NewT	Istanbul	Nisantasi	0-500-000-0000	t@tt.com	5
9	NewT2	NewT2	Istanbul	Nisantasi	0-500-000-0000	t@tt.com	5
10	Test3	Test3	Istanbul	Taksim	0-500-000-0000	test3@test3.com	\N
11	Atahan	Unal	Ankara	Cankaya	0-532-532-0000	unal@gmail.com	\N
12	Berk	SELENAY	Ankara	Cankaya	0-555-555-5555	bselenay@gmail.com	\N
13	Yigit	ONER	Ankara	Cankaya	0-556-879-0606	yoner@gmail.com	\N
14	Irem	KILINC	Ankara	Golbasi	0-555-555-5555	ikilinc@etu.edu.tr	\N
15	Ataberk	KONUKSEVEN	Ankara	Cankaya	0-555-777-7788	akonukseven@outlook.com	\N
16	Ataberk	Konukseven	Ankara	Cankaya	0-555-888-8888	ata@gmail.com	\N
17	Ahmet	Ahmet	Istanbul	Beyoglu	0-500-000-0000	ahmet@gmail.om	\N
\.


--
-- Data for Name: vehicle; Type: TABLE DATA; Schema: public; Owner: heqvalntzxdxvf
--

COPY public.vehicle (vehicle_no, brand_model, transmission, engine_size, package, drive_train, num_cylinder, power, dealer_price, type, year) FROM stdin;
1	Tofas-Dogan slx	Manual	2000	Ultra luks	front wheel	20	180	50000	automobile	2019
3	Mercedes-e250	automatic	2500	elite	rear wheel	4	270	980000	automobile	2020
4	BMW-420	Automatic	2	M	rear wheel	6	315	820000	automobile	2020
5	BMW-430	Automatic	3	M	rear wheel	6	320	920000	automobile	2020
6	Fiat-Doblo	Manual	1298	Cargo	front wheel	4	95	134900	truck	2020
7	audi-a5 coupe	Automatic	1798	1.8 TFSI	front wheel	4	170	729000	automobile	2020
8	audi-a5 coupe	Manual	1800	1.8 TFSI	front wheel	4	170	700000	automobile	2020
9	audi-a3	Automatic	1598	1.6 TDI	front wheel	4	110	598000	automobile	2020
10	audi-a3	Manual	1600	1.6 TDI	front wheel	4	110	582000	automobile	2020
11	volvo-XC90	Automatic	1969	2.0 B5 Inscription	4x4	6	235	1500000	automobile	2020
12	Mercedes-G 63	Automatic	3982	Avandgarde	4x4	6	585	5000000	automobile	2020
13	Yamaha-T-max	Automatic	1000	None	front wheel	2	100	200000	motorcycle	2020
\.


--
-- Name: advertisement_ad_no_seq; Type: SEQUENCE SET; Schema: public; Owner: heqvalntzxdxvf
--

SELECT pg_catalog.setval('public.advertisement_ad_no_seq', 23, true);


--
-- Name: city_city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: heqvalntzxdxvf
--

SELECT pg_catalog.setval('public.city_city_id_seq', 1, false);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: heqvalntzxdxvf
--

SELECT pg_catalog.setval('public.users_id_seq', 17, true);


--
-- Name: users_info_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: heqvalntzxdxvf
--

SELECT pg_catalog.setval('public.users_info_users_id_seq', 1, false);


--
-- Name: vehicle_vehicle_no_seq; Type: SEQUENCE SET; Schema: public; Owner: heqvalntzxdxvf
--

SELECT pg_catalog.setval('public.vehicle_vehicle_no_seq', 13, true);


--
-- Name: advertisement advertisement_pkey; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT advertisement_pkey PRIMARY KEY (ad_no);


--
-- Name: city city_city_name_key; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_city_name_key UNIQUE (city_name);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (city_id, city_name);


--
-- Name: country country_country_name_key; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_country_name_key UNIQUE (country_name);


--
-- Name: country country_pkey; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.country
    ADD CONSTRAINT country_pkey PRIMARY KEY (country_code);


--
-- Name: model model_pkey; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.model
    ADD CONSTRAINT model_pkey PRIMARY KEY (brand_model);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: vehicle vehicle_pkey; Type: CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT vehicle_pkey PRIMARY KEY (vehicle_no);


--
-- Name: advertisement advertisement_seller_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT advertisement_seller_id_fkey FOREIGN KEY (seller_id) REFERENCES public.users(id);


--
-- Name: advertisement const_advertisement_vehicle_no_fk; Type: FK CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.advertisement
    ADD CONSTRAINT const_advertisement_vehicle_no_fk FOREIGN KEY (vehicle_no) REFERENCES public.vehicle(vehicle_no) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: city const_country_code_fk; Type: FK CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT const_country_code_fk FOREIGN KEY (country_code) REFERENCES public.country(country_code) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: vehicle const_vehicle_fk; Type: FK CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.vehicle
    ADD CONSTRAINT const_vehicle_fk FOREIGN KEY (brand_model) REFERENCES public.model(brand_model) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users_info users_info_city_fkey; Type: FK CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.users_info
    ADD CONSTRAINT users_info_city_fkey FOREIGN KEY (city) REFERENCES public.city(city_name);


--
-- Name: users_info users_info_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: heqvalntzxdxvf
--

ALTER TABLE ONLY public.users_info
    ADD CONSTRAINT users_info_users_id_fkey FOREIGN KEY (users_id) REFERENCES public.users(id);


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: heqvalntzxdxvf
--

REVOKE ALL ON SCHEMA public FROM postgres;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO heqvalntzxdxvf;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- Name: LANGUAGE plpgsql; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON LANGUAGE plpgsql TO heqvalntzxdxvf;


--
-- PostgreSQL database dump complete
--

