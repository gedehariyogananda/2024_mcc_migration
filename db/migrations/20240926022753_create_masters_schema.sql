-- migrate:up
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
SET TIME ZONE 'Asia/Jakarta';

CREATE SCHEMA IF NOT EXISTS "master";

-- all master schema constant modul
DROP TABLE IF EXISTS "master"."kategori" CASCADE;
CREATE TABLE "master"."kategori"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama"          VARCHAR(50) 	NOT NULL ,
  "created_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_kategori" ON "master"."kategori" ("id");

INSERT INTO "master"."kategori" ("id", "nama")
VALUES 
('0de9879d-e999-4959-8d7a-5b8e9ab0f29d', 'Market'),
('19a7d0a9-2c28-49b7-a13f-c4929b769c26', 'Lembaga Pendidikan'),
('3f2a1295-7b3e-4f69-86bb-5a76fb3051cf', 'Lembaga Pemerintah'),
('4a8ed3b6-b43e-4af7-b556-7b4c9b0e602a', 'Usaha / Bisnis'),
('550e8400-e29b-41d4-a716-446655440000', 'Pelaku Ekraf'),
('7e43ae9c-989f-4569-8fc3-94abfc9efb55', 'Agregator'),
('a74a2511-467b-4a78-8395-408b8b0d7619', 'Komunitas & Kolaborasi'),
('bcb66048-0be3-464d-9249-7b31a0ed98fa', 'Lembaga Keuangan'),
('f94d5f72-6111-4b47-927a-df68e32956d2', 'Media Partner');

DROP TABLE IF EXISTS "master"."ekraf" CASCADE;
CREATE TABLE "master"."ekraf"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama"          VARCHAR(50) 	NOT NULL ,
  "created_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_ekraf" ON "master"."ekraf" ("id");

INSERT INTO "master"."ekraf" ("id", "nama")
VALUES 
('3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Arsitektur'),
('34f6811d-76e5-4e0a-8239-79c4e0444acb', 'Film'),
('1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'Fotografi'),
('d2f709c7-627f-4f1b-8021-4f9e056ca774', 'Kriya'),
('110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'Kuliner'),
('a663b4ae-3729-4a53-964f-5a25bc1e2d8f', 'Seni Rupa'),
('9f62f5d8-bbe1-4f6a-8c1b-df78d7a157f4', 'Produk'),
('dabd6ec8-4fd9-4a3a-a0b3-908ec0adad12', 'Aplikasi'),
('3216a1f1-4b9f-4655-a28a-dbb570cc5f0b', 'Game'),
('630d1fa6-8369-46be-b4ac-d431cb503c54', 'Televisi & Radio'),
('5b25e7bc-353b-4d5d-9e57-6bc123bc9f80', 'Fashion'),
('c58600a3-c515-4dc5-98ee-33bb3012150f', 'Pertunjukan'),
('df6790f2-c5b0-42f0-b1e2-90512e1f1bc6', 'Desain Interior'),
('58f2a37a-0c6d-4eb0-a1b2-9d15183241c9', 'Periklanan'),
('47a9bcf1-7c61-4635-822b-d658c0b69f0b', 'Penerbitan'),
('13698b29-4798-46d1-b9fa-417ee6766357', 'DKV'),
('52f26d5e-3834-4fc6-9556-8e1821c4bb47', 'Musik');

DROP TABLE IF EXISTS "master"."waktu_booking" CASCADE;
CREATE TABLE "master"."waktu_booking"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "waktu_mulai" VARCHAR(255) NOT NULL,
  "waktu_selesai" VARCHAR(255) NOT NULL,
  "created_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_waktu_booking" ON "master"."waktu_booking" ("id");

INSERT INTO "master"."waktu_booking" ("id", "waktu_mulai", "waktu_selesai")
VALUES
('b49542b0-fc2a-4a30-8e10-3b4dd8b2c3cf', '08:00', '09:00'),
('da4733db-5e2b-4dc2-8e10-82ac2abdb21b', '09:00', '10:00'),
('c3fd3197-b09f-4c4a-b1f0-f29a7bb23597', '10:00', '11:00'),
('f7761cc3-b485-47a9-8268-7f97c10767c1', '11:00', '12:00'),
('9a80cb98-b121-46df-84d1-6cbfbd2753c8', '12:00', '13:00'),
('3dcfb947-30f0-4413-b39a-5065fa032aac', '13:00', '14:00'),
('4f1c64a4-bdcf-40e1-8209-905bdfd3455b', '14:00', '15:00'),
('e47ba4d4-7877-464e-a7bb-7e15f2c73489', '15:00', '16:00'),
('d94fb64d-0627-4aaf-93d6-0c5b2e4cc891', '16:00', '17:00'),
('03743b6f-f95f-4ffb-8097-dcb897145ccf', '17:00', '18:00'),
('dd9a0e52-91f0-4ae5-8779-1ad4db26789c', '18:00', '19:00'),
('d313af1b-4c57-44c2-94c0-16d5d9a7a87f', '19:00', '20:00'),
('7adfeabe-e449-43f1-84d9-d5bba61286e1', '20:00', '21:00');


-- mcc_posisi for tracking user (hold version)
DROP TABLE IF EXISTS "master"."mcc_posisi" CASCADE;
CREATE TABLE "master"."mcc_posisi"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "latitude" DECIMAL(10, 7) NOT NULL,
  "longitude" DECIMAL(10, 7) NOT NULL, 
  "radius" INT NOT NULL,  
  "created_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_mcc_posisi" ON "master"."mcc_posisi" ("id");

INSERT INTO "master"."mcc_posisi" ("latitude","longitude","radius") VALUES (-7.9408266, 112.6424135, 500);

-- DUMY DATA 

-- INSERT INTO "master"."kategori" ("id", "nama") VALUES 
-- ('550e8400-e29b-41d4-a716-446655440000', 'Pelaku Ekraf'),
-- ('a74a2511-467b-4a78-8395-408b8b0d7619', 'Komunitas & Kolaborasi'),
-- ('4a8ed3b6-b43e-4af7-b556-7b4c9b0e602a', 'Usaha / Bisnis'),
-- ('19a7d0a9-2c28-49b7-a13f-c4929b769c26', 'Lembaga Pendidikan'),
-- ('f94d5f72-6111-4b47-927a-df68e32956d2', 'Media Partner'),
-- ('0de9879d-e999-4959-8d7a-5b8e9ab0f29d', 'Market'),
-- ('7e43ae9c-989f-4569-8fc3-94abfc9efb55', 'Agregator'),
-- ('3f2a1295-7b3e-4f69-86bb-5a76fb3051cf', 'Lembaga Pemerintah'),
-- ('bcb66048-0be3-464d-9249-7b31a0ed98fa', 'Lembaga Keuangan');

-- migrate:down
DROP SCHEMA IF EXISTS "master" CASCADE;
DROP TABLE IF EXISTS "master"."kategori" CASCADE;
DROP TABLE IF EXISTS "master"."ekraf" CASCADE;
DROP TABLE IF EXISTS "master"."mcc_posisi" CASCADE;
DROP TABLE IF EXISTS "master"."waktu_booking" CASCADE;

