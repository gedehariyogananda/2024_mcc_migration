-- migrate:up
CREATE SCHEMA IF NOT EXISTS "responden";

-- create table responden.responded
DROP TABLE IF EXISTS "responden"."responded" CASCADE;
CREATE TABLE "responden"."responded"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "tipe_responden" varchar(255) NOT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_responded" ON "responden"."responded" ("id");



-- Assign static UUIDs for "responded" table
INSERT INTO "responden"."responded" ("id", "tipe_responden") VALUES 
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Persyaratan Pelayanan'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Sistem, Mekanisme, dan Prosedur'),
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Waktu Pelayanan'),
('79fd7bfa-5baa-46ef-8c45-e9d6a1eeddaa', 'Produk / Spesifikasi Jenis Pelayanan'),
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Kompetensi Pelaksana (ditanyakan jika pelayanan berlangsung tatap muka, bukan online)'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Penanganan Pengaduan, Saran dan Masukan');

-- create sub_responden table
DROP TABLE IF EXISTS "responden"."sub_responden" CASCADE;
CREATE TABLE "responden"."sub_responden"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "responden_id" uuid NOT NULL,
  "pertanyaan" varchar(255) NOT NULL,
  "nilai_awal" varchar(255) DEFAULT '1',
  "nilai_akhir" varchar(255) DEFAULT '4',
  PRIMARY KEY ("id"),
  FOREIGN KEY ("responden_id") REFERENCES "responden"."responded"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_sub_responden" ON "responden"."sub_responden" ("id");

-- Persyaratan Pelayanan (0652c4d3-f2c4-4ce7-aed9-c407c206d43c)
INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Keberadaan informasi mengenai persyaratan pelayanan di MCC'),
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Kemudahan mendapatkan informasi mengenai persyaratan pelayanan di MCC'),
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Kejelasan informasi mengenai persyaratan pelayanan di MCC'),
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Kemudahan memenuhi persyaratan pelayanan di MCC');

-- Sistem, Mekanisme, dan Prosedur (4163704d-196f-4c68-8680-d7e0a7a960dd)
INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Keberadaan informasi mengenai sistem, mekanisme dan prosedur pelayanan di MCC'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Kemudahan mendapatkan informasi mengenai sistem, mekanisme dan prosedur pelayanan di MCC'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Kejelasan informasi mengenai sistem, mekanisme dan prosedur pelayanan di MCC'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Kemudahan menjalankan sistem, mekanisme dan prosedur pelayanan di MCC');

-- Waktu Pelayanan (744ac728-7f3d-41aa-b445-745cfa5edc15)
INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Ketepatan waktu berlangsungnya pelayanan di MCC'),
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Kejelasan informasi mengenai waktu penyelesaian layanan di MCC'),
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Ketepatan waktu penyelesaian layanan sesuai dengan yang dijanjikan');

-- Produk / Spesifikasi Jenis Pelayanan (79fd7bfa-5baa-46ef-8c45-e9d6a1eeddaa)
INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('79fd7bfa-5baa-46ef-8c45-e9d6a1eeddaa', 'Ketepatan hasil pelayanan di MCC sesuai dengan ketentuan yang berlaku'),
('79fd7bfa-5baa-46ef-8c45-e9d6a1eeddaa', 'Kualitas hasil layanan di MCC yang baik (tidak ada kesalahan, misalnya : ruangan yang disediakan sesuai, kelengkapan fasilitas, dll)');

-- Kompetensi Pelaksana (b23cfc85-c86d-4128-ad4d-73767dbce77f)
INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Kompetensi petugas dalam melaksanakan tugasnya'),
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Pengetahuan dan pemahaman petugas terhadap tugas dan tanggung jawabnya'),
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Kemampuan petugas dalam memberikan solusi atas kesulitan masyarakat/ pengunjung');

-- Penanganan Pengaduan, Saran dan Masukan (fc04aa15-ca92-4f5d-b72d-e0f31319ce0e)
INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kelayakan dan kenyamanan ruang pelayanan di MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kelengkapan sarana prasarana penunjang pelayanan di MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Pemanfaatan sistem IT untuk proses pelayanan di MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kemudahan mengakses website MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kemudahan memasukkan data pada sistem pelayanan di website MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Responsivitas petugas saat melakukan pelayanan secara online'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kelengkapan informasi yang disediakan pada website MCC');


-- create table user responded
DROP TABLE IF EXISTS "responden"."user_responded" CASCADE;
CREATE TABLE "responden"."user_responded"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "responded_id" uuid NOT NULL,
  "user_id" uuid NOT NULL,
  "nilai_responded" INTEGER NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("responded_id") REFERENCES "responden"."responded"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_user_responded" ON "responden"."user_responded" ("id");

-- migrate:down
DROP TABLE IF EXISTS "responden"."sub_responden" CASCADE;
DROP TABLE IF EXISTS "responden"."responded" CASCADE;
DROP TABLE IF EXISTS "responden"."user_responded" CASCADE;
