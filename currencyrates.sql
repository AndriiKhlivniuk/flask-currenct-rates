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
-- Name: currency; Type: TABLE; Schema: public; Owner: andreykhlivniuk
--

CREATE TABLE public.currency (
    id integer NOT NULL,
    code character varying(3) NOT NULL
);


ALTER TABLE public.currency OWNER TO andreykhlivniuk;

--
-- Name: currency_id_seq; Type: SEQUENCE; Schema: public; Owner: andreykhlivniuk
--

CREATE SEQUENCE public.currency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.currency_id_seq OWNER TO andreykhlivniuk;

--
-- Name: currency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: andreykhlivniuk
--

ALTER SEQUENCE public.currency_id_seq OWNED BY public.currency.id;


--
-- Name: currency_rates; Type: TABLE; Schema: public; Owner: andreykhlivniuk
--

CREATE TABLE public.currency_rates (
    id integer NOT NULL,
    date timestamp with time zone NOT NULL,
    currency_id integer NOT NULL,
    rate double precision NOT NULL
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
-- Name: currency id; Type: DEFAULT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency ALTER COLUMN id SET DEFAULT nextval('public.currency_id_seq'::regclass);


--
-- Name: currency_rates id; Type: DEFAULT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency_rates ALTER COLUMN id SET DEFAULT nextval('public.currency_rates_id_seq'::regclass);


--
-- Data for Name: currency; Type: TABLE DATA; Schema: public; Owner: andreykhlivniuk
--

COPY public.currency (id, code) FROM stdin;
3	UAH
4	PLN
5	EUR
6	CAD
\.


--
-- Data for Name: currency_rates; Type: TABLE DATA; Schema: public; Owner: andreykhlivniuk
--

COPY public.currency_rates (id, date, currency_id, rate) FROM stdin;
3	2023-02-24 12:41:48.870164+02	3	36.759923
4	2023-02-24 12:41:48.887082+02	4	4.459097
5	2023-02-24 12:41:48.904639+02	5	0.94392
6	2023-02-24 12:41:48.976191+02	6	1.356895
7	2023-02-24 12:45:29.82581+02	3	36.759923
8	2023-02-24 12:45:29.846066+02	4	4.459128
9	2023-02-24 12:45:29.852723+02	5	0.94397
10	2023-02-24 12:45:29.858775+02	6	1.357115
\.


--
-- Name: currency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andreykhlivniuk
--

SELECT pg_catalog.setval('public.currency_id_seq', 6, true);


--
-- Name: currency_rates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: andreykhlivniuk
--

SELECT pg_catalog.setval('public.currency_rates_id_seq', 10, true);


--
-- Name: currency currency_pkey; Type: CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency
    ADD CONSTRAINT currency_pkey PRIMARY KEY (id);


--
-- Name: currency_rates currency_rates_pkey; Type: CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency_rates
    ADD CONSTRAINT currency_rates_pkey PRIMARY KEY (id);


--
-- Name: currency_rates currency_rates_currency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: andreykhlivniuk
--

ALTER TABLE ONLY public.currency_rates
    ADD CONSTRAINT currency_rates_currency_id_fkey FOREIGN KEY (currency_id) REFERENCES public.currency(id);


--
-- PostgreSQL database dump complete
--

