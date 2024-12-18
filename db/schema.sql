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
-- Name: event; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA event;


--
-- Name: infrastruktur; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA infrastruktur;


--
-- Name: interaction; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA interaction;


--
-- Name: log; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA log;


--
-- Name: master; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA master;


--
-- Name: responden; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA responden;


--
-- Name: tracking; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA tracking;


--
-- Name: umkm; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA umkm;


--
-- Name: user; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "user";


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: jenis_event_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.jenis_event_enum AS ENUM (
    'Terbatas',
    'Umum',
    'Internal'
);


--
-- Name: status_complainment_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.status_complainment_enum AS ENUM (
    'PENDING',
    'ANSWERED',
    'DONE'
);


--
-- Name: status_persetujuan_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.status_persetujuan_enum AS ENUM (
    'BOOKING',
    'APPROVED',
    'APPROVED_CHECKIN',
    'APPROVED_CHECKOUT',
    'REJECTED',
    'LATE'
);


--
-- Name: status_persetujuan_ruangan_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.status_persetujuan_ruangan_enum AS ENUM (
    'PENDING',
    'APPROVED',
    'REJECTED'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: absensi_event; Type: TABLE; Schema: event; Owner: -
--

CREATE TABLE event.absensi_event (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    account_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: booking; Type: TABLE; Schema: event; Owner: -
--

CREATE TABLE event.booking (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    account_instansi_personal_id uuid,
    nama_event character varying(255) NOT NULL,
    kode_booking character varying(255) NOT NULL,
    kategori_event_id uuid NOT NULL,
    ekraf_id uuid NOT NULL,
    deskripsi character varying(255) NOT NULL,
    no_telp_pic character varying(255) NOT NULL,
    detail_peralatan character varying(255),
    estimasi_peserta integer NOT NULL,
    nama_pic character varying(255) NOT NULL,
    jenis_event public.jenis_event_enum NOT NULL,
    ttd character varying(255) NOT NULL,
    proposal_event character varying(255),
    banner_event character varying(255),
    status_persetujuan public.status_persetujuan_enum DEFAULT 'BOOKING'::public.status_persetujuan_enum NOT NULL,
    harga_tiket numeric(10,2),
    no_rek character varying(255),
    pendapatan_total numeric(10,2),
    url_payment_gateway character varying(255),
    qr_code_absensi text,
    qr_code_checkin text,
    original_url_absensi text,
    short_url_absensi character varying(255),
    foto_ruangan_checkout character varying(255),
    alasan_reject text,
    no_konfirmasi_admin_reject character varying(255),
    deskripsi_kebutuhan_fo text,
    is_sudah_mengisi_feedback boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: kategori_event; Type: TABLE; Schema: event; Owner: -
--

CREATE TABLE event.kategori_event (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_kategori character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: member_event_comersil; Type: TABLE; Schema: event; Owner: -
--

CREATE TABLE event.member_event_comersil (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    kode_transaksi character varying(255) NOT NULL,
    nama_member character varying(255) NOT NULL,
    jumlah_pembayaran numeric(10,2) NOT NULL,
    payment_method character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ruang_event; Type: TABLE; Schema: event; Owner: -
--

CREATE TABLE event.ruang_event (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    booking_id uuid NOT NULL,
    prasarana_mcc_id uuid NOT NULL,
    waktu_booking_id uuid NOT NULL,
    tanggal_penggunaan date NOT NULL,
    status_persetujuan_ruangan public.status_persetujuan_ruangan_enum DEFAULT 'PENDING'::public.status_persetujuan_ruangan_enum NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: infrastruktur_mcc; Type: TABLE; Schema: infrastruktur; Owner: -
--

CREATE TABLE infrastruktur.infrastruktur_mcc (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_infrastruktur character varying(255) NOT NULL,
    deskripsi_infrastruktur character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: prasarana_mcc; Type: TABLE; Schema: infrastruktur; Owner: -
--

CREATE TABLE infrastruktur.prasarana_mcc (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    infrastruktur_mcc_id uuid NOT NULL,
    nama_prasarana character varying(255) NOT NULL,
    deskripsi_prasarana character varying(255) NOT NULL,
    gambar_prasarana character varying(255) NOT NULL,
    kapasitas_prasarana character varying(255) NOT NULL,
    biaya_sewa character varying(255) DEFAULT 'Gratis'::character varying NOT NULL,
    pic character varying(255),
    ukuran_prasarana character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: sarana_mcc; Type: TABLE; Schema: infrastruktur; Owner: -
--

CREATE TABLE infrastruktur.sarana_mcc (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    prasarana_mcc_id uuid NOT NULL,
    nama_sarana character varying(255) NOT NULL,
    jumlah_sarana character varying(255)
);


--
-- Name: follow; Type: TABLE; Schema: interaction; Owner: -
--

CREATE TABLE interaction.follow (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    follower_id uuid NOT NULL,
    following_id uuid NOT NULL,
    status_follow boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: log; Type: TABLE; Schema: log; Owner: -
--

CREATE TABLE log.log (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    admin_log_id uuid NOT NULL,
    booking_id uuid NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: ekraf; Type: TABLE; Schema: master; Owner: -
--

CREATE TABLE master.ekraf (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: kategori; Type: TABLE; Schema: master; Owner: -
--

CREATE TABLE master.kategori (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: mcc_posisi; Type: TABLE; Schema: master; Owner: -
--

CREATE TABLE master.mcc_posisi (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    latitude numeric(10,7) NOT NULL,
    longitude numeric(10,7) NOT NULL,
    radius integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: waktu_booking; Type: TABLE; Schema: master; Owner: -
--

CREATE TABLE master.waktu_booking (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    waktu_mulai character varying(255) NOT NULL,
    waktu_selesai character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(128) NOT NULL
);


--
-- Name: complaintment; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.complaintment (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid,
    admin_id uuid,
    pesan_feedback_admin text,
    status_complainment public.status_complainment_enum DEFAULT 'PENDING'::public.status_complainment_enum NOT NULL,
    nama_lengkap character varying(255) NOT NULL,
    no_telp character varying(255) NOT NULL,
    is_pernah_pinjam_mcc boolean NOT NULL,
    nama_instansi character varying(255) NOT NULL,
    keluhan text NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: feedback_data_diri; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.feedback_data_diri (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid,
    nama_depan character varying(255) NOT NULL,
    nama_belakang character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    no_telp character varying(255) NOT NULL,
    usia integer NOT NULL,
    frekuensi_kunjungan integer NOT NULL,
    jenis_kelamin character varying(255) NOT NULL,
    riwayat_pendidikan character varying(255) NOT NULL,
    pekerjaan character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: feedback_lainnya; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.feedback_lainnya (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    feedback_data_diri_id uuid NOT NULL,
    account_id uuid,
    nama_institusi character varying(255) NOT NULL,
    no_telp_pic character varying(255) NOT NULL,
    jumlah_transaksi_event character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: feedback_usul; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.feedback_usul (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    feedback_data_diri_id uuid NOT NULL,
    account_id uuid,
    kolaborasi_perlibatan character varying(255) NOT NULL,
    penjelasan_kegiatan character varying(255) NOT NULL,
    keluhan character varying(255) NOT NULL,
    saran character varying(255) NOT NULL,
    usul text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: responded; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.responded (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    tipe_responden character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: responden_ruangan; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.responden_ruangan (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid,
    feedback_lainnya_id uuid NOT NULL,
    booking_id uuid,
    prasarana_mcc_id uuid,
    jumlah_peserta integer NOT NULL,
    jumlah_pengunjung integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: sub_responden; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.sub_responden (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    responden_id uuid NOT NULL,
    pertanyaan character varying(255) NOT NULL,
    nilai_awal character varying(255) DEFAULT '1'::character varying,
    nilai_akhir character varying(255) DEFAULT '4'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: user_responded; Type: TABLE; Schema: responden; Owner: -
--

CREATE TABLE responden.user_responded (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    feeback_data_diri_id uuid NOT NULL,
    sub_responden_id uuid NOT NULL,
    account_id uuid,
    nilai_responded integer NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: tracking; Type: TABLE; Schema: tracking; Owner: -
--

CREATE TABLE tracking.tracking (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    date timestamp without time zone NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: produk; Type: TABLE; Schema: umkm; Owner: -
--

CREATE TABLE umkm.produk (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_produk character varying(50) NOT NULL,
    harga integer NOT NULL,
    deskripsi text NOT NULL,
    foto_produk character varying(255) NOT NULL,
    umkm_id uuid NOT NULL,
    link_produk_marketplace text,
    approved boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: umkm; Type: TABLE; Schema: umkm; Owner: -
--

CREATE TABLE umkm.umkm (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_umkm character varying(50) NOT NULL,
    link_marketplace text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: account; Type: TABLE; Schema: user; Owner: -
--

CREATE TABLE "user".account (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    urole_id uuid NOT NULL,
    pwd text NOT NULL,
    email character varying(255) NOT NULL,
    no_telp character varying(255) NOT NULL,
    foto character varying(255),
    nama character varying(255) NOT NULL,
    alamat character varying(255) NOT NULL,
    jenis_kelamin_personal character varying(255),
    is_ban boolean DEFAULT false NOT NULL,
    deskripsi character varying(255),
    facebook character varying(255),
    instagram character varying(255),
    twitter character varying(255),
    youtube character varying(255),
    tiktok character varying(255),
    is_umkm boolean DEFAULT false NOT NULL,
    is_verified_user boolean DEFAULT false NOT NULL,
    code_verifikasi_register character varying(255),
    code_verifikasi_forgot_password character varying(255),
    expired_code_register timestamp without time zone,
    expired_code_forgot_password timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: api_tokens; Type: TABLE; Schema: user; Owner: -
--

CREATE TABLE "user".api_tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    user_id uuid NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    expires_at timestamp without time zone
);


--
-- Name: instansi_user; Type: TABLE; Schema: user; Owner: -
--

CREATE TABLE "user".instansi_user (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    account_id uuid NOT NULL,
    logo_instansi character varying(255),
    nama_instansi character varying(255) NOT NULL,
    website_instansi character varying(255),
    kategori_id uuid NOT NULL,
    ekraf_id uuid NOT NULL,
    kota_instansi character varying(255) NOT NULL,
    kecamatan_instansi character varying(255) NOT NULL,
    alamat_instansi character varying(255) NOT NULL,
    deskripsi_instansi character varying(255),
    email_instansi character varying(255) NOT NULL,
    pic_instansi character varying(255) NOT NULL,
    facebook character varying(255),
    instagram character varying(255),
    twitter character varying(255),
    youtube character varying(255),
    tiktok character varying(255),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: role; Type: TABLE; Schema: user; Owner: -
--

CREATE TABLE "user".role (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    code character varying(255) NOT NULL,
    name character varying(50) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: absensi_event absensi_event_pkey; Type: CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.absensi_event
    ADD CONSTRAINT absensi_event_pkey PRIMARY KEY (id);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- Name: kategori_event kategori_event_pkey; Type: CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.kategori_event
    ADD CONSTRAINT kategori_event_pkey PRIMARY KEY (id);


--
-- Name: member_event_comersil member_event_comersil_pkey; Type: CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.member_event_comersil
    ADD CONSTRAINT member_event_comersil_pkey PRIMARY KEY (id);


--
-- Name: ruang_event ruang_event_pkey; Type: CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.ruang_event
    ADD CONSTRAINT ruang_event_pkey PRIMARY KEY (id);


--
-- Name: infrastruktur_mcc infrastruktur_mcc_pkey; Type: CONSTRAINT; Schema: infrastruktur; Owner: -
--

ALTER TABLE ONLY infrastruktur.infrastruktur_mcc
    ADD CONSTRAINT infrastruktur_mcc_pkey PRIMARY KEY (id);


--
-- Name: prasarana_mcc prasarana_mcc_pkey; Type: CONSTRAINT; Schema: infrastruktur; Owner: -
--

ALTER TABLE ONLY infrastruktur.prasarana_mcc
    ADD CONSTRAINT prasarana_mcc_pkey PRIMARY KEY (id);


--
-- Name: sarana_mcc sarana_mcc_pkey; Type: CONSTRAINT; Schema: infrastruktur; Owner: -
--

ALTER TABLE ONLY infrastruktur.sarana_mcc
    ADD CONSTRAINT sarana_mcc_pkey PRIMARY KEY (id);


--
-- Name: follow follow_pkey; Type: CONSTRAINT; Schema: interaction; Owner: -
--

ALTER TABLE ONLY interaction.follow
    ADD CONSTRAINT follow_pkey PRIMARY KEY (id);


--
-- Name: log log_pkey; Type: CONSTRAINT; Schema: log; Owner: -
--

ALTER TABLE ONLY log.log
    ADD CONSTRAINT log_pkey PRIMARY KEY (id);


--
-- Name: ekraf ekraf_pkey; Type: CONSTRAINT; Schema: master; Owner: -
--

ALTER TABLE ONLY master.ekraf
    ADD CONSTRAINT ekraf_pkey PRIMARY KEY (id);


--
-- Name: kategori kategori_pkey; Type: CONSTRAINT; Schema: master; Owner: -
--

ALTER TABLE ONLY master.kategori
    ADD CONSTRAINT kategori_pkey PRIMARY KEY (id);


--
-- Name: mcc_posisi mcc_posisi_pkey; Type: CONSTRAINT; Schema: master; Owner: -
--

ALTER TABLE ONLY master.mcc_posisi
    ADD CONSTRAINT mcc_posisi_pkey PRIMARY KEY (id);


--
-- Name: waktu_booking waktu_booking_pkey; Type: CONSTRAINT; Schema: master; Owner: -
--

ALTER TABLE ONLY master.waktu_booking
    ADD CONSTRAINT waktu_booking_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: complaintment complaintment_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.complaintment
    ADD CONSTRAINT complaintment_pkey PRIMARY KEY (id);


--
-- Name: feedback_data_diri feedback_data_diri_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_data_diri
    ADD CONSTRAINT feedback_data_diri_pkey PRIMARY KEY (id);


--
-- Name: feedback_lainnya feedback_lainnya_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_lainnya
    ADD CONSTRAINT feedback_lainnya_pkey PRIMARY KEY (id);


--
-- Name: feedback_usul feedback_usul_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_usul
    ADD CONSTRAINT feedback_usul_pkey PRIMARY KEY (id);


--
-- Name: responded responded_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.responded
    ADD CONSTRAINT responded_pkey PRIMARY KEY (id);


--
-- Name: responden_ruangan responden_ruangan_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.responden_ruangan
    ADD CONSTRAINT responden_ruangan_pkey PRIMARY KEY (id);


--
-- Name: sub_responden sub_responden_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.sub_responden
    ADD CONSTRAINT sub_responden_pkey PRIMARY KEY (id);


--
-- Name: user_responded user_responded_pkey; Type: CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.user_responded
    ADD CONSTRAINT user_responded_pkey PRIMARY KEY (id);


--
-- Name: tracking tracking_pkey; Type: CONSTRAINT; Schema: tracking; Owner: -
--

ALTER TABLE ONLY tracking.tracking
    ADD CONSTRAINT tracking_pkey PRIMARY KEY (id);


--
-- Name: produk produk_pkey; Type: CONSTRAINT; Schema: umkm; Owner: -
--

ALTER TABLE ONLY umkm.produk
    ADD CONSTRAINT produk_pkey PRIMARY KEY (id);


--
-- Name: umkm umkm_pkey; Type: CONSTRAINT; Schema: umkm; Owner: -
--

ALTER TABLE ONLY umkm.umkm
    ADD CONSTRAINT umkm_pkey PRIMARY KEY (id);


--
-- Name: account account_email_key; Type: CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".account
    ADD CONSTRAINT account_email_key UNIQUE (email);


--
-- Name: account account_no_telp_key; Type: CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".account
    ADD CONSTRAINT account_no_telp_key UNIQUE (no_telp);


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- Name: api_tokens api_tokens_pkey; Type: CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".api_tokens
    ADD CONSTRAINT api_tokens_pkey PRIMARY KEY (id);


--
-- Name: instansi_user instansi_user_pkey; Type: CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".instansi_user
    ADD CONSTRAINT instansi_user_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: pkey_absensi_event; Type: INDEX; Schema: event; Owner: -
--

CREATE INDEX pkey_absensi_event ON event.absensi_event USING btree (id);


--
-- Name: pkey_booking; Type: INDEX; Schema: event; Owner: -
--

CREATE INDEX pkey_booking ON event.booking USING btree (id);


--
-- Name: pkey_kategori_event; Type: INDEX; Schema: event; Owner: -
--

CREATE INDEX pkey_kategori_event ON event.kategori_event USING btree (id);


--
-- Name: pkey_member_event_comersil; Type: INDEX; Schema: event; Owner: -
--

CREATE INDEX pkey_member_event_comersil ON event.member_event_comersil USING btree (id);


--
-- Name: pkey_ruang_event; Type: INDEX; Schema: event; Owner: -
--

CREATE INDEX pkey_ruang_event ON event.ruang_event USING btree (id);


--
-- Name: pkey_infrastruktur_mcc; Type: INDEX; Schema: infrastruktur; Owner: -
--

CREATE INDEX pkey_infrastruktur_mcc ON infrastruktur.infrastruktur_mcc USING btree (id);


--
-- Name: pkey_prasarana_mcc; Type: INDEX; Schema: infrastruktur; Owner: -
--

CREATE INDEX pkey_prasarana_mcc ON infrastruktur.prasarana_mcc USING btree (id);


--
-- Name: pkey_sarana_mcc; Type: INDEX; Schema: infrastruktur; Owner: -
--

CREATE INDEX pkey_sarana_mcc ON infrastruktur.sarana_mcc USING btree (id);


--
-- Name: pkey_ekraf; Type: INDEX; Schema: master; Owner: -
--

CREATE INDEX pkey_ekraf ON master.ekraf USING btree (id);


--
-- Name: pkey_kategori; Type: INDEX; Schema: master; Owner: -
--

CREATE INDEX pkey_kategori ON master.kategori USING btree (id);


--
-- Name: pkey_mcc_posisi; Type: INDEX; Schema: master; Owner: -
--

CREATE INDEX pkey_mcc_posisi ON master.mcc_posisi USING btree (id);


--
-- Name: pkey_waktu_booking; Type: INDEX; Schema: master; Owner: -
--

CREATE INDEX pkey_waktu_booking ON master.waktu_booking USING btree (id);


--
-- Name: pkey_complaintment; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_complaintment ON responden.complaintment USING btree (id);


--
-- Name: pkey_feedback_data_diri; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_feedback_data_diri ON responden.feedback_data_diri USING btree (id);


--
-- Name: pkey_feedback_lainnya; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_feedback_lainnya ON responden.feedback_lainnya USING btree (id);


--
-- Name: pkey_feedback_usul; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_feedback_usul ON responden.feedback_usul USING btree (id);


--
-- Name: pkey_responded; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_responded ON responden.responded USING btree (id);


--
-- Name: pkey_responden_ruangan; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_responden_ruangan ON responden.responden_ruangan USING btree (id);


--
-- Name: pkey_sub_responden; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_sub_responden ON responden.sub_responden USING btree (id);


--
-- Name: pkey_user_responded; Type: INDEX; Schema: responden; Owner: -
--

CREATE INDEX pkey_user_responded ON responden.user_responded USING btree (id);


--
-- Name: pkey_tracking; Type: INDEX; Schema: tracking; Owner: -
--

CREATE INDEX pkey_tracking ON tracking.tracking USING btree (id);


--
-- Name: pkey_produk; Type: INDEX; Schema: umkm; Owner: -
--

CREATE INDEX pkey_produk ON umkm.produk USING btree (id);


--
-- Name: pkey_umkm; Type: INDEX; Schema: umkm; Owner: -
--

CREATE INDEX pkey_umkm ON umkm.umkm USING btree (id);


--
-- Name: fkey_uaccount_urole; Type: INDEX; Schema: user; Owner: -
--

CREATE INDEX fkey_uaccount_urole ON "user".account USING btree (urole_id);


--
-- Name: fkey_uapi_tokens_uaccount; Type: INDEX; Schema: user; Owner: -
--

CREATE INDEX fkey_uapi_tokens_uaccount ON "user".api_tokens USING btree (user_id);


--
-- Name: fkey_uinstansi_user_uaccount; Type: INDEX; Schema: user; Owner: -
--

CREATE INDEX fkey_uinstansi_user_uaccount ON "user".instansi_user USING btree (account_id);


--
-- Name: pkey_uaccount; Type: INDEX; Schema: user; Owner: -
--

CREATE INDEX pkey_uaccount ON "user".account USING btree (id);


--
-- Name: pkey_uapi_tokens; Type: INDEX; Schema: user; Owner: -
--

CREATE INDEX pkey_uapi_tokens ON "user".api_tokens USING btree (id);


--
-- Name: pkey_uinstansi_user; Type: INDEX; Schema: user; Owner: -
--

CREATE INDEX pkey_uinstansi_user ON "user".instansi_user USING btree (id);


--
-- Name: pkey_urole; Type: INDEX; Schema: user; Owner: -
--

CREATE INDEX pkey_urole ON "user".role USING btree (id);


--
-- Name: absensi_event absensi_event_account_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.absensi_event
    ADD CONSTRAINT absensi_event_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: absensi_event absensi_event_booking_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.absensi_event
    ADD CONSTRAINT absensi_event_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES event.booking(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking booking_account_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.booking
    ADD CONSTRAINT booking_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking booking_account_instansi_personal_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.booking
    ADD CONSTRAINT booking_account_instansi_personal_id_fkey FOREIGN KEY (account_instansi_personal_id) REFERENCES "user".instansi_user(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking booking_ekraf_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.booking
    ADD CONSTRAINT booking_ekraf_id_fkey FOREIGN KEY (ekraf_id) REFERENCES master.ekraf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: booking booking_kategori_event_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.booking
    ADD CONSTRAINT booking_kategori_event_id_fkey FOREIGN KEY (kategori_event_id) REFERENCES event.kategori_event(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: member_event_comersil member_event_comersil_booking_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.member_event_comersil
    ADD CONSTRAINT member_event_comersil_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES event.booking(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ruang_event ruang_event_booking_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.ruang_event
    ADD CONSTRAINT ruang_event_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES event.booking(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ruang_event ruang_event_prasarana_mcc_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.ruang_event
    ADD CONSTRAINT ruang_event_prasarana_mcc_id_fkey FOREIGN KEY (prasarana_mcc_id) REFERENCES infrastruktur.prasarana_mcc(id);


--
-- Name: ruang_event ruang_event_waktu_booking_id_fkey; Type: FK CONSTRAINT; Schema: event; Owner: -
--

ALTER TABLE ONLY event.ruang_event
    ADD CONSTRAINT ruang_event_waktu_booking_id_fkey FOREIGN KEY (waktu_booking_id) REFERENCES master.waktu_booking(id);


--
-- Name: prasarana_mcc prasarana_mcc_infrastruktur_mcc_id_fkey; Type: FK CONSTRAINT; Schema: infrastruktur; Owner: -
--

ALTER TABLE ONLY infrastruktur.prasarana_mcc
    ADD CONSTRAINT prasarana_mcc_infrastruktur_mcc_id_fkey FOREIGN KEY (infrastruktur_mcc_id) REFERENCES infrastruktur.infrastruktur_mcc(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sarana_mcc sarana_mcc_prasarana_mcc_id_fkey; Type: FK CONSTRAINT; Schema: infrastruktur; Owner: -
--

ALTER TABLE ONLY infrastruktur.sarana_mcc
    ADD CONSTRAINT sarana_mcc_prasarana_mcc_id_fkey FOREIGN KEY (prasarana_mcc_id) REFERENCES infrastruktur.prasarana_mcc(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: follow follow_follower_id_fkey; Type: FK CONSTRAINT; Schema: interaction; Owner: -
--

ALTER TABLE ONLY interaction.follow
    ADD CONSTRAINT follow_follower_id_fkey FOREIGN KEY (follower_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: follow follow_following_id_fkey; Type: FK CONSTRAINT; Schema: interaction; Owner: -
--

ALTER TABLE ONLY interaction.follow
    ADD CONSTRAINT follow_following_id_fkey FOREIGN KEY (following_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log log_admin_log_id_fkey; Type: FK CONSTRAINT; Schema: log; Owner: -
--

ALTER TABLE ONLY log.log
    ADD CONSTRAINT log_admin_log_id_fkey FOREIGN KEY (admin_log_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: log log_booking_id_fkey; Type: FK CONSTRAINT; Schema: log; Owner: -
--

ALTER TABLE ONLY log.log
    ADD CONSTRAINT log_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES event.booking(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: complaintment complaintment_account_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.complaintment
    ADD CONSTRAINT complaintment_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: complaintment complaintment_admin_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.complaintment
    ADD CONSTRAINT complaintment_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedback_data_diri feedback_data_diri_account_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_data_diri
    ADD CONSTRAINT feedback_data_diri_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedback_lainnya feedback_lainnya_account_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_lainnya
    ADD CONSTRAINT feedback_lainnya_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedback_lainnya feedback_lainnya_feedback_data_diri_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_lainnya
    ADD CONSTRAINT feedback_lainnya_feedback_data_diri_id_fkey FOREIGN KEY (feedback_data_diri_id) REFERENCES responden.feedback_data_diri(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedback_usul feedback_usul_account_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_usul
    ADD CONSTRAINT feedback_usul_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: feedback_usul feedback_usul_feedback_data_diri_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.feedback_usul
    ADD CONSTRAINT feedback_usul_feedback_data_diri_id_fkey FOREIGN KEY (feedback_data_diri_id) REFERENCES responden.feedback_data_diri(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: responden_ruangan responden_ruangan_account_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.responden_ruangan
    ADD CONSTRAINT responden_ruangan_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: responden_ruangan responden_ruangan_booking_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.responden_ruangan
    ADD CONSTRAINT responden_ruangan_booking_id_fkey FOREIGN KEY (booking_id) REFERENCES event.booking(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: responden_ruangan responden_ruangan_feedback_lainnya_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.responden_ruangan
    ADD CONSTRAINT responden_ruangan_feedback_lainnya_id_fkey FOREIGN KEY (feedback_lainnya_id) REFERENCES responden.feedback_lainnya(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: responden_ruangan responden_ruangan_prasarana_mcc_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.responden_ruangan
    ADD CONSTRAINT responden_ruangan_prasarana_mcc_id_fkey FOREIGN KEY (prasarana_mcc_id) REFERENCES infrastruktur.prasarana_mcc(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sub_responden sub_responden_responden_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.sub_responden
    ADD CONSTRAINT sub_responden_responden_id_fkey FOREIGN KEY (responden_id) REFERENCES responden.responded(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_responded user_responded_account_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.user_responded
    ADD CONSTRAINT user_responded_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_responded user_responded_feeback_data_diri_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.user_responded
    ADD CONSTRAINT user_responded_feeback_data_diri_id_fkey FOREIGN KEY (feeback_data_diri_id) REFERENCES responden.feedback_data_diri(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_responded user_responded_sub_responden_id_fkey; Type: FK CONSTRAINT; Schema: responden; Owner: -
--

ALTER TABLE ONLY responden.user_responded
    ADD CONSTRAINT user_responded_sub_responden_id_fkey FOREIGN KEY (sub_responden_id) REFERENCES responden.sub_responden(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tracking tracking_account_id_fkey; Type: FK CONSTRAINT; Schema: tracking; Owner: -
--

ALTER TABLE ONLY tracking.tracking
    ADD CONSTRAINT tracking_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: produk produk_umkm_id_fkey; Type: FK CONSTRAINT; Schema: umkm; Owner: -
--

ALTER TABLE ONLY umkm.produk
    ADD CONSTRAINT produk_umkm_id_fkey FOREIGN KEY (umkm_id) REFERENCES umkm.umkm(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: account account_urole_id_fkey; Type: FK CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".account
    ADD CONSTRAINT account_urole_id_fkey FOREIGN KEY (urole_id) REFERENCES "user".role(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: api_tokens api_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".api_tokens
    ADD CONSTRAINT api_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: instansi_user instansi_user_account_id_fkey; Type: FK CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".instansi_user
    ADD CONSTRAINT instansi_user_account_id_fkey FOREIGN KEY (account_id) REFERENCES "user".account(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: instansi_user instansi_user_ekraf_id_fkey; Type: FK CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".instansi_user
    ADD CONSTRAINT instansi_user_ekraf_id_fkey FOREIGN KEY (ekraf_id) REFERENCES master.ekraf(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: instansi_user instansi_user_kategori_id_fkey; Type: FK CONSTRAINT; Schema: user; Owner: -
--

ALTER TABLE ONLY "user".instansi_user
    ADD CONSTRAINT instansi_user_kategori_id_fkey FOREIGN KEY (kategori_id) REFERENCES master.kategori(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20240926022753'),
    ('20240926030804'),
    ('20240926034155'),
    ('20240926041443'),
    ('20240926050516'),
    ('20240926051302'),
    ('20240926051303'),
    ('20240927121511'),
    ('20241023062357');
