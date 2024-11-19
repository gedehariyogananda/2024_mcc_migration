-- migrate:up
CREATE SCHEMA IF NOT EXISTS "event";

-- event modul schema
DROP TABLE IF EXISTS "event"."kategori_event" CASCADE;

CREATE TABLE "event"."kategori_event"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama_kategori" VARCHAR(255) NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_kategori_event" ON "event"."kategori_event" ("id");

-- Insert dummy data with valid v4 UUIDs
INSERT INTO "event"."kategori_event" ("id", "nama_kategori") VALUES 
('496a64ff-6c07-419a-8bb0-e4305cf65111', 'DINAS'),
('73374b6c-3493-4bfc-b182-eb496d2b82fa', 'KAMPUS'),
('9b5f74cf-7220-4c98-8d41-7c3e260094a1', 'KOMERSIL'),
('d2564c17-4df3-4f95-a6e4-204fa3e4e531', 'KOMUNITAS'),
('a0becb9e-1444-4ceb-8043-57c848754c8e', 'LAINNYA');


CREATE TYPE jenis_event_enum AS ENUM ('Terbatas', 'Umum', 'Internal');
CREATE TYPE status_persetujuan_enum AS ENUM ('BOOKING', 'APPROVED','CHECKIN','APPROVED_CHECKIN','APPROVED_CHECKOUT','REJECTED', 'TEMPORARY_CHECKOUT', 'LATE_APPROVAL');
CREATE TYPE tipe_event_enum AS ENUM ('KOMERSIL', 'NON_KOMERSIL');

DROP TABLE IF EXISTS "event"."booking" CASCADE;
CREATE TABLE "event"."booking"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "account_id" uuid NOT NULL,
  "account_instansi_personal_id" uuid NULL,
  "nama_event" VARCHAR(255) NOT NULL,
  "kode_booking" VARCHAR(255) NOT NULL, -- code format MCC-2409-SAEX (2409 -> tahun dan bulan booking) (SAEX -> 4 random string)
  "kategori_event_id" uuid NOT NULL,
  "ekraf_id" uuid NOT NULL,
  "deskripsi" VARCHAR(255) NOT NULL,
  "no_telp_pic" VARCHAR(255) NOT NULL,
  "detail_peralatan" VARCHAR(255) NULL,
  "estimasi_peserta" INTEGER NOT NULL,
  "nama_pic" VARCHAR(255) NOT NULL,
  "jenis_event" jenis_event_enum NOT NULL,
  "ttd" TEXT NULL, -- will be images url 
  "proposal_event" VARCHAR(255) NULL,
  "banner_event" VARCHAR(255) NULL,
  "status_persetujuan" status_persetujuan_enum NOT NULL DEFAULT 'BOOKING',
  "tipe_event" tipe_event_enum NOT NULL DEFAULT 'NON_KOMERSIL',
  "qr_code_absensi" TEXT NULL,
  "qr_code_checkin" TEXT NULL,
  "alasan_reject" TEXT NULL, -- untuk marketing lk nolak
  "no_konfirmasi_admin_reject" VARCHAR(255) NULL,
  "nama_pic_admin_reject" VARCHAR(255) NULL,
  "deskripsi_kebutuhan_fo" TEXT NULL,
  "is_sudah_mengisi_feedback" BOOLEAN DEFAULT FALSE NOT NULL, 
  "is_attemp_admin" BOOLEAN DEFAULT FALSE NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "confirmed_at" TIMESTAMP NULL,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("account_instansi_personal_id") REFERENCES "user"."instansi_user"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("kategori_event_id") REFERENCES "event"."kategori_event"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("ekraf_id") REFERENCES "master"."ekraf"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_booking" ON "event"."booking" ("id");

-- DUMY REJECT EVENT
INSERT INTO "event"."booking" ("id", "account_id", "nama_event", "kode_booking", "kategori_event_id", "ekraf_id", "deskripsi", "no_telp_pic", "estimasi_peserta", "nama_pic", "jenis_event", "status_persetujuan", "tipe_event", "is_attemp_admin", "is_sudah_mengisi_feedback", "alasan_reject", "no_konfirmasi_admin_reject", "account_instansi_personal_id") VALUES 
('07333dfa-a822-4b56-aad2-11f2ce937a68', 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'Event 6', 'MCC-2409-SFEX', '73374b6c-3493-4bfc-b182-eb496d2b82fa', 'a663b4ae-3729-4a53-964f-5a25bc1e2d8f', 'CEK_DATA_BANYAK_AKTIF_REJECT', '1234567805', 350, 'PIC 6', 'Internal', 'REJECTED', 'NON_KOMERSIL', FALSE, FALSE, 'ruangan haram','083131313131','02b572dc-8475-4621-88bb-ca4978208bd9');

-- Dummy data for event.booking
INSERT INTO "event"."booking" ("id", "account_id", "nama_event", "kode_booking", "kategori_event_id", "ekraf_id", "deskripsi", "no_telp_pic", "estimasi_peserta", "nama_pic", "jenis_event", "status_persetujuan", "tipe_event", "is_attemp_admin", "is_sudah_mengisi_feedback", "confirmed_at") VALUES 
-- User 1

-- dumy history data ruangan PENUH
('0bde1ad7-75c4-4343-869a-e512074bc825', 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'Event 2', 'MCC-2409-SAUY', '9b5f74cf-7220-4c98-8d41-7c3e260094a1', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'EVENT_TANGGAL_30_NOV_2024 PENUH', '1234567805', 100, 'PIC 1', 'Terbatas', 'APPROVED', 'KOMERSIL', FALSE, FALSE, '2024-11-19 12:12:23'), 

-- dumy is attemp admin
('0c724434-ae80-4512-81be-55a3ca158956', 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'Event 1', 'MCC-2409-SAYU', '9b5f74cf-7220-4c98-8d41-7c3e260094a1', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'EVENT_ATTEMP_ADMIN', '1234567805', 100, 'PIC 2', 'Terbatas', 'APPROVED', 'KOMERSIL', TRUE, FALSE, '2024-11-19 12:12:23'), 

