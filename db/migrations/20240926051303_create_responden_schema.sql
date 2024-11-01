-- migrate:up
CREATE SCHEMA IF NOT EXISTS "responden";

-- feedback pendapat modul (temporary hanya 1 kali saat booking aja tampilnya)
DROP TABLE IF EXISTS "responden"."responded" CASCADE;
CREATE TABLE "responden"."responded"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "tipe_responden" varchar(255) NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_responded" ON "responden"."responded" ("id");


INSERT INTO "responden"."responded" ("id", "tipe_responden") VALUES 
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Persyaratan Pelayanan'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Sistem, Mekanisme, dan Prosedur'),
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Waktu Pelayanan'),
('79fd7bfa-5baa-46ef-8c45-e9d6a1eeddaa', 'Produk / Spesifikasi Jenis Pelayanan'),
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Kompetensi Pelaksana (ditanyakan jika pelayanan berlangsung tatap muka, bukan online)'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Penanganan Pengaduan, Saran dan Masukan');


DROP TABLE IF EXISTS "responden"."sub_responden" CASCADE;
CREATE TABLE "responden"."sub_responden"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "responden_id" uuid NOT NULL,
  "pertanyaan" varchar(255) NOT NULL,
  "nilai_awal" varchar(255) DEFAULT '1',
  "nilai_akhir" varchar(255) DEFAULT '4',
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("responden_id") REFERENCES "responden"."responded"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_sub_responden" ON "responden"."sub_responden" ("id");

INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Keberadaan informasi mengenai persyaratan pelayanan di MCC'),
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Kemudahan mendapatkan informasi mengenai persyaratan pelayanan di MCC'),
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Kejelasan informasi mengenai persyaratan pelayanan di MCC'),
('0652c4d3-f2c4-4ce7-aed9-c407c206d43c', 'Kemudahan memenuhi persyaratan pelayanan di MCC');

INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Keberadaan informasi mengenai sistem, mekanisme dan prosedur pelayanan di MCC'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Kemudahan mendapatkan informasi mengenai sistem, mekanisme dan prosedur pelayanan di MCC'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Kejelasan informasi mengenai sistem, mekanisme dan prosedur pelayanan di MCC'),
('4163704d-196f-4c68-8680-d7e0a7a960dd', 'Kemudahan menjalankan sistem, mekanisme dan prosedur pelayanan di MCC');

INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Ketepatan waktu berlangsungnya pelayanan di MCC'),
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Kejelasan informasi mengenai waktu penyelesaian layanan di MCC'),
('744ac728-7f3d-41aa-b445-745cfa5edc15', 'Ketepatan waktu penyelesaian layanan sesuai dengan yang dijanjikan');

INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('79fd7bfa-5baa-46ef-8c45-e9d6a1eeddaa', 'Ketepatan hasil pelayanan di MCC sesuai dengan ketentuan yang berlaku'),
('79fd7bfa-5baa-46ef-8c45-e9d6a1eeddaa', 'Kualitas hasil layanan di MCC yang baik (tidak ada kesalahan, misalnya : ruangan yang disediakan sesuai, kelengkapan fasilitas, dll)');

INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Kompetensi petugas dalam melaksanakan tugasnya'),
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Pengetahuan dan pemahaman petugas terhadap tugas dan tanggung jawabnya'),
('b23cfc85-c86d-4128-ad4d-73767dbce77f', 'Kemampuan petugas dalam memberikan solusi atas kesulitan masyarakat/ pengunjung');

INSERT INTO "responden"."sub_responden" ("responden_id", "pertanyaan") VALUES
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kelayakan dan kenyamanan ruang pelayanan di MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kelengkapan sarana prasarana penunjang pelayanan di MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Pemanfaatan sistem IT untuk proses pelayanan di MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kemudahan mengakses website MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kemudahan memasukkan data pada sistem pelayanan di website MCC'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Responsivitas petugas saat melakukan pelayanan secara online'),
('fc04aa15-ca92-4f5d-b72d-e0f31319ce0e', 'Kelengkapan informasi yang disediakan pada website MCC');

