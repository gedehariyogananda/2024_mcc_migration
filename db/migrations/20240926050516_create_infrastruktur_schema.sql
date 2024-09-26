-- migrate:up
CREATE SCHEMA IF NOT EXISTS "infrastruktur";

-- create table infrastruktur
DROP TABLE IF EXISTS "infrastruktur"."infrastruktur_mcc" CASCADE;
CREATE TABLE "infrastruktur"."infrastruktur_mcc"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama_infrastruktur" VARCHAR(255) NOT NULL,
  "deskripsi_infrastruktur" VARCHAR(255) NOT NULL,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_infrastruktur_mcc" ON "infrastruktur"."infrastruktur_mcc" ("id");

-- create table prasarana
DROP TABLE IF EXISTS "infrastruktur"."prasarana_mcc" CASCADE;
CREATE TABLE "infrastruktur"."prasarana_mcc"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "infrastruktur_mcc_id" uuid NOT NULL,
  "nama_prasarana" VARCHAR(255) NOT NULL,
  "deskripsi_prasarana" VARCHAR(255) NOT NULL,
  "gambar_prasarana" VARCHAR(255) NOT NULL,
  "kapasitas_prasarana" VARCHAR(255) NOT NULL,
  "biaya_sewa" VARCHAR(255) NOT NULL,
  "ukuran_prasarana" VARCHAR(255) NOT NULL,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("infrastruktur_mcc_id") REFERENCES "infrastruktur"."infrastruktur_mcc"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_prasarana_mcc" ON "infrastruktur"."prasarana_mcc" ("id");

-- create table prasarana
DROP TABLE IF EXISTS "infrastruktur"."sarana_mcc" CASCADE;
CREATE TABLE "infrastruktur"."sarana_mcc"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "prasarana_mcc_id" uuid NOT NULL,
  "nama_sarana" VARCHAR(255) NOT NULL,
  "jumlah_sarana" VARCHAR(255) NULL,
  PRIMARY KEY ("id"),
    FOREIGN KEY ("prasarana_mcc_id") REFERENCES "infrastruktur"."prasarana_mcc"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_sarana_mcc" ON "infrastruktur"."sarana_mcc" ("id");

-- migrate:down
DROP SCHEMA IF EXISTS "infrastruktur" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."infrastruktur_mcc" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."prasarana_mcc" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."sarana_mcc" CASCADE;