-- dumy untuk fetch data di aktif page lebih dari 4
('0cc13f7f-4b71-4313-ac75-ccbf1f8f3b86', 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'Event 3', 'MCC-2409-SCEZ', '496a64ff-6c07-419a-8bb0-e4305cf65111', '1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'CEK_DATA_BANYAK_AKTIF', '1234567805', 200, 'PIC 3', 'Internal', 'APPROVED', 'NON_KOMERSIL', FALSE, FALSE, '2024-11-19 12:12:23'),
('0cead83e-d83e-4d20-b118-3e4d10c1ea6f', 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'Event 4', 'MCC-2409-SDEB', '9b5f74cf-7220-4c98-8d41-7c3e260094a1', 'd2f709c7-627f-4f1b-8021-4f9e056ca774', 'CEK_DATA_BANYAK_AKTIF', '1234567805', 250, 'PIC 4', 'Terbatas', 'APPROVED', 'NON_KOMERSIL', FALSE, FALSE, '2024-11-19 12:12:23'),
('26443337-eab4-4a25-b4ac-23072886197e', 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'Event 5', 'MCC-2409-SEEX', '9b5f74cf-7220-4c98-8d41-7c3e260094a1', '110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'CEK_DATA_BANYAK_AKTIF', '1234567805', 300, 'PIC 5', 'Umum', 'APPROVED', 'NON_KOMERSIL', FALSE, FALSE, '2024-11-19 12:12:23'),


-- User 2
('9b5f74cf-7220-4c98-8d41-7c3e260094a1', 'f7f19610-1a8b-4202-b4fd-7c4266baf01a', 'Event dumy', 'MCC-2409-SCEX', '496a64ff-6c07-419a-8bb0-e4305cf65111', '1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'Deskripsi Event 3', '1234567806', 200, 'PIC 3', 'Internal', 'APPROVED_CHECKOUT', 'NON_KOMERSIL', FALSE, FALSE, '2024-11-19 12:12:23');


DROP TABLE IF EXISTS "event"."absensi_event" CASCADE;

CREATE TABLE "event"."absensi_event"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "booking_id" uuid NOT NULL,
  "account_id" uuid NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_absensi_event" ON "event"."absensi_event" ("id");


DROP TABLE IF EXISTS "event"."ruang_event" CASCADE;
CREATE TABLE "event"."ruang_event"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "booking_id" uuid NOT NULL,
  "prasarana_mcc_id" uuid NOT NULL,
  "waktu_booking_id" uuid NOT NULL,
  "tanggal_penggunaan" DATE NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("prasarana_mcc_id") REFERENCES "infrastruktur"."prasarana_mcc"("id") ,
  FOREIGN KEY ("waktu_booking_id") REFERENCES "master"."waktu_booking"("id") 
);

CREATE INDEX "pkey_ruang_event" ON "event"."ruang_event" ("id");

-- DUMY RUANG PENUH
INSERT INTO "event"."ruang_event" ("booking_id", "prasarana_mcc_id", "waktu_booking_id", "tanggal_penggunaan") 
VALUES 
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'da4733db-5e2b-4dc2-8e10-82ac2abdb21b', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'c3fd3197-b09f-4c4a-b1f0-f29a7bb23597', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'f7761cc3-b485-47a9-8268-7f97c10767c1', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', '9a80cb98-b121-46df-84d1-6cbfbd2753c8', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', '3dcfb947-30f0-4413-b39a-5065fa032aac', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', '4f1c64a4-bdcf-40e1-8209-905bdfd3455b', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'e47ba4d4-7877-464e-a7bb-7e15f2c73489', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'd94fb64d-0627-4aaf-93d6-0c5b2e4cc891', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', '03743b6f-f95f-4ffb-8097-dcb897145ccf', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'dd9a0e52-91f0-4ae5-8779-1ad4db26789c', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'd313af1b-4c57-44c2-94c0-16d5d9a7a87f', '2024-11-30'),
  ('0bde1ad7-75c4-4343-869a-e512074bc825', '2666d818-e2aa-4173-85d8-48a3a1e3df95', '7adfeabe-e449-43f1-84d9-d5bba61286e1', '2024-11-30'),

  ('0c724434-ae80-4512-81be-55a3ca158956', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-19'), -- IS ATTEMP TELAT

  ('0cc13f7f-4b71-4313-ac75-ccbf1f8f3b86','2666d818-e2aa-4173-85d8-48a3a1e3df95', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-26'), 
  ('0cead83e-d83e-4d20-b118-3e4d10c1ea6f','2666d818-e2aa-4173-85d8-48a3a1e3df95', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-27'), 
  ('26443337-eab4-4a25-b4ac-23072886197e','2666d818-e2aa-4173-85d8-48a3a1e3df95', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-28'), 
  ('07333dfa-a822-4b56-aad2-11f2ce937a68','2666d818-e2aa-4173-85d8-48a3a1e3df95', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-29'),

  -- CHECK FEEDBACK IS PERTAMA KALI
  ('9b5f74cf-7220-4c98-8d41-7c3e260094a1', '2666d818-e2aa-4173-85d8-48a3a1e3df95', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-18'),
  ('9b5f74cf-7220-4c98-8d41-7c3e260094a1', '29c4aaed-9654-4a6f-b11e-f20fcfaa3c31', 'b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '2024-11-18'),
  ('9b5f74cf-7220-4c98-8d41-7c3e260094a1', '29c4aaed-9654-4a6f-b11e-f20fcfaa3c31', 'da4733db-5e2b-4dc2-8e10-82ac2abdb21b', '2024-11-18');

-- migrate:down
DROP SCHEMA IF EXISTS "event" CASCADE;
DROP TABLE IF EXISTS "event"."kategori_event" CASCADE;
DROP TABLE IF EXISTS "event"."booking" CASCADE;
DROP TABLE IF EXISTS "event"."absensi_event" CASCADE;
DROP TABLE IF EXISTS "event"."member_event_comersil" CASCADE;
DROP TABLE IF EXISTS "event"."ruang_event" CASCADE;