DROP TABLE IF EXISTS "responden"."user_responded" CASCADE;
CREATE TABLE "responden"."user_responded"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "sub_responden_id" uuid NOT NULL,
  "account_id" uuid NOT NULL,
  "nilai_responded" INTEGER NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("sub_responden_id") REFERENCES "responden"."sub_responden"("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_user_responded" ON "responden"."user_responded" ("id");

-- feedback data diri (temporary hanya 1 kali saat booking aja tampilnya)
CREATE TABLE "responden"."feedback_data_diri"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "account_id" uuid NOT NULL,
  "nama_depan" varchar(255) NOT NULL,
  "nama_belakang" varchar(255) NOT NULL,
  "email" varchar(255) NOT NULL,
  "no_telp" varchar(255) NOT NULL,
  "usia" integer NOT NULL,
  "frekuensi_kunjungan" integer NOT NULL,
  "jenis_kelamin" varchar(255) NOT NULL,
  "riwayat_pendidikan" varchar(255) NOT NULL,
  "pekerjaan" varchar(255) NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_feedback_data_diri" ON "responden"."feedback_data_diri" ("id");

-- feedback usul (temporary hanya 1 kali saat booking aja tampilnya)
CREATE TABLE "responden"."feedback_usul"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "account_id" uuid NOT NULL,
  "kolaborasi_perlibatan" varchar(255) NOT NULL,
  "penjelasan_kegiatan" varchar(255) NOT NULL,
  "keluhan" varchar(255) NOT NULL,
  "saran" varchar(255) NOT NULL,
  "usul" TEXT NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_feedback_usul" ON "responden"."feedback_usul" ("id");

-- feedback lainnya (not temporary)
CREATE TABLE "responden"."feedback_lainnya"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "account_id" uuid NOT NULL,
  "nama_institusi" varchar(255) NOT NULL,
  "no_telp_pic" varchar(255) NOT NULL,
  "jumlah_transaksi_event" DECIMAL(10,2) NULL,
  "jawaban" TEXT NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_feedback_lainnya" ON "responden"."feedback_lainnya" ("id");

CREATE TABLE "responden"."responden_ruangan" (
  "id" uuid DEFAULT uuid_generate_v4(),
  "account_id" uuid NOT NULL,
  "feedback_lainnya_id" uuid NOT NULL,
  "booking_id" uuid NULL,
  "prasarana_mcc_id" uuid NULL,
  "jumlah_peserta" integer NOT NULL,
  "jumlah_pengunjung" integer NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("feedback_lainnya_id") REFERENCES "responden"."feedback_lainnya"("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("prasarana_mcc_id") REFERENCES "infrastruktur"."prasarana_mcc"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_responden_ruangan" ON "responden"."responden_ruangan" ("id");

-- complaintment modul schema 
CREATE TYPE status_complainment_enum AS ENUM ('PENDING', 'ANSWERED','DONE');
CREATE TABLE "responden"."complaintment"(
  "id"            uuid          DEFAULT uuid_generate_v4(),
  "account_id" uuid NOT NULL,
  "admin_id" uuid NULL, -- yang menjawab feedback admin ?
  "pesan_feedback_admin" TEXT NULL, -- feedback nya admin ke user
  "status_complainment" status_complainment_enum NOT NULL DEFAULT 'PENDING', -- feedback status dari admin
  "nama_lengkap" varchar(255) NOT NULL,
  "no_telp" varchar(255) NOT NULL,
  "is_pernah_pinjam_mcc" BOOLEAN NOT NULL,
  "nama_instansi" varchar(255) NOT NULL,
  "keluhan" TEXT NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("admin_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_complaintment" ON "responden"."complaintment" ("id");

-- migrate:down
DROP TABLE IF EXISTS "responden"."sub_responden" CASCADE;
DROP TABLE IF EXISTS "responden"."responded" CASCADE;
DROP TABLE IF EXISTS "responden"."user_responded" CASCADE;
DROP TABLE IF EXISTS "responden"."feedback_data_diri" CASCADE;
DROP TABLE IF EXISTS "responden"."feedback_usul" CASCADE;
DROP TABLE IF EXISTS "responden"."feedback_lainnya" CASCADE;
DROP TABLE IF EXISTS "responden"."responden_ruangan" CASCADE;
