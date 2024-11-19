-- migrate:up
CREATE SCHEMA IF NOT EXISTS "infrastruktur";

-- infrastruktur modul schema (ruangan lantai dan sarana)
DROP TABLE IF EXISTS "infrastruktur"."infrastruktur_mcc" CASCADE;
CREATE TABLE "infrastruktur"."infrastruktur_mcc"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "nama_infrastruktur" VARCHAR(255) NOT NULL,
  "deskripsi_infrastruktur" VARCHAR(255) NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);

CREATE INDEX "pkey_infrastruktur_mcc" ON "infrastruktur"."infrastruktur_mcc" ("id");

INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('0795c197-fe7c-5fe3-b708-69fda3a060bf','Lantai 1','Creative Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('0ae46a5b-eb03-43c5-87c6-926925792372','Lantai 2','Create Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('1666d818-e2aa-4173-85d8-48a3a1e3df95','Lantai 3','Communication Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('19c4aaed-9654-4a6f-b11e-f20fcfaa3c31','Lantai 4','Collaboration Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('2c68deff-2707-4afb-adbe-91218b802583','Lantai 5','Commerce Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('2e07c6be-642d-45ad-b018-995e0614061f','Lantai 6','Champion Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('5b7b5eba-ad31-4e92-bde7-1d75bb96f981','Lantai 7','Consistent Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('0f293ddb-c359-5797-9117-07a72959f8b3','Lantai 8','Culture Floor');


DROP TABLE IF EXISTS "infrastruktur"."prasarana_mcc" CASCADE;
CREATE TABLE "infrastruktur"."prasarana_mcc"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "infrastruktur_mcc_id" uuid NOT NULL,
  "nama_prasarana" VARCHAR(255) NOT NULL,
  "deskripsi_prasarana" VARCHAR(255) NULL,
  "gambar_prasarana" VARCHAR(255) NOT NULL,
  "kapasitas_prasarana" VARCHAR(255) NOT NULL,
  "biaya_sewa" VARCHAR(255) NOT NULL DEFAULT 'Gratis',
  "pic" VARCHAR(255) NULL,
  "ukuran_prasarana" VARCHAR(255) NULL,
  "fasilitas" TEXT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("infrastruktur_mcc_id") REFERENCES "infrastruktur"."infrastruktur_mcc"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_prasarana_mcc" ON "infrastruktur"."prasarana_mcc" ("id");

INSERT INTO "infrastruktur"."prasarana_mcc" ("id", "infrastruktur_mcc_id", "nama_prasarana", "deskripsi_prasarana", "gambar_prasarana", "kapasitas_prasarana", "ukuran_prasarana", "fasilitas") VALUES 
('1795c197-fe7c-5fe3-b708-69fda3a060bf', '0795c197-fe7c-5fe3-b708-69fda3a060bf', 'Stage Outdoor', 'Stage Outdoor', 'ruangan\\meeting-room.png', '100', NULL, 'Hanya Area, Sound System 10, Mic 10'),
('0ae46a5b-eb03-43c5-87c6-926925792372', '0ae46a5b-eb03-43c5-87c6-926925792372', 'Teras Tengah', 'Teras Tengah', 'ruangan\\teras-tengah.png', '50-100', '3x6 m', 'Hanya Area, Sound System 10, Mic 10'),
('2666d818-e2aa-4173-85d8-48a3a1e3df95', '1666d818-e2aa-4173-85d8-48a3a1e3df95', 'Open Public Space Barat', 'Open Public Space Barat', 'ruangan\\open-public-space-barat.png', '200', '13,8 x 7,8', 'Hanya Area, Sound System 10, Mic 10'),
('29c4aaed-9654-4a6f-b11e-f20fcfaa3c31', '19c4aaed-9654-4a6f-b11e-f20fcfaa3c31', 'Lab Komputer', 'Lab Komputer', 'ruangan\\lab-komputer.png', '16', '23 x 10', 'Hanya Area, Sound System 10, Mic 10'),
('1c68deff-2707-4afb-adbe-91218b802583', '2c68deff-2707-4afb-adbe-91218b802583', 'Studio Foto', 'Studio Foto', 'ruangan\\studio-foto.png', '20', '12,2 x 7,4', 'Hanya Area, Sound System 10, Mic 10'),
('1e07c6be-642d-45ad-b018-995e0614061f', '2e07c6be-642d-45ad-b018-995e0614061f', 'Perpustakaan 1', 'Perpustakaan 1', 'ruangan\\perpustakaan-1.png', '16', '16 x 7,6', 'Hanya Area, Sound System 10, Mic 10'),
('4b7b5eba-ad31-4e92-bde7-1d75bb96f981', '5b7b5eba-ad31-4e92-bde7-1d75bb96f981', 'Free Function Lounge', 'Free Function Lounge', 'ruangan\\free-function-lounge.png', '100', NULL, 'Hanya Area, Sound System 10, Mic 10'),
('1f293ddb-c359-5797-9117-07a72959f8b3', '0f293ddb-c359-5797-9117-07a72959f8b3', 'Rooftop', 'Rooftop', 'ruangan\\rooftop.png', '100', NULL, 'Hanya Area, Sound System 10, Mic 10');

-- migrate:down
DROP SCHEMA IF EXISTS "infrastruktur" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."infrastruktur_mcc" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."prasarana_mcc" CASCADE;

