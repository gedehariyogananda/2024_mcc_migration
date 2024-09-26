-- migrate:up
CREATE SCHEMA IF NOT EXISTS "umkm";

-- create umkm table
DROP TABLE IF EXISTS "umkm"."umkm" CASCADE;
CREATE TABLE "umkm"."umkm"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama_umkm"          VARCHAR(50) 	NOT NULL ,
  "link_marketplace" TEXT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_umkm" ON "umkm"."umkm" ("id");

-- create produk UMKM
DROP TABLE IF EXISTS "umkm"."produk" CASCADE;
CREATE TABLE "umkm"."produk"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama_produk"          VARCHAR(50) 	NOT NULL ,
  "harga"          INT 	NOT NULL ,
  "deskripsi"          TEXT 	NOT NULL ,
  "foto_produk"          VARCHAR(255) 	NOT NULL ,
  "umkm_id"          uuid 	NOT NULL ,
  "link_produk_marketplace" TEXT NULL ,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("umkm_id") REFERENCES "umkm"."umkm"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_produk" ON "umkm"."produk" ("id");

-- migrate:down
DROP SCHEMA IF EXISTS "umkm" CASCADE;
DROP TABLE IF EXISTS "umkm"."umkm" CASCADE;
DROP TABLE IF EXISTS "umkm"."produk" CASCADE;
