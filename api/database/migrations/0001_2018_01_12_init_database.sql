--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

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
-- Name: cloud_provider; Type: TYPE; Schema: public; Owner: ezsetup
--

CREATE TYPE cloud_provider AS ENUM (
    'Openstack',
    'AWS',
    'GCloud',
    'Azure'
);


ALTER TYPE cloud_provider OWNER TO ezsetup;

--
-- Name: deploy_status; Type: TYPE; Schema: public; Owner: ezsetup
--

CREATE TYPE deploy_status AS ENUM (
    'inactive',
    'deploying',
    'deployfailed',
    'active',
    'destroying',
    'destroyfailed'
);


ALTER TYPE deploy_status OWNER TO ezsetup;

--
-- Name: request_status; Type: TYPE; Schema: public; Owner: ezsetup
--

CREATE TYPE request_status AS ENUM (
    'pending',
    'accepted'
);


ALTER TYPE request_status OWNER TO ezsetup;

--
-- Name: request_type; Type: TYPE; Schema: public; Owner: ezsetup
--

CREATE TYPE request_type AS ENUM (
    'join',
    'leave'
);


ALTER TYPE request_type OWNER TO ezsetup;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: cloudconfigs; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE cloudconfigs (
    id integer NOT NULL,
    detail jsonb,
    provider cloud_provider,
    lab_id integer
);


ALTER TABLE cloudconfigs OWNER TO ezsetup;

--
-- Name: cloudconfigs_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE cloudconfigs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE cloudconfigs_id_seq OWNER TO ezsetup;

--
-- Name: cloudconfigs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE cloudconfigs_id_seq OWNED BY cloudconfigs.id;


--
-- Name: instances; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE instances (
    id integer NOT NULL,
    name text,
    public_ip text,
    status deploy_status,
    password text,
    x integer,
    y integer,
    gid text,
    cloud_attrs jsonb,
    links jsonb[],
    image text,
    configurations jsonb[],
    flavor jsonb,
    slice_id integer
);


ALTER TABLE instances OWNER TO ezsetup;

--
-- Name: instances_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE instances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE instances_id_seq OWNER TO ezsetup;

--
-- Name: instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE instances_id_seq OWNED BY instances.id;


--
-- Name: labrequests; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE labrequests (
    id integer NOT NULL,
    lab_id integer,
    user_id integer,
    request_type request_type,
    status request_status
);


ALTER TABLE labrequests OWNER TO ezsetup;

--
-- Name: labrequests_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE labrequests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labrequests_id_seq OWNER TO ezsetup;

--
-- Name: labrequests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE labrequests_id_seq OWNED BY labrequests.id;


--
-- Name: labs; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE labs (
    id integer NOT NULL,
    name text,
    description text,
    status deploy_status,
    owner_id integer,
    scenario_id integer,
    preassessment_id integer,
    postassessment_id integer,
    allowed_attempts integer[]
);


ALTER TABLE labs OWNER TO ezsetup;

--
-- Name: labs_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE labs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE labs_id_seq OWNER TO ezsetup;

--
-- Name: labs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE labs_id_seq OWNED BY labs.id;


--
-- Name: networks; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE networks (
    id integer NOT NULL,
    name text,
    cidr text,
    status deploy_status,
    x integer,
    y integer,
    cloud_attrs jsonb,
    gid text,
    slice_id integer
);


ALTER TABLE networks OWNER TO ezsetup;

--
-- Name: networks_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE networks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE networks_id_seq OWNER TO ezsetup;

--
-- Name: networks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE networks_id_seq OWNED BY networks.id;


--
-- Name: routers; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE routers (
    id integer NOT NULL,
    name text,
    public_ip text,
    status deploy_status,
    password text,
    x integer,
    y integer,
    gid text,
    cloud_attrs jsonb,
    links jsonb[],
    image text,
    configurations jsonb[],
    flavor jsonb,
    slice_id integer
);


ALTER TABLE routers OWNER TO ezsetup;

--
-- Name: routers_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE routers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE routers_id_seq OWNER TO ezsetup;

--
-- Name: routers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE routers_id_seq OWNED BY routers.id;


