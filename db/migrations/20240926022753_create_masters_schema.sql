-- migrate:up
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

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

INSERT INTO "master"."kategori" ("nama") VALUES ('Pelaku Ekraf');
INSERT INTO "master"."kategori" ("nama") VALUES ('Komunitas & Kolaborasi');
INSERT INTO "master"."kategori" ("nama") VALUES ('Usaha / Bisnis');
INSERT INTO "master"."kategori" ("nama") VALUES ('Lembaga Pendidikan');
INSERT INTO "master"."kategori" ("nama") VALUES ('Media Partner');
INSERT INTO "master"."kategori" ("nama") VALUES ('Market');
INSERT INTO "master"."kategori" ("nama") VALUES ('Agregator');
INSERT INTO "master"."kategori" ("nama") VALUES ('Lembaga Pemerintah');
INSERT INTO "master"."kategori" ("nama") VALUES ('Lembaga Keuangan');

DROP TABLE IF EXISTS "master"."ekraf" CASCADE;
CREATE TABLE "master"."ekraf"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama"          VARCHAR(50) 	NOT NULL ,
  "created_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_ekraf" ON "master"."ekraf" ("id");


INSERT INTO "master"."ekraf" ("nama")
VALUES 
  ('Arsitektur'),
  ('Film'),
  ('Fotografi'),
  ('Kriya'),
  ('Kuliner'),
  ('Seni Rupa'),
  ('Produk'),
  ('Aplikasi'),
  ('Game'),
  ('Televisi & Radio'),
  ('Fashion'),
  ('Pertunjukan'),
  ('Desain Interior'),
  ('Periklanan'),
  ('Penerbitan'),
  ('DKV'),
  ('Musik');

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

INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('08:00','09:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('09:00','10:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('10:00','11:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('11:00','12:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('12:00','13:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('13:00','14:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('14:00','15:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('15:00','16:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('16:00','17:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('17:00','18:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('18:00','19:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('19:00','20:00');
INSERT INTO "master"."waktu_booking" ("waktu_mulai","waktu_selesai") VALUES ('20:00','21:00');


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

-- migrate:down
DROP SCHEMA IF EXISTS "master" CASCADE;
DROP TABLE IF EXISTS "master"."kategori" CASCADE;
DROP TABLE IF EXISTS "master"."ekraf" CASCADE;
DROP TABLE IF EXISTS "master"."mcc_posisi" CASCADE;
DROP TABLE IF EXISTS "master"."waktu_booking" CASCADE;


