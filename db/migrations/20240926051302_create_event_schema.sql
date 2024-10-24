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

INSERT INTO "event"."kategori_event" ("nama_kategori") VALUES ('DINAS');
INSERT INTO "event"."kategori_event" ("nama_kategori") VALUES ('KAMPUS');
INSERT INTO "event"."kategori_event" ("nama_kategori") VALUES ('KOMERSIL');
INSERT INTO "event"."kategori_event" ("nama_kategori") VALUES ('KOMUNITAS');
INSERT INTO "event"."kategori_event" ("nama_kategori") VALUES ('LAINNYA');


DROP TABLE IF EXISTS "event"."booking" CASCADE;
CREATE TYPE jenis_event_enum AS ENUM ('Terbatas', 'Umum', 'Internal');
CREATE TYPE status_persetujuan_enum AS ENUM ('BOOKING', 'APPROVED','APPROVED_CHECKIN','APPROVED_CHECKOUT' ,'REJECTED');
CREATE TABLE "event"."booking"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "account_id" uuid NOT NULL,
  "nama_event" VARCHAR(255) NOT NULL,
  "kode_booking" VARCHAR(255) NOT NULL, -- code format MCC-2409-SAEX (2409 -> tahun dan bulan booking) (SAEX -> 4 random string)
  "kategori_event_id" uuid NOT NULL,
  "ekraf_id" uuid NOT NULL,
  "deskripsi" VARCHAR(255) NOT NULL,
  "detail_peralatan" VARCHAR(255) NULL,
  "estimasi_peserta" INTEGER NOT NULL,
  "nama_pic" VARCHAR(255) NOT NULL,
  "jenis_event" jenis_event_enum NOT NULL,
  "ttd" VARCHAR(255) NOT NULL, -- will be images url 
  "proposal_event" VARCHAR(255) NULL,
  "banner_event" VARCHAR(255) NULL,
  "status_persetujuan" status_persetujuan_enum NOT NULL DEFAULT 'BOOKING',

  -- COLUMN IF COMERSIL EVENT 
  "harga_tiket" DECIMAL(10,2) NULL,
  "no_rek" VARCHAR(255) NULL,
  "pendapatan_total" DECIMAL(10,2) NULL, -- count dari member_event_comersil 
  "url_payment_gateway" VARCHAR(255) NULL,

  -- AFTER CHECKIN AND CHECKOUT SETUP 
  "qr_code_absensi" TEXT NULL,
  "qr_code_checkin" TEXT NULL,
  "original_url_absensi" TEXT NULL,
  "short_url_absensi" VARCHAR(255) NULL,
  "foto_ruangan_checkout" VARCHAR(255) NULL,

  -- KEPERLUAN ADMINISTASI DAN MARKETING
  "alasan_reject" TEXT NULL,
  "deskripsi_kebutuhan_fo" TEXT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("kategori_event_id") REFERENCES "event"."kategori_event"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("ekraf_id") REFERENCES "master"."ekraf"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_booking" ON "event"."booking" ("id");


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

-- hold version
DROP TABLE IF EXISTS "event"."member_event_comersil" CASCADE;
CREATE TABLE "event"."member_event_comersil"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "booking_id" uuid NOT NULL,
  "kode_transaksi" VARCHAR(255) NOT NULL, -- format NAMAEVENT-202409-0001
  "nama_member" VARCHAR(255) NOT NULL,
  "jumlah_pembayaran" DECIMAL(10,2) NOT NULL,
  "payment_method" VARCHAR(255) NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_member_event_comersil" ON "event"."member_event_comersil" ("id");


DROP TABLE IF EXISTS "event"."ruang_event" CASCADE;
CREATE TYPE status_persetujuan_ruangan_enum AS ENUM ('PENDING', 'APPROVED','REJECTED');
CREATE TABLE "event"."ruang_event"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "booking_id" uuid NOT NULL,
  "prasarana_mcc_id" uuid NOT NULL,
  "waktu_booking_id" uuid NOT NULL,
  "tanggal_penggunaan" DATE NOT NULL,
  "status_persetujuan_ruangan" status_persetujuan_ruangan_enum NOT NULL DEFAULT 'PENDING',
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("prasarana_mcc_id") REFERENCES "infrastruktur"."prasarana_mcc"("id") ,
  FOREIGN KEY ("waktu_booking_id") REFERENCES "master"."waktu_booking"("id") 
);

CREATE INDEX "pkey_ruang_event" ON "event"."ruang_event" ("id");


-- migrate:down
DROP SCHEMA IF EXISTS "event" CASCADE;
DROP TABLE IF EXISTS "event"."kategori_event" CASCADE;
DROP TABLE IF EXISTS "event"."booking" CASCADE;
DROP TABLE IF EXISTS "event"."absensi_event" CASCADE;
DROP TABLE IF EXISTS "event"."member_event_comersil" CASCADE;
DROP TABLE IF EXISTS "event"."ruang_event" CASCADE;