--
-- Name: scenarios; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE scenarios (
    id integer NOT NULL,
    name text,
    description text,
    topo jsonb,
    is_public boolean,
    owner_id integer,
    sg_rules text[]
);


ALTER TABLE scenarios OWNER TO ezsetup;

--
-- Name: scenarios_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE scenarios_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE scenarios_id_seq OWNER TO ezsetup;

--
-- Name: scenarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE scenarios_id_seq OWNED BY scenarios.id;


--
-- Name: slices; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE slices (
    id integer NOT NULL,
    lab_id integer,
    user_id integer,
    name text,
    cloud_attrs jsonb,
    status deploy_status
);


ALTER TABLE slices OWNER TO ezsetup;

--
-- Name: slices_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE slices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE slices_id_seq OWNER TO ezsetup;

--
-- Name: slices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE slices_id_seq OWNED BY slices.id;


--
-- Name: userinfos; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE userinfos (
    id integer NOT NULL,
    user_id integer,
    permission_groups text[]
);


ALTER TABLE userinfos OWNER TO ezsetup;

--
-- Name: userinfos_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE userinfos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE userinfos_id_seq OWNER TO ezsetup;

--
-- Name: userinfos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE userinfos_id_seq OWNED BY userinfos.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE users (
    id integer NOT NULL,
    email text,
    fullname text,
    hash text,
    is_root boolean DEFAULT false
);


ALTER TABLE users OWNER TO ezsetup;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO ezsetup;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: cloudconfigs id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY cloudconfigs ALTER COLUMN id SET DEFAULT nextval('cloudconfigs_id_seq'::regclass);


--
-- Name: instances id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY instances ALTER COLUMN id SET DEFAULT nextval('instances_id_seq'::regclass);


--
-- Name: labrequests id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labrequests ALTER COLUMN id SET DEFAULT nextval('labrequests_id_seq'::regclass);


--
-- Name: labs id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labs ALTER COLUMN id SET DEFAULT nextval('labs_id_seq'::regclass);


--
-- Name: networks id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY networks ALTER COLUMN id SET DEFAULT nextval('networks_id_seq'::regclass);


--
-- Name: routers id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY routers ALTER COLUMN id SET DEFAULT nextval('routers_id_seq'::regclass);


--
-- Name: scenarios id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY scenarios ALTER COLUMN id SET DEFAULT nextval('scenarios_id_seq'::regclass);


--
-- Name: slices id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY slices ALTER COLUMN id SET DEFAULT nextval('slices_id_seq'::regclass);


