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

INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('0795c197-fe7c-5fe3-b708-69fda3a060bf','Lantai 1','Creative Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('0ae46a5b-eb03-43c5-87c6-926925792372','Lantai 2','Create Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('1666d818-e2aa-4173-85d8-48a3a1e3df95','Lantai 3','Communication Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('19c4aaed-9654-4a6f-b11e-f20fcfaa3c31','Lantai 4','Collaboration Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('2c68deff-2707-4afb-adbe-91218b802583','Lantai 5','Commerce Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('2e07c6be-642d-45ad-b018-995e0614061f','Lantai 6','Champion Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('5b7b5eba-ad31-4e92-bde7-1d75bb96f981','Lantai 7','Consistent Floor');
INSERT INTO "infrastruktur"."infrastruktur_mcc" ("id","nama_infrastruktur","deskripsi_infrastruktur") VALUES ('0f293ddb-c359-5797-9117-07a72959f8b3','Lantai 8','Culture Floor');


-- create table prasarana
DROP TABLE IF EXISTS "infrastruktur"."prasarana_mcc" CASCADE;
CREATE TABLE "infrastruktur"."prasarana_mcc"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "infrastruktur_mcc_id" uuid NOT NULL,
  "nama_prasarana" VARCHAR(255) NOT NULL,
  "deskripsi_prasarana" VARCHAR(255) NOT NULL,
  "gambar_prasarana" VARCHAR(255) NOT NULL,
  "kapasitas_prasarana" VARCHAR(255) NOT NULL,
  "biaya_sewa" VARCHAR(255) NOT NULL DEFAULT 'Gratis',
  "pic" VARCHAR(255) NULL,
  "ukuran_prasarana" VARCHAR(255) NULL,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("infrastruktur_mcc_id") REFERENCES "infrastruktur"."infrastruktur_mcc"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_prasarana_mcc" ON "infrastruktur"."prasarana_mcc" ("id");

-- create prasarana dumy 
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana") VALUES ('1795c197-fe7c-5fe3-b708-69fda3a060bf','0795c197-fe7c-5fe3-b708-69fda3a060bf','Stage Outdoor','Stage Outdoor','ruangan\meeting-room.png','100');

-- lt 2
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana", "ukuran_prasarana") VALUES ('0ae46a5b-eb03-43c5-87c6-926925792372','0ae46a5b-eb03-43c5-87c6-926925792372','Teras Tengah','Teras Tengah','ruangan\teras-tengah.png','50-100', '3x6 m');

-- lt 3
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana", "ukuran_prasarana") VALUES ('2666d818-e2aa-4173-85d8-48a3a1e3df95','1666d818-e2aa-4173-85d8-48a3a1e3df95','Open Public Space Barat','Open Public Space Barat','ruangan\open-public-space-barat.png','200', '13,8 x 7,8');

-- lt 4 Lab Komputer, 23 x 10 , 16 kapasitas
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana", "ukuran_prasarana") VALUES ('29c4aaed-9654-4a6f-b11e-f20fcfaa3c31','19c4aaed-9654-4a6f-b11e-f20fcfaa3c31','Lab Komputer','Lab Komputer','ruangan\lab-komputer.png','16', '23 x 10');

-- lt 5 Studio Foto, 12,2 x 7,4, 20 
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana", "ukuran_prasarana") VALUES ('1c68deff-2707-4afb-adbe-91218b802583','2c68deff-2707-4afb-adbe-91218b802583','Studio Foto','Studio Foto','ruangan\studio-foto.png','20', '12,2 x 7,4');

-- lt 6 Perpustakaan 1, 16 x 7,6 , 16 
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana", "ukuran_prasarana") VALUES ('1e07c6be-642d-45ad-b018-995e0614061f','2e07c6be-642d-45ad-b018-995e0614061f','Perpustakaan 1','Perpustakaan 1','ruangan\perpustakaan-1.png','16', '16 x 7,6');

-- lt 7 Free Function Lounge, 100 
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana") VALUES ('4b7b5eba-ad31-4e92-bde7-1d75bb96f981','5b7b5eba-ad31-4e92-bde7-1d75bb96f981','Free Function Lounge','Free Function Lounge','ruangan\free-function-lounge.png','100');

-- lt 8 Rooftop, 100 
INSERT INTO "infrastruktur"."prasarana_mcc" ("id","infrastruktur_mcc_id","nama_prasarana","deskripsi_prasarana","gambar_prasarana","kapasitas_prasarana") VALUES ('1f293ddb-c359-5797-9117-07a72959f8b3','0f293ddb-c359-5797-9117-07a72959f8b3','Rooftop','Rooftop','ruangan\rooftop.png','100');


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

-- create sarana dumy 
-- prasarana id 1795c197-fe7c-5fe3-b708-69fda3a060bf, nama_saranan Hanya Area, jumlah null
INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('2795c197-fe7c-5fe3-b708-69fda3a060bf','1795c197-fe7c-5fe3-b708-69fda3a060bf','Hanya Area',null);

-- prasarana id 0ae46a5b-eb03-43c5-87c6-926925792372, nama_saranan Hanya Area, jumlah null
INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('5ae46a5b-eb03-43c5-87c6-926925792372','0ae46a5b-eb03-43c5-87c6-926925792372','Hanya Area',null);

-- prasarana id 2666d818-e2aa-4173-85d8-48a3a1e3df95, nama_saranan Akses Ramp Samping, jumlah null dan nama_sarana Hanya Area, jumlah null

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('5666d818-e2aa-4173-85d8-48a3a1e3df95','2666d818-e2aa-4173-85d8-48a3a1e3df95','Akses Ramp Samping',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('6666d818-e2aa-4173-85d8-48a3a1e3df95','2666d818-e2aa-4173-85d8-48a3a1e3df95','Hanya Area',null);

-- prasarana id 29c4aaed-9654-4a6f-b11e-f20fcfaa3c31, nama_saranan Akses Ramp Samping, jumlah null DAN Proyektor JUMLAH NULL, DAN PC Windows JUMLAH 16 
INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('59c4aaed-9654-4a6f-b11e-f20fcfaa3c31','29c4aaed-9654-4a6f-b11e-f20fcfaa3c31','Akses Ramp Samping',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('69c4aaed-9654-4a6f-b11e-f20fcfaa3c31','29c4aaed-9654-4a6f-b11e-f20fcfaa3c31','Proyektor',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('79c4aaed-9654-4a6f-b11e-f20fcfaa3c31','29c4aaed-9654-4a6f-b11e-f20fcfaa3c31','PC Windows','16');

-- prasarana id 1c68deff-2707-4afb-adbe-91218b802583, nama_saranan Akses Ramp Samping, jumlah null DAN Kursi Merah JUMLAH 25, DAN SOFA JUMLAH 2, DAN Sound System + Mic Wireless (Sound hanya Output Mic) JUMLAH NULL
INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('5c68deff-2707-4afb-adbe-91218b802583','1c68deff-2707-4afb-adbe-91218b802583','Akses Ramp Samping',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('6c68deff-2707-4afb-adbe-91218b802583','1c68deff-2707-4afb-adbe-91218b802583','Kursi Merah','25');

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('7c68deff-2707-4afb-adbe-91218b802583','1c68deff-2707-4afb-adbe-91218b802583','SOFA','2');

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('8c68deff-2707-4afb-adbe-91218b802583','1c68deff-2707-4afb-adbe-91218b802583','Sound System + Mic Wireless (Sound hanya Output Mic)',null);

-- prasarana id 1e07c6be-642d-45ad-b018-995e0614061f, nama_saranan Lavatory

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('5e07c6be-642d-45ad-b018-995e0614061f','1e07c6be-642d-45ad-b018-995e0614061f','Lavatory',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('6e07c6be-642d-45ad-b018-995e0614061f','1e07c6be-642d-45ad-b018-995e0614061f','Lift Passenger',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('7e07c6be-642d-45ad-b018-995e0614061f','1e07c6be-642d-45ad-b018-995e0614061f','Lift Service',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('8e07c6be-642d-45ad-b018-995e0614061f','1e07c6be-642d-45ad-b018-995e0614061f','Akses Ramp Samping',null);

-- prasarana id 4b7b5eba-ad31-4e92-bde7-1d75bb96f981
INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('5b7b5eba-ad31-4e92-bde7-1d75bb96f981','4b7b5eba-ad31-4e92-bde7-1d75bb96f981','Lavatory',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('6b7b5eba-ad31-4e92-bde7-1d75bb96f981','4b7b5eba-ad31-4e92-bde7-1d75bb96f981','Lift Passenger',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('7b7b5eba-ad31-4e92-bde7-1d75bb96f981','4b7b5eba-ad31-4e92-bde7-1d75bb96f981','Lift Service',null);

INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('8b7b5eba-ad31-4e92-bde7-1d75bb96f981','4b7b5eba-ad31-4e92-bde7-1d75bb96f981','Akses Ramp Samping',null);

-- prasarana id 1f293ddb-c359-5797-9117-07a72959f8b3 HANYA AREA
INSERT INTO "infrastruktur"."sarana_mcc" ("id","prasarana_mcc_id","nama_sarana","jumlah_sarana") VALUES ('5f293ddb-c359-5797-9117-07a72959f8b3','1f293ddb-c359-5797-9117-07a72959f8b3','Hanya Area',null);

-- migrate:down
DROP SCHEMA IF EXISTS "infrastruktur" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."infrastruktur_mcc" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."prasarana_mcc" CASCADE;
DROP TABLE IF EXISTS "infrastruktur"."sarana_mcc" CASCADE;
