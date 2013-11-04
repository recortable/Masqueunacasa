--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: unaccent; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS unaccent WITH SCHEMA public;


--
-- Name: EXTENSION unaccent; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION unaccent IS 'text search dictionary that removes accents';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: activities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE activities (
    id integer NOT NULL,
    trackable_id integer,
    trackable_type character varying(255),
    owner_id integer,
    owner_type character varying(255),
    key character varying(255),
    parameters text,
    recipient_id integer,
    recipient_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    notified boolean DEFAULT false
);


--
-- Name: activities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE activities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE activities_id_seq OWNED BY activities.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE categories (
    id integer NOT NULL,
    phase_id integer,
    user_id integer,
    slug_es character varying(100),
    slug_ca character varying(100),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    body_type character varying(16),
    "position" integer,
    kudos_count integer DEFAULT 0,
    view_count integer DEFAULT 0,
    editorships_count integer DEFAULT 0,
    image character varying(255),
    slug_en character varying(100),
    slug_it character varying(100),
    slug_fr character varying(100),
    original_locale character varying(4)
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: category_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE category_translations (
    id integer NOT NULL,
    category_id integer,
    locale character varying(255),
    title character varying(300),
    name character varying(100),
    summary text,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: category_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE category_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: category_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE category_translations_id_seq OWNED BY category_translations.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    body text,
    user_id integer,
    document_id integer,
    document_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    locale character varying(6)
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: editorships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE editorships (
    id integer NOT NULL,
    document_id integer,
    document_type character varying(16),
    user_id integer,
    created_at timestamp without time zone
);


--
-- Name: editorships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE editorships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: editorships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE editorships_id_seq OWNED BY editorships.id;


--
-- Name: experiencie_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE experiencie_translations (
    id integer NOT NULL,
    experiencie_id integer,
    locale character varying(255),
    title character varying(300),
    summary text,
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: experiencie_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE experiencie_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: experiencie_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE experiencie_translations_id_seq OWNED BY experiencie_translations.id;


--
-- Name: experiencies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE experiencies (
    id integer NOT NULL,
    user_id integer,
    group_id integer,
    slug_es character varying(300),
    slug_ca character varying(300),
    published boolean DEFAULT true,
    proposals_count integer DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    body_type character varying(16),
    kudos_count integer DEFAULT 0,
    view_count integer DEFAULT 0,
    editorships_count integer DEFAULT 0,
    slug_en character varying(100),
    slug_it character varying(100),
    slug_fr character varying(100),
    original_locale character varying(4)
);


--
-- Name: experiencies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE experiencies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: experiencies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE experiencies_id_seq OWNED BY experiencies.id;


--
-- Name: friendly_id_slugs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE friendly_id_slugs (
    id integer NOT NULL,
    slug character varying(255) NOT NULL,
    sluggable_id integer NOT NULL,
    sluggable_type character varying(40),
    created_at timestamp without time zone
);


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE friendly_id_slugs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: friendly_id_slugs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE friendly_id_slugs_id_seq OWNED BY friendly_id_slugs.id;


--
-- Name: group_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE group_translations (
    id integer NOT NULL,
    group_id integer,
    locale character varying(255),
    title character varying(300),
    summary text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: group_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE group_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: group_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE group_translations_id_seq OWNED BY group_translations.id;


--
-- Name: groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE groups (
    id integer NOT NULL,
    name character varying(50),
    slug character varying(50),
    avatar_image character varying(255),
    email character varying(255),
    settings text,
    kudos_count integer DEFAULT 0,
    view_count integer DEFAULT 0,
    user_id integer,
    memberships_count integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    original_locale character varying(3)
);


--
-- Name: groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE groups_id_seq OWNED BY groups.id;


--
-- Name: help_page_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE help_page_translations (
    id integer NOT NULL,
    help_page_id integer,
    locale character varying(255),
    title character varying(255),
    summary text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: help_page_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE help_page_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: help_page_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE help_page_translations_id_seq OWNED BY help_page_translations.id;


--
-- Name: help_pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE help_pages (
    id integer NOT NULL,
    identf character varying(30) NOT NULL,
    description text,
    slug_ca character varying(255),
    slug_en character varying(255),
    slug_es character varying(255),
    slug_it character varying(255),
    slug_fr character varying(255),
    original_locale character varying(10) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    blocked boolean
);


--
-- Name: help_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE help_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: help_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE help_pages_id_seq OWNED BY help_pages.id;


--
-- Name: help_text_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE help_text_translations (
    id integer NOT NULL,
    help_text_id integer,
    locale character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: help_text_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE help_text_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: help_text_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE help_text_translations_id_seq OWNED BY help_text_translations.id;


--
-- Name: help_texts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE help_texts (
    id integer NOT NULL,
    identf character varying(30) NOT NULL,
    description character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    blocked boolean
);


--
-- Name: help_texts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE help_texts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: help_texts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE help_texts_id_seq OWNED BY help_texts.id;


--
-- Name: images; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE images (
    id integer NOT NULL,
    title character varying(200),
    image character varying(255),
    user_id integer,
    imageable_id integer,
    imageable_type character varying(255),
    "position" integer,
    credits character varying(300)
);


--
-- Name: images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE images_id_seq OWNED BY images.id;


--
-- Name: kudos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE kudos (
    id integer NOT NULL,
    document_id integer,
    document_type character varying(16),
    user_id integer,
    ip character varying(16),
    created_at timestamp without time zone
);


--
-- Name: kudos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE kudos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: kudos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE kudos_id_seq OWNED BY kudos.id;


--
-- Name: links; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE links (
    id integer NOT NULL,
    user_id integer,
    title character varying(300),
    url character varying(500),
    content_type character varying(32),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    document_id integer,
    document_type character varying(32)
);


--
-- Name: links_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE links_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: links_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE links_id_seq OWNED BY links.id;


--
-- Name: locations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE locations (
    id integer NOT NULL,
    resource_type character varying(16),
    resource_id integer,
    user_id integer,
    latitude double precision,
    longitude double precision,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    country character varying(255),
    region character varying(255),
    locality character varying(255),
    address character varying(255),
    normalized_address character varying(255)
);


--
-- Name: locations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE locations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: locations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE locations_id_seq OWNED BY locations.id;


--
-- Name: memberships; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE memberships (
    id integer NOT NULL,
    group_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE memberships_id_seq OWNED BY memberships.id;


--
-- Name: phase_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phase_translations (
    id integer NOT NULL,
    phase_id integer,
    locale character varying(255),
    title character varying(50),
    summary text,
    question character varying(300),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: phase_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phase_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phase_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phase_translations_id_seq OWNED BY phase_translations.id;


--
-- Name: phases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phases (
    id integer NOT NULL,
    slug_es character varying(50),
    slug_ca character varying(50),
    "position" integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    kudos_count integer DEFAULT 0,
    view_count integer DEFAULT 0,
    slug_en character varying(50),
    slug_it character varying(100),
    slug_fr character varying(100),
    original_locale character varying(4),
    video character varying(255)
);


--
-- Name: phases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phases_id_seq OWNED BY phases.id;


--
-- Name: proposal_translations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE proposal_translations (
    id integer NOT NULL,
    proposal_id integer,
    locale character varying(255),
    title character varying(200),
    description character varying(1000),
    body text,
    summary text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: proposal_translations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE proposal_translations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: proposal_translations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE proposal_translations_id_seq OWNED BY proposal_translations.id;


--
-- Name: proposals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE proposals (
    id integer NOT NULL,
    slug_es character varying(200),
    slug_ca character varying(200),
    user_id integer,
    phase_id integer,
    group_id integer,
    published boolean DEFAULT true,
    settings text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    category_id integer,
    body_type character varying(16),
    "position" integer,
    kudos_count integer DEFAULT 0,
    view_count integer DEFAULT 0,
    editorships_count integer DEFAULT 0,
    experiencies_count integer DEFAULT 0,
    slug_en character varying(100),
    slug_it character varying(100),
    slug_fr character varying(100),
    original_locale character varying(4)
);


--
-- Name: proposals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE proposals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: proposals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE proposals_id_seq OWNED BY proposals.id;


--
-- Name: relations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE relations (
    id integer NOT NULL,
    experiencie_id integer,
    proposal_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    phase_id integer,
    category_id integer
);


--
-- Name: relations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE relations_id_seq OWNED BY relations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sections (
    id integer NOT NULL,
    locale character varying(2),
    "position" integer NOT NULL,
    title character varying(200),
    body text,
    image character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    document_id integer,
    document_type character varying(16),
    group_id integer,
    type character varying(80)
);


--
-- Name: searches; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW searches AS
    (((SELECT proposals.id AS searchable_id, 'Proposal'::text AS searchable_type, proposal_translations.title, ''::text AS section_title, proposal_translations.summary AS text, proposal_translations.locale FROM (proposals JOIN proposal_translations ON ((proposals.id = proposal_translations.proposal_id))) UNION SELECT experiencies.id AS searchable_id, 'Experiencie'::text AS searchable_type, experiencie_translations.title, ''::text AS section_title, experiencie_translations.summary AS text, experiencie_translations.locale FROM (experiencies JOIN experiencie_translations ON ((experiencies.id = experiencie_translations.experiencie_id)))) UNION SELECT categories.id AS searchable_id, 'Category'::text AS searchable_type, category_translations.title, ''::text AS section_title, category_translations.summary AS text, category_translations.locale FROM (categories JOIN category_translations ON ((categories.id = category_translations.category_id)))) UNION SELECT groups.id AS searchable_id, 'Group'::text AS searchable_type, group_translations.title, ''::text AS section_title, group_translations.summary AS text, group_translations.locale FROM (groups JOIN group_translations ON ((groups.id = group_translations.group_id)))) UNION SELECT sections.document_id AS searchable_id, sections.document_type AS searchable_type, ''::character varying AS title, sections.title AS section_title, sections.body AS text, sections.locale FROM sections WHERE ((sections.type)::text = 'TextSection'::text);


--
-- Name: sections_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sections_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sections_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sections_id_seq OWNED BY sections.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(50),
    summary character varying(500),
    slug character varying(50),
    admin boolean,
    email character varying(255),
    avatar_image character varying(255),
    password_digest character varying(255),
    reset_password_token character varying(255),
    login_count integer,
    last_login_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reset_password_sent_at timestamp without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY activities ALTER COLUMN id SET DEFAULT nextval('activities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY category_translations ALTER COLUMN id SET DEFAULT nextval('category_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY editorships ALTER COLUMN id SET DEFAULT nextval('editorships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY experiencie_translations ALTER COLUMN id SET DEFAULT nextval('experiencie_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY experiencies ALTER COLUMN id SET DEFAULT nextval('experiencies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY friendly_id_slugs ALTER COLUMN id SET DEFAULT nextval('friendly_id_slugs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY group_translations ALTER COLUMN id SET DEFAULT nextval('group_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY groups ALTER COLUMN id SET DEFAULT nextval('groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY help_page_translations ALTER COLUMN id SET DEFAULT nextval('help_page_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY help_pages ALTER COLUMN id SET DEFAULT nextval('help_pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY help_text_translations ALTER COLUMN id SET DEFAULT nextval('help_text_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY help_texts ALTER COLUMN id SET DEFAULT nextval('help_texts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY images ALTER COLUMN id SET DEFAULT nextval('images_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY kudos ALTER COLUMN id SET DEFAULT nextval('kudos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY links ALTER COLUMN id SET DEFAULT nextval('links_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY locations ALTER COLUMN id SET DEFAULT nextval('locations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY memberships ALTER COLUMN id SET DEFAULT nextval('memberships_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phase_translations ALTER COLUMN id SET DEFAULT nextval('phase_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phases ALTER COLUMN id SET DEFAULT nextval('phases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY proposal_translations ALTER COLUMN id SET DEFAULT nextval('proposal_translations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY proposals ALTER COLUMN id SET DEFAULT nextval('proposals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY relations ALTER COLUMN id SET DEFAULT nextval('relations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sections ALTER COLUMN id SET DEFAULT nextval('sections_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: activities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY activities
    ADD CONSTRAINT activities_pkey PRIMARY KEY (id);


--
-- Name: agents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY groups
    ADD CONSTRAINT agents_pkey PRIMARY KEY (id);


--
-- Name: categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: category_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY category_translations
    ADD CONSTRAINT category_translations_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: editorships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY editorships
    ADD CONSTRAINT editorships_pkey PRIMARY KEY (id);


--
-- Name: experiencie_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY experiencie_translations
    ADD CONSTRAINT experiencie_translations_pkey PRIMARY KEY (id);


--
-- Name: experiencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY experiencies
    ADD CONSTRAINT experiencies_pkey PRIMARY KEY (id);


--
-- Name: friendly_id_slugs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY friendly_id_slugs
    ADD CONSTRAINT friendly_id_slugs_pkey PRIMARY KEY (id);


--
-- Name: group_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY group_translations
    ADD CONSTRAINT group_translations_pkey PRIMARY KEY (id);


--
-- Name: help_page_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY help_page_translations
    ADD CONSTRAINT help_page_translations_pkey PRIMARY KEY (id);


--
-- Name: help_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY help_pages
    ADD CONSTRAINT help_pages_pkey PRIMARY KEY (id);


--
-- Name: help_text_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY help_text_translations
    ADD CONSTRAINT help_text_translations_pkey PRIMARY KEY (id);


--
-- Name: help_texts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY help_texts
    ADD CONSTRAINT help_texts_pkey PRIMARY KEY (id);


--
-- Name: images_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY images
    ADD CONSTRAINT images_pkey PRIMARY KEY (id);


--
-- Name: kudos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY kudos
    ADD CONSTRAINT kudos_pkey PRIMARY KEY (id);


--
-- Name: links_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY links
    ADD CONSTRAINT links_pkey PRIMARY KEY (id);


--
-- Name: locations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY locations
    ADD CONSTRAINT locations_pkey PRIMARY KEY (id);


--
-- Name: memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY memberships
    ADD CONSTRAINT memberships_pkey PRIMARY KEY (id);


--
-- Name: phase_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY phase_translations
    ADD CONSTRAINT phase_translations_pkey PRIMARY KEY (id);


--
-- Name: phases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY phases
    ADD CONSTRAINT phases_pkey PRIMARY KEY (id);


--
-- Name: proposal_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY proposal_translations
    ADD CONSTRAINT proposal_translations_pkey PRIMARY KEY (id);


--
-- Name: proposals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY proposals
    ADD CONSTRAINT proposals_pkey PRIMARY KEY (id);


--
-- Name: relations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY relations
    ADD CONSTRAINT relations_pkey PRIMARY KEY (id);


--
-- Name: sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_activities_on_owner_id_and_owner_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_owner_id_and_owner_type ON activities USING btree (owner_id, owner_type);


--
-- Name: index_activities_on_recipient_id_and_recipient_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_recipient_id_and_recipient_type ON activities USING btree (recipient_id, recipient_type);


--
-- Name: index_activities_on_trackable_id_and_trackable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_activities_on_trackable_id_and_trackable_type ON activities USING btree (trackable_id, trackable_type);


--
-- Name: index_agents_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_agents_on_email ON groups USING btree (email);


--
-- Name: index_agents_on_slug; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_agents_on_slug ON groups USING btree (slug);


--
-- Name: index_categories_on_phase_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_on_phase_id ON categories USING btree (phase_id);


--
-- Name: index_categories_on_slug_ca; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_categories_on_slug_ca ON categories USING btree (slug_ca);


--
-- Name: index_categories_on_slug_en; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_on_slug_en ON categories USING btree (slug_en);


--
-- Name: index_categories_on_slug_es; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_categories_on_slug_es ON categories USING btree (slug_es);


--
-- Name: index_categories_on_slug_fr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_on_slug_fr ON categories USING btree (slug_fr);


--
-- Name: index_categories_on_slug_it; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_on_slug_it ON categories USING btree (slug_it);


--
-- Name: index_categories_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_categories_on_user_id ON categories USING btree (user_id);


--
-- Name: index_category_translations_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_category_translations_on_category_id ON category_translations USING btree (category_id);


--
-- Name: index_category_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_category_translations_on_locale ON category_translations USING btree (locale);


--
-- Name: index_comments_on_document_id_and_document_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_document_id_and_document_type ON comments USING btree (document_id, document_type);


--
-- Name: index_comments_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_user_id ON comments USING btree (user_id);


--
-- Name: index_editorships_on_document_type_and_document_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_editorships_on_document_type_and_document_id ON editorships USING btree (document_type, document_id);


--
-- Name: index_editorships_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_editorships_on_user_id ON editorships USING btree (user_id);


--
-- Name: index_experiencie_translations_on_experiencie_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencie_translations_on_experiencie_id ON experiencie_translations USING btree (experiencie_id);


--
-- Name: index_experiencie_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencie_translations_on_locale ON experiencie_translations USING btree (locale);


--
-- Name: index_experiencies_on_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencies_on_group_id ON experiencies USING btree (group_id);


--
-- Name: index_experiencies_on_slug_ca; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencies_on_slug_ca ON experiencies USING btree (slug_ca);


--
-- Name: index_experiencies_on_slug_en; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencies_on_slug_en ON experiencies USING btree (slug_en);


--
-- Name: index_experiencies_on_slug_es; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencies_on_slug_es ON experiencies USING btree (slug_es);


--
-- Name: index_experiencies_on_slug_fr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencies_on_slug_fr ON experiencies USING btree (slug_fr);


--
-- Name: index_experiencies_on_slug_it; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencies_on_slug_it ON experiencies USING btree (slug_it);


--
-- Name: index_experiencies_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_experiencies_on_user_id ON experiencies USING btree (user_id);


--
-- Name: index_friendly_id_slugs_on_slug_and_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_friendly_id_slugs_on_slug_and_sluggable_type ON friendly_id_slugs USING btree (slug, sluggable_type);


--
-- Name: index_friendly_id_slugs_on_sluggable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_id ON friendly_id_slugs USING btree (sluggable_id);


--
-- Name: index_friendly_id_slugs_on_sluggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_friendly_id_slugs_on_sluggable_type ON friendly_id_slugs USING btree (sluggable_type);


--
-- Name: index_group_translations_on_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_group_translations_on_group_id ON group_translations USING btree (group_id);


--
-- Name: index_group_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_group_translations_on_locale ON group_translations USING btree (locale);


--
-- Name: index_help_page_translations_on_help_page_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_page_translations_on_help_page_id ON help_page_translations USING btree (help_page_id);


--
-- Name: index_help_page_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_page_translations_on_locale ON help_page_translations USING btree (locale);


--
-- Name: index_help_pages_on_slug_ca; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_pages_on_slug_ca ON help_pages USING btree (slug_ca);


--
-- Name: index_help_pages_on_slug_en; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_pages_on_slug_en ON help_pages USING btree (slug_en);


--
-- Name: index_help_pages_on_slug_es; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_pages_on_slug_es ON help_pages USING btree (slug_es);


--
-- Name: index_help_pages_on_slug_fr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_pages_on_slug_fr ON help_pages USING btree (slug_fr);


--
-- Name: index_help_pages_on_slug_it; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_pages_on_slug_it ON help_pages USING btree (slug_it);


--
-- Name: index_help_text_translations_on_help_text_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_text_translations_on_help_text_id ON help_text_translations USING btree (help_text_id);


--
-- Name: index_help_text_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_text_translations_on_locale ON help_text_translations USING btree (locale);


--
-- Name: index_help_texts_on_identf; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_help_texts_on_identf ON help_texts USING btree (identf);


--
-- Name: index_images_on_imageable_type_and_imageable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_images_on_imageable_type_and_imageable_id ON images USING btree (imageable_type, imageable_id);


--
-- Name: index_images_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_images_on_user_id ON images USING btree (user_id);


--
-- Name: index_kudos_on_document_type_and_document_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_kudos_on_document_type_and_document_id ON kudos USING btree (document_type, document_id);


--
-- Name: index_kudos_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_kudos_on_user_id ON kudos USING btree (user_id);


--
-- Name: index_links_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_links_on_user_id ON links USING btree (user_id);


--
-- Name: index_memberships_on_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_memberships_on_group_id ON memberships USING btree (group_id);


--
-- Name: index_memberships_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_memberships_on_user_id ON memberships USING btree (user_id);


--
-- Name: index_phase_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phase_translations_on_locale ON phase_translations USING btree (locale);


--
-- Name: index_phase_translations_on_phase_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phase_translations_on_phase_id ON phase_translations USING btree (phase_id);


--
-- Name: index_phases_on_slug_ca; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phases_on_slug_ca ON phases USING btree (slug_ca);


--
-- Name: index_phases_on_slug_en; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phases_on_slug_en ON phases USING btree (slug_en);


--
-- Name: index_phases_on_slug_es; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phases_on_slug_es ON phases USING btree (slug_es);


--
-- Name: index_phases_on_slug_fr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phases_on_slug_fr ON phases USING btree (slug_fr);


--
-- Name: index_phases_on_slug_it; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phases_on_slug_it ON phases USING btree (slug_it);


--
-- Name: index_proposal_translations_on_locale; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposal_translations_on_locale ON proposal_translations USING btree (locale);


--
-- Name: index_proposal_translations_on_proposal_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposal_translations_on_proposal_id ON proposal_translations USING btree (proposal_id);


--
-- Name: index_proposals_on_category_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposals_on_category_id ON proposals USING btree (category_id);


--
-- Name: index_proposals_on_slug_ca; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposals_on_slug_ca ON proposals USING btree (slug_ca);


--
-- Name: index_proposals_on_slug_en; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposals_on_slug_en ON proposals USING btree (slug_en);


--
-- Name: index_proposals_on_slug_es; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposals_on_slug_es ON proposals USING btree (slug_es);


--
-- Name: index_proposals_on_slug_fr; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposals_on_slug_fr ON proposals USING btree (slug_fr);


--
-- Name: index_proposals_on_slug_it; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_proposals_on_slug_it ON proposals USING btree (slug_it);


--
-- Name: index_relations_on_experiencie_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_relations_on_experiencie_id ON relations USING btree (experiencie_id);


--
-- Name: index_relations_on_proposal_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_relations_on_proposal_id ON relations USING btree (proposal_id);


--
-- Name: index_relations_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_relations_on_user_id ON relations USING btree (user_id);


--
-- Name: index_sections_on_document_type_and_document_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sections_on_document_type_and_document_id ON sections USING btree (document_type, document_id);


--
-- Name: index_sections_on_document_type_and_document_id_and_lang; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sections_on_document_type_and_document_id_and_lang ON sections USING btree (document_type, document_id, locale);


--
-- Name: index_sections_on_position; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sections_on_position ON sections USING btree ("position");


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120418130219');

INSERT INTO schema_migrations (version) VALUES ('20120418130300');

INSERT INTO schema_migrations (version) VALUES ('20120430074728');

INSERT INTO schema_migrations (version) VALUES ('20120502160153');

INSERT INTO schema_migrations (version) VALUES ('20120502204334');

INSERT INTO schema_migrations (version) VALUES ('20120509113409');

INSERT INTO schema_migrations (version) VALUES ('20120515140755');

INSERT INTO schema_migrations (version) VALUES ('20120516082926');

INSERT INTO schema_migrations (version) VALUES ('20120516103212');

INSERT INTO schema_migrations (version) VALUES ('20120516193703');

INSERT INTO schema_migrations (version) VALUES ('20120516201314');

INSERT INTO schema_migrations (version) VALUES ('20120518085413');

INSERT INTO schema_migrations (version) VALUES ('20120518113459');

INSERT INTO schema_migrations (version) VALUES ('20120522135030');

INSERT INTO schema_migrations (version) VALUES ('20120523105600');

INSERT INTO schema_migrations (version) VALUES ('20120530155802');

INSERT INTO schema_migrations (version) VALUES ('20120604034320');

INSERT INTO schema_migrations (version) VALUES ('20120606154054');

INSERT INTO schema_migrations (version) VALUES ('20120613140232');

INSERT INTO schema_migrations (version) VALUES ('20120614231304');

INSERT INTO schema_migrations (version) VALUES ('20120618190901');

INSERT INTO schema_migrations (version) VALUES ('20120619080514');

INSERT INTO schema_migrations (version) VALUES ('20120620004806');

INSERT INTO schema_migrations (version) VALUES ('20120620144746');

INSERT INTO schema_migrations (version) VALUES ('20120621141346');

INSERT INTO schema_migrations (version) VALUES ('20120625135253');

INSERT INTO schema_migrations (version) VALUES ('20120625150111');

INSERT INTO schema_migrations (version) VALUES ('20120625201235');

INSERT INTO schema_migrations (version) VALUES ('20120626155650');

INSERT INTO schema_migrations (version) VALUES ('20120712161937');

INSERT INTO schema_migrations (version) VALUES ('20120712192005');

INSERT INTO schema_migrations (version) VALUES ('20120712202359');

INSERT INTO schema_migrations (version) VALUES ('20120714083147');

INSERT INTO schema_migrations (version) VALUES ('20120714213924');

INSERT INTO schema_migrations (version) VALUES ('20120715142613');

INSERT INTO schema_migrations (version) VALUES ('20120716002644');

INSERT INTO schema_migrations (version) VALUES ('20120716122546');

INSERT INTO schema_migrations (version) VALUES ('20120716133304');

INSERT INTO schema_migrations (version) VALUES ('20120716182931');

INSERT INTO schema_migrations (version) VALUES ('20120718113326');

INSERT INTO schema_migrations (version) VALUES ('20120718120219');

INSERT INTO schema_migrations (version) VALUES ('20120718162850');

INSERT INTO schema_migrations (version) VALUES ('20120719114358');

INSERT INTO schema_migrations (version) VALUES ('20120805112151');

INSERT INTO schema_migrations (version) VALUES ('20120805152834');

INSERT INTO schema_migrations (version) VALUES ('20120806032538');

INSERT INTO schema_migrations (version) VALUES ('20120822165947');

INSERT INTO schema_migrations (version) VALUES ('20120828091246');

INSERT INTO schema_migrations (version) VALUES ('20120914183025');

INSERT INTO schema_migrations (version) VALUES ('20121101104540');

INSERT INTO schema_migrations (version) VALUES ('20121103111732');

INSERT INTO schema_migrations (version) VALUES ('20130124204514');

INSERT INTO schema_migrations (version) VALUES ('20130124211424');

INSERT INTO schema_migrations (version) VALUES ('20130205192518');

INSERT INTO schema_migrations (version) VALUES ('20130205232539');

INSERT INTO schema_migrations (version) VALUES ('20130206010127');

INSERT INTO schema_migrations (version) VALUES ('20130207171139');

INSERT INTO schema_migrations (version) VALUES ('20130209164211');

INSERT INTO schema_migrations (version) VALUES ('20130212070404');

INSERT INTO schema_migrations (version) VALUES ('20130505192516');

INSERT INTO schema_migrations (version) VALUES ('20130505192517');

INSERT INTO schema_migrations (version) VALUES ('20130505202018');

INSERT INTO schema_migrations (version) VALUES ('20130506075656');

INSERT INTO schema_migrations (version) VALUES ('20130528180934');

INSERT INTO schema_migrations (version) VALUES ('20130603015108');

INSERT INTO schema_migrations (version) VALUES ('20130607150255');

INSERT INTO schema_migrations (version) VALUES ('20130618175256');

INSERT INTO schema_migrations (version) VALUES ('20130620182336');

INSERT INTO schema_migrations (version) VALUES ('20130620185313');

INSERT INTO schema_migrations (version) VALUES ('20130626133436');

INSERT INTO schema_migrations (version) VALUES ('20130702134020');

INSERT INTO schema_migrations (version) VALUES ('20130702172529');

INSERT INTO schema_migrations (version) VALUES ('20130702182629');

INSERT INTO schema_migrations (version) VALUES ('20130702183356');

INSERT INTO schema_migrations (version) VALUES ('20130807195410');

INSERT INTO schema_migrations (version) VALUES ('20130830173444');

INSERT INTO schema_migrations (version) VALUES ('20130905175525');

INSERT INTO schema_migrations (version) VALUES ('20130911223224');

INSERT INTO schema_migrations (version) VALUES ('20130920161153');

INSERT INTO schema_migrations (version) VALUES ('20130920163600');

INSERT INTO schema_migrations (version) VALUES ('20131021035033');

INSERT INTO schema_migrations (version) VALUES ('20131021045915');

INSERT INTO schema_migrations (version) VALUES ('20131030150023');

INSERT INTO schema_migrations (version) VALUES ('20131030175857');

INSERT INTO schema_migrations (version) VALUES ('20131105134959');