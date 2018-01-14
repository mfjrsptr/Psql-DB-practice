--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.5
-- Dumped by pg_dump version 9.6.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: log_hewan_change(); Type: FUNCTION; Schema: public; Owner: muhammad
--

CREATE FUNCTION log_hewan_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if new.nama <> old.nama then 
insert into hewantosirkus (id_hwn, nama) 
values (old.id, old.nama);
end if;
return new;
end;
$$;


ALTER FUNCTION public.log_hewan_change() OWNER TO muhammad;

--
-- Name: log_kondisi_change(); Type: FUNCTION; Schema: public; Owner: muhammad
--

CREATE FUNCTION log_kondisi_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
update sirkus set total_kondisi = NEW.kondisi-10
where id_sirkus = new.id_pertunjukan;
return new;
end;
$$;


ALTER FUNCTION public.log_kondisi_change() OWNER TO muhammad;

--
-- Name: log_sirkus_nama_change(); Type: FUNCTION; Schema: public; Owner: muhammad
--

CREATE FUNCTION log_sirkus_nama_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
update sirkus set total_tampil = NEW.tampil*NEW.sirkus_mingguan
where id_sirkus = new.id_sirkus_;
return new;
end;
$$;


ALTER FUNCTION public.log_sirkus_nama_change() OWNER TO muhammad;

--
-- Name: log_tiket_change(); Type: FUNCTION; Schema: public; Owner: muhammad
--

CREATE FUNCTION log_tiket_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
if new.perubahan_tiket <> old.perubahan_tiket then 
insert into riwayat (id_histori, perubahan_tiket, waktu) 
values (old.id, old.perubahan_tiket, now());
end if;
return new;
end;
$$;


ALTER FUNCTION public.log_tiket_change() OWNER TO muhammad;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: hewan; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE hewan (
    id integer NOT NULL,
    jenis character varying(30),
    nama character varying(50),
    spesies character varying(30)
);


ALTER TABLE hewan OWNER TO muhammad;

--
-- Name: hewan_id_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE hewan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hewan_id_seq OWNER TO muhammad;

--
-- Name: hewan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE hewan_id_seq OWNED BY hewan.id;


--
-- Name: hewantosirkus; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE hewantosirkus (
    id_hewan integer NOT NULL,
    nama character varying(50),
    kondisi integer,
    id_hwn integer,
    id_pertunjukan integer,
    tampil integer,
    sirkus_mingguan integer,
    id_sirkus_ integer
);


ALTER TABLE hewantosirkus OWNER TO muhammad;

--
-- Name: hewantosirkus_id_hewan_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE hewantosirkus_id_hewan_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE hewantosirkus_id_hewan_seq OWNER TO muhammad;

--
-- Name: hewantosirkus_id_hewan_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE hewantosirkus_id_hewan_seq OWNED BY hewantosirkus.id_hewan;


--
-- Name: kebun_binatang; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE kebun_binatang (
    id integer NOT NULL,
    nama character varying(50),
    status character varying(10),
    usia integer,
    jk character(1)
);


ALTER TABLE kebun_binatang OWNER TO muhammad;

--
-- Name: kebun_binatang_id_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE kebun_binatang_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE kebun_binatang_id_seq OWNER TO muhammad;

--
-- Name: kebun_binatang_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE kebun_binatang_id_seq OWNED BY kebun_binatang.id;


--
-- Name: pengelola; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE pengelola (
    id integer,
    nama character varying(50),
    status character varying(10),
    jk character(1),
    kode integer
)
INHERITS (kebun_binatang);


ALTER TABLE pengelola OWNER TO muhammad;

--
-- Name: pengelola_event; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE pengelola_event (
    id integer,
    nama character varying(50),
    status character varying(10),
    usia integer,
    jk character(1),
    kode integer,
    jabatan character varying(30)
)
INHERITS (pengelola);


ALTER TABLE pengelola_event OWNER TO muhammad;