--
-- Name: userinfos id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY userinfos ALTER COLUMN id SET DEFAULT nextval('userinfos_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: cloudconfigs; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY cloudconfigs (id, detail, provider, lab_id) FROM stdin;
\.


--
-- Name: cloudconfigs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('cloudconfigs_id_seq', 1, false);


--
-- Data for Name: instances; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY instances (id, name, public_ip, status, password, x, y, gid, cloud_attrs, links, image, configurations, flavor, slice_id) FROM stdin;
\.


--
-- Name: instances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('instances_id_seq', 1, false);


--
-- Data for Name: labrequests; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY labrequests (id, lab_id, user_id, request_type, status) FROM stdin;
\.


--
-- Name: labrequests_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('labrequests_id_seq', 1, false);


--
-- Data for Name: labs; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY labs (id, name, description, status, owner_id, scenario_id, preassessment_id, postassessment_id, allowed_attempts) FROM stdin;
\.


--
-- Name: labs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('labs_id_seq', 1, false);


--
-- Data for Name: networks; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY networks (id, name, cidr, status, x, y, cloud_attrs, gid, slice_id) FROM stdin;
\.


--
-- Name: networks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('networks_id_seq', 1, false);


--
-- Data for Name: routers; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY routers (id, name, public_ip, status, password, x, y, gid, cloud_attrs, links, image, configurations, flavor, slice_id) FROM stdin;
\.


--
-- Name: routers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('routers_id_seq', 1, false);


--
-- Data for Name: scenarios; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY scenarios (id, name, description, topo, is_public, owner_id, sg_rules) FROM stdin;
\.


--
-- Name: scenarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('scenarios_id_seq', 1, false);


--
-- Data for Name: slices; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY slices (id, lab_id, user_id, name, cloud_attrs, status) FROM stdin;
\.


--
-- Name: slices_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('slices_id_seq', 1, false);


--
-- Data for Name: userinfos; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY userinfos (id, user_id, permission_groups) FROM stdin;
1	1	{permissions,users,labs,scenarios}
\.


--
-- Name: userinfos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('userinfos_id_seq', 1, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY users (id, email, fullname, hash, is_root) FROM stdin;
1	root@ualr.edu	Root User	$argon2i$v=19$m=512,t=2,p=2$vBeCUOpdy5mzVipFaG0tZQ$aDnwiLsQyg3Dtk9gc0Ba4g	t
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('users_id_seq', 1, true);


--
-- Name: cloudconfigs cloudconfigs_lab_id_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY cloudconfigs
    ADD CONSTRAINT cloudconfigs_lab_id_key UNIQUE (lab_id);


--
-- Name: cloudconfigs cloudconfigs_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY cloudconfigs
    ADD CONSTRAINT cloudconfigs_pkey PRIMARY KEY (id);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: labrequests labrequests_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labrequests
    ADD CONSTRAINT labrequests_pkey PRIMARY KEY (id);


--
-- Name: labrequests labrequests_user_id_lab_id_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labrequests
    ADD CONSTRAINT labrequests_user_id_lab_id_key UNIQUE (user_id, lab_id);


--
-- Name: labs labs_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labs
    ADD CONSTRAINT labs_pkey PRIMARY KEY (id);


--
-- Name: networks networks_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY networks
    ADD CONSTRAINT networks_pkey PRIMARY KEY (id);


--
-- Name: routers routers_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY routers
    ADD CONSTRAINT routers_pkey PRIMARY KEY (id);


--
-- Name: scenarios scenarios_name_owner_id_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY scenarios
    ADD CONSTRAINT scenarios_name_owner_id_key UNIQUE (name, owner_id);


--
-- Name: scenarios scenarios_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY scenarios
    ADD CONSTRAINT scenarios_pkey PRIMARY KEY (id);


--
-- Name: slices slices_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY slices
    ADD CONSTRAINT slices_pkey PRIMARY KEY (id);


--
-- Name: userinfos userinfos_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY userinfos
    ADD CONSTRAINT userinfos_pkey PRIMARY KEY (id);


--
-- Name: userinfos userinfos_user_id_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY userinfos
    ADD CONSTRAINT userinfos_user_id_key UNIQUE (user_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cloudconfigs cloudconfigs_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY cloudconfigs
    ADD CONSTRAINT cloudconfigs_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES labs(id) ON DELETE CASCADE;


--
-- Name: instances instances_slice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY instances
    ADD CONSTRAINT instances_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES slices(id) ON DELETE CASCADE;


--
-- Name: labrequests labrequests_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labrequests
    ADD CONSTRAINT labrequests_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES labs(id) ON DELETE CASCADE;


--
-- Name: labrequests labrequests_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labrequests
    ADD CONSTRAINT labrequests_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: labs labs_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labs
    ADD CONSTRAINT labs_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: labs labs_scenario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY labs
    ADD CONSTRAINT labs_scenario_id_fkey FOREIGN KEY (scenario_id) REFERENCES scenarios(id) ON DELETE SET NULL;


--
-- Name: networks networks_slice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY networks
    ADD CONSTRAINT networks_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES slices(id) ON DELETE CASCADE;


--
-- Name: routers routers_slice_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY routers
    ADD CONSTRAINT routers_slice_id_fkey FOREIGN KEY (slice_id) REFERENCES slices(id) ON DELETE CASCADE;


--
-- Name: scenarios scenarios_owner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY scenarios
    ADD CONSTRAINT scenarios_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: slices slices_lab_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY slices
    ADD CONSTRAINT slices_lab_id_fkey FOREIGN KEY (lab_id) REFERENCES labs(id) ON DELETE CASCADE;


--
-- Name: slices slices_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY slices
    ADD CONSTRAINT slices_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


--
-- Name: userinfos userinfos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY userinfos
    ADD CONSTRAINT userinfos_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE;


-- Table info for Assessment Module

--
-- Name: assessments; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE assessments (
	id integer NOT NULL,
	atitle text,
	adescription text,
	questions text[],
	scores text[]
);

ALTER TABLE assessments OWNER TO ezsetup;

--
-- Name: assessments_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE assessments_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

ALTER TABLE assessments_id_seq OWNER TO ezsetup;

--
-- Name: assessments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE assessments_id_seq OWNED BY assessments.id;

--
-- Name: assessments id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY assessments ALTER COLUMN id SET DEFAULT nextval('assessments_id_seq'::regclass);

--
-- Data for Name: assessments; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY assessments (id, atitle, adescription, questions, scores) FROM stdin;
\.

--
-- Name: assessments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('assessments_id_seq', 1, false);

--
-- Name: assessments assessments_atitle_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY assessments
    ADD CONSTRAINT assessments_atitle_key UNIQUE (atitle);

--
-- Name: assessments assessments_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY assessments
    ADD CONSTRAINT assessments_pkey PRIMARY KEY (id);

--
-- Name: questions; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE questions (
	id integer NOT NULL,
	qkind text,
	qtitle text,
	qtext text,
	answers text[],
	correct text[],
	feedback text
);

ALTER TABLE questions OWNER TO ezsetup;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE questions_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

ALTER TABLE questions_id_seq OWNER TO ezsetup;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE questions_id_seq OWNED BY questions.id;

--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY questions ALTER COLUMN id SET DEFAULT nextval('questions_id_seq'::regclass);

--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY questions (id, qkind, qtitle, qtext, answers, correct, feedback) FROM stdin;
\.


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('questions_id_seq', 1, false);

--
-- Name: questions questions_qtitle_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_qtitle_key UNIQUE (qtitle);

--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);



--
-- Name: reports; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE reports (
	id integer NOT NULL,
	student text,
  labname text,
  assessmentid text,
  answers text[],
  starttime bigint,
  endtime bigint,
  pre_post integer,
  attempt_num integer
);

ALTER TABLE reports OWNER TO ezsetup;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE reports_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

ALTER TABLE reports_id_seq OWNER TO ezsetup;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE reports_id_seq OWNED BY reports.id;

--
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY reports ALTER COLUMN id SET DEFAULT nextval('reports_id_seq'::regclass);

--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY reports (id, student, labname, assessmentid, answers, starttime, endtime) FROM stdin;
\.

--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('reports_id_seq', 1, false);

--
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);

--
-- Name: grades; Type: TABLE; Schema: public; Owner: ezsetup
--

CREATE TABLE grades (
	id integer NOT NULL,
	student text,
  reportid integer,
  points text[],
  feedback text[],
  needsgrading text
);

ALTER TABLE grades OWNER TO ezsetup;

--
-- Name: grades_id_seq; Type: SEQUENCE; Schema: public; Owner: ezsetup
--

CREATE SEQUENCE grades_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MINVALUE
	NO MAXVALUE
	CACHE 1;

ALTER TABLE grades_id_seq OWNER TO ezsetup;

--
-- Name: grades_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ezsetup
--

ALTER SEQUENCE grades_id_seq OWNED BY grades.id;

--
-- Name: grades id; Type: DEFAULT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY grades ALTER COLUMN id SET DEFAULT nextval('grades_id_seq'::regclass);

--
-- Data for Name: grades; Type: TABLE DATA; Schema: public; Owner: ezsetup
--

COPY grades (id, student, reportid, points, feedback, needsgrading) FROM stdin;
\.

--
-- Name: grades_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ezsetup
--

SELECT pg_catalog.setval('grades_id_seq', 1, false);

--
-- Name: grades grades_reportid_key; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_reportid_key UNIQUE (reportid);

--
-- Name: grades grades_pkey; Type: CONSTRAINT; Schema: public; Owner: ezsetup
--

ALTER TABLE ONLY grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);

--
-- PostgreSQL database dump complete
--