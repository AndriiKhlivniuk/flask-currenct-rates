--
-- PostgreSQL database dump
--

-- Dumped from database version 15.1
-- Dumped by pg_dump version 15.1

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: currency_rates; Type: TABLE; Schema: public; Owner: andreykhlivniuk
--

CREATE TABLE public.currency_rates (
    id integer NOT NULL,
    date timestamp without time zone NOT NULL,
    eur double precision NOT NULL,
    cad double precision NOT NULL,
    pln double precision NOT NULL,
    uah double precision NOT NULL
);


ALTER TABLE public.currency_rates OWNER TO andreykhlivniuk;

--
-- Name: currency_rates_id_seq; Type: SEQUENCE; Schema: public; Owner: andreykhlivniuk
--

CREATE SEQUENCE public.currency_rates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currency_rates_id_seq OWNER TO andreykhlivniuk;

--
-- Name: currency_rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andreykhlivniuk
--

ALTER SEQUENCE public.currency_rates_id_seq OWNED BY public.currency_rates.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: andreykhlivniuk
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(80) NOT NULL,
    email character varying(120) NOT NULL
);


ALTER TABLE public."user" OWNER TO andreykhlivniuk;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: andreykhlivniuk
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO andreykhlivniuk;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andreykhlivniuk
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: currency_rates id; Type: DEFAULT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency_rates ALTER COLUMN id SET DEFAULT nextval('public.currency_rates_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: currency_rates; Type: TABLE DATA; Schema: public; Owner: andreykhlivniuk
--

COPY public.currency_rates (id, date, eur, cad, pln, uah) FROM stdin;
1	2023-02-07 00:00:00	0.934903	1.344345	4.453101	36.742001
3	2023-02-06 00:00:00	0.93526	1.345565	4.45641	36.742001
5	2023-02-05 00:00:00	0.93527	1.34545	4.45608	36.742001
6	2023-02-08 00:00:00	0.93049	1.337325	4.40525	36.678631
7	2023-02-04 00:00:00	0.93168	1.340485	4.415398	36.734667
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: andreykhlivniuk
--

COPY public."user" (id, username, email) FROM stdin;
1	johndoe	johndoe@example.com
\.


--
-- Name: currency_rates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andreykhlivniuk
--

SELECT pg_catalog.setval('public.currency_rates_id_seq', 9, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andreykhlivniuk
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: currency_rates currency_rates_date_key; Type: CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency_rates
    ADD CONSTRAINT currency_rates_date_key UNIQUE (date);


--
-- Name: currency_rates currency_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency_rates
    ADD CONSTRAINT currency_rates_pkey PRIMARY KEY (id);


--
-- Name: user user_email_key; Type: CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_email_key UNIQUE (email);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user user_username_key; Type: CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_username_key UNIQUE (username);


--
-- PostgreSQL database dump complete
--