--
-- Name: pengelola_event_id_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE pengelola_event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pengelola_event_id_seq OWNER TO muhammad;

--
-- Name: pengelola_event_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE pengelola_event_id_seq OWNED BY pengelola_event.id;


--
-- Name: pengelola_id_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE pengelola_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pengelola_id_seq OWNER TO muhammad;

--
-- Name: pengelola_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE pengelola_id_seq OWNED BY pengelola.id;


--
-- Name: pengelola_tiket; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE pengelola_tiket (
    id integer,
    nama character varying(50),
    status character varying(10),
    usia integer,
    jk character(1),
    kode integer,
    jabatan character varying(30)
)
INHERITS (pengelola);


ALTER TABLE pengelola_tiket OWNER TO muhammad;

--
-- Name: pengelola_tiket_id_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE pengelola_tiket_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pengelola_tiket_id_seq OWNER TO muhammad;

--
-- Name: pengelola_tiket_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE pengelola_tiket_id_seq OWNED BY pengelola_tiket.id;


--
-- Name: pengunjung; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE pengunjung (
    id integer,
    nama character varying(50),
    kategori character varying(50),
    tgl_masuk date,
    perubahan_tiket integer,
    tiket_event integer
)
INHERITS (kebun_binatang);


ALTER TABLE pengunjung OWNER TO muhammad;

--
-- Name: pengunjung_id_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE pengunjung_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pengunjung_id_seq OWNER TO muhammad;

--
-- Name: pengunjung_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE pengunjung_id_seq OWNED BY pengunjung.id;


--
-- Name: riwayat; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE riwayat (
    id_riwayat integer NOT NULL,
    perubahan_tiket integer,
    waktu timestamp(6) without time zone,
    id_histori integer
);


ALTER TABLE riwayat OWNER TO muhammad;

--
-- Name: riwayat_id_riwayat_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE riwayat_id_riwayat_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE riwayat_id_riwayat_seq OWNER TO muhammad;

--
-- Name: riwayat_id_riwayat_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE riwayat_id_riwayat_seq OWNED BY riwayat.id_riwayat;


--
-- Name: sirkus; Type: TABLE; Schema: public; Owner: muhammad
--

CREATE TABLE sirkus (
    id_sirkus integer NOT NULL,
    total_kondisi integer,
    total_tampil integer
);


ALTER TABLE sirkus OWNER TO muhammad;

--
-- Name: sirkus_id_sirkus_seq; Type: SEQUENCE; Schema: public; Owner: muhammad
--

CREATE SEQUENCE sirkus_id_sirkus_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sirkus_id_sirkus_seq OWNER TO muhammad;

--
-- Name: sirkus_id_sirkus_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: muhammad
--

ALTER SEQUENCE sirkus_id_sirkus_seq OWNED BY sirkus.id_sirkus;


--
-- Name: hewan id; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY hewan ALTER COLUMN id SET DEFAULT nextval('hewan_id_seq'::regclass);


--
-- Name: hewantosirkus id_hewan; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY hewantosirkus ALTER COLUMN id_hewan SET DEFAULT nextval('hewantosirkus_id_hewan_seq'::regclass);


--
-- Name: kebun_binatang id; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY kebun_binatang ALTER COLUMN id SET DEFAULT nextval('kebun_binatang_id_seq'::regclass);


--
-- Name: pengelola id; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengelola ALTER COLUMN id SET DEFAULT nextval('pengelola_id_seq'::regclass);


--
-- Name: pengelola_event id; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengelola_event ALTER COLUMN id SET DEFAULT nextval('pengelola_event_id_seq'::regclass);


--
-- Name: pengelola_tiket id; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengelola_tiket ALTER COLUMN id SET DEFAULT nextval('pengelola_tiket_id_seq'::regclass);


--
-- Name: pengunjung id; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengunjung ALTER COLUMN id SET DEFAULT nextval('pengunjung_id_seq'::regclass);


--
-- Name: riwayat id_riwayat; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY riwayat ALTER COLUMN id_riwayat SET DEFAULT nextval('riwayat_id_riwayat_seq'::regclass);


--
-- Name: sirkus id_sirkus; Type: DEFAULT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY sirkus ALTER COLUMN id_sirkus SET DEFAULT nextval('sirkus_id_sirkus_seq'::regclass);


--
-- Data for Name: hewan; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY hewan (id, jenis, nama, spesies) FROM stdin;
1	karnivora	racha	harimau
2	karnivora	rika	buaya
4	omnivora	icirs	kucing
3	herbivora	boboboy	gajah
5	karnivora	rwr	singa
6	herbivora	gucu	kambing
7	herbivora	lulu	badak
8	omnivora	lika	panda
9	omnivora	rixy	monyet
\.


--
-- Name: hewan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('hewan_id_seq', 9, true);


--
-- Data for Name: hewantosirkus; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY hewantosirkus (id_hewan, nama, kondisi, id_hwn, id_pertunjukan, tampil, sirkus_mingguan, id_sirkus_) FROM stdin;
4	Rafi	\N	2	3	2	1	3
11	blacki	50	3	\N	\N	\N	\N
7	badak lumpur	100	2	6	3	2	6
5	bobo	\N	1	4	4	2	4
13	giza	\N	9	\N	\N	\N	\N
6	Raka	50	2	5	0	0	5
3	mimi	100	2	2	3	2	2
\.


--
-- Name: hewantosirkus_id_hewan_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('hewantosirkus_id_hewan_seq', 13, true);


--
-- Data for Name: kebun_binatang; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY kebun_binatang (id, nama, status, usia, jk) FROM stdin;
\.


--
-- Name: kebun_binatang_id_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('kebun_binatang_id_seq', 1, false);


--
-- Data for Name: pengelola; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY pengelola (id, nama, status, usia, jk, kode) FROM stdin;
\.


--
-- Data for Name: pengelola_event; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY pengelola_event (id, nama, status, usia, jk, kode, jabatan) FROM stdin;
1	iqbal	pengelola	20	l	111	pengelola event
\.


--
-- Name: pengelola_event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('pengelola_event_id_seq', 1, true);


--
-- Name: pengelola_id_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('pengelola_id_seq', 1, false);


--
-- Data for Name: pengelola_tiket; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY pengelola_tiket (id, nama, status, usia, jk, kode, jabatan) FROM stdin;
1	kifuath	pengelola	20	l	112	pengelola tiket
2	fajar	pengelola	20	l	113	pengelola tiket
\.


--
-- Name: pengelola_tiket_id_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('pengelola_tiket_id_seq', 2, true);


--
-- Data for Name: pengunjung; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY pengunjung (id, nama, status, usia, jk, kategori, tgl_masuk, perubahan_tiket, tiket_event) FROM stdin;
2	cantik	pengunjung	20	p	dewasa	2017-12-26	4	0
3	ayu	pengunjung	17	p	remaja	2017-12-25	2	0
5	gading	pengunjung	8	l	anak-anak	2017-12-26	1	0
4	diki	pengunjung	30	l	dewasa	2017-12-26	1	0
6	aji	pengunjung	20	l	dewasa	2017-12-27	2	0
7	oma yem	pengunjung	67	p	dewasa	2017-12-27	2	0
9	paman sam	pengunjung	34	l	dewasa	2017-12-27	5	0
\.


--
-- Name: pengunjung_id_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('pengunjung_id_seq', 9, true);


--
-- Data for Name: riwayat; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY riwayat (id_riwayat, perubahan_tiket, waktu, id_histori) FROM stdin;
2	7	2017-12-26 15:57:00.361604	3
3	1	2017-12-26 15:57:19.183434	3
4	5	2017-12-26 17:56:54.111602	4
5	1	2017-12-27 08:39:16.336878	6
6	3	2017-12-27 11:51:01.266967	9
\.


--
-- Name: riwayat_id_riwayat_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('riwayat_id_riwayat_seq', 6, true);


--
-- Data for Name: sirkus; Type: TABLE DATA; Schema: public; Owner: muhammad
--

COPY sirkus (id_sirkus, total_kondisi, total_tampil) FROM stdin;
1	\N	0
3	\N	2
6	90	6
4	\N	8
5	40	0
2	90	6
\.


--
-- Name: sirkus_id_sirkus_seq; Type: SEQUENCE SET; Schema: public; Owner: muhammad
--

SELECT pg_catalog.setval('sirkus_id_sirkus_seq', 1, false);


--
-- Name: hewan hewan_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY hewan
    ADD CONSTRAINT hewan_pkey PRIMARY KEY (id);


--
-- Name: hewantosirkus hewantosirkus_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY hewantosirkus
    ADD CONSTRAINT hewantosirkus_pkey PRIMARY KEY (id_hewan);


--
-- Name: kebun_binatang kebun_binatang_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY kebun_binatang
    ADD CONSTRAINT kebun_binatang_pkey PRIMARY KEY (id);


--
-- Name: pengelola_event pengelola_event_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengelola_event
    ADD CONSTRAINT pengelola_event_pkey PRIMARY KEY (id);


--
-- Name: pengelola pengelola_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengelola
    ADD CONSTRAINT pengelola_pkey PRIMARY KEY (id);


--
-- Name: pengelola_tiket pengelola_tiket_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengelola_tiket
    ADD CONSTRAINT pengelola_tiket_pkey PRIMARY KEY (id);


--
-- Name: pengunjung pengunjung_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY pengunjung
    ADD CONSTRAINT pengunjung_pkey PRIMARY KEY (id);


--
-- Name: riwayat riwayat_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY riwayat
    ADD CONSTRAINT riwayat_pkey PRIMARY KEY (id_riwayat);


--
-- Name: sirkus sirkus_pkey; Type: CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY sirkus
    ADD CONSTRAINT sirkus_pkey PRIMARY KEY (id_sirkus);


--
-- Name: hewantosirkus kondisi_change; Type: TRIGGER; Schema: public; Owner: muhammad
--

CREATE TRIGGER kondisi_change BEFORE UPDATE ON hewantosirkus FOR EACH ROW EXECUTE PROCEDURE log_kondisi_change();


--
-- Name: hewan nama_hewan_change; Type: TRIGGER; Schema: public; Owner: muhammad
--

CREATE TRIGGER nama_hewan_change BEFORE UPDATE ON hewan FOR EACH ROW EXECUTE PROCEDURE log_hewan_change();


--
-- Name: hewantosirkus sirkus_tampil_change; Type: TRIGGER; Schema: public; Owner: muhammad
--

CREATE TRIGGER sirkus_tampil_change BEFORE UPDATE ON hewantosirkus FOR EACH ROW EXECUTE PROCEDURE log_sirkus_nama_change();


--
-- Name: pengunjung tiket_change; Type: TRIGGER; Schema: public; Owner: muhammad
--

CREATE TRIGGER tiket_change BEFORE UPDATE ON pengunjung FOR EACH ROW EXECUTE PROCEDURE log_tiket_change();


--
-- Name: hewantosirkus hewantosirkus_id_pertunjukan_fkey; Type: FK CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY hewantosirkus
    ADD CONSTRAINT hewantosirkus_id_pertunjukan_fkey FOREIGN KEY (id_pertunjukan) REFERENCES sirkus(id_sirkus);


--
-- Name: hewantosirkus hewantosirkus_id_sirkus__fkey; Type: FK CONSTRAINT; Schema: public; Owner: muhammad
--

ALTER TABLE ONLY hewantosirkus
    ADD CONSTRAINT hewantosirkus_id_sirkus__fkey FOREIGN KEY (id_sirkus_) REFERENCES sirkus(id_sirkus);


--
-- PostgreSQL database dump complete
--

