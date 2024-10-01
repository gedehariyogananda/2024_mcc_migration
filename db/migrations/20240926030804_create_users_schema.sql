-- migrate:up
-- create user schema
CREATE SCHEMA IF NOT EXISTS "user";

-- create role table
DROP TABLE IF EXISTS "user"."role" CASCADE;
CREATE TABLE "user"."role"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "code" varchar(255) NOT NULL,
  "name"          VARCHAR(50) 	NOT NULL ,
  "created_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"    TIMESTAMP   	NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id")
);
CREATE INDEX "pkey_urole" ON "user"."role" ("id");

-- insert role data
INSERT INTO "user"."role"("id", "code","name") VALUES ('b7e3f4c2-7d7b-4d9d-9a3d-8e9c8c6b6e4d','AS_ADMIN_PENGELOLA' ,'Admin Pengelola');
INSERT INTO "user"."role"("id", "code","name") VALUES ('b7e3f4c2-7d7b-4d9d-9a3d-8e9c8c6b6e4c','A_ADMIN_FO' ,'Admin FO');
INSERT INTO "user"."role"("id", "code","name") VALUES ('b7e3f4c2-7d7b-4d9d-9a3d-8e9c8c6b6e4a','A_ADMIN' ,'Admin');
INSERT INTO "user"."role"("id", "code","name") VALUES ('b7e3f4c2-7d7b-4d9d-9a3d-8e9c8c6b6e4e','U_PERSONAL' ,'Personal');
INSERT INTO "user"."role"("id", "code","name") VALUES ('b7e3f4c2-7d7b-4d9d-9a3d-8e9c8c6b6e4f','U_INSTANSI' ,'Instansi');


-- create account table
DROP TABLE IF EXISTS "user"."account" CASCADE;
CREATE TABLE "user"."account"(
  "id"                uuid            DEFAULT uuid_generate_v4() ,
  "urole_id"          uuid     		    NOT NULL ,
  "pwd"               TEXT        		NOT NULL ,
  "email"             VARCHAR(255) 		NOT NULL UNIQUE ,
  "no_telp" VARCHAR(255) NOT NULL UNIQUE ,
  "foto"               VARCHAR(255) NOT NULL,
  "nama" VARCHAR(255) NOT NULL,
  "alamat" VARCHAR(255) NOT NULL,
  "website_instansi" VARCHAR(255) NULL,
  "jenis_kelamin_personal" VARCHAR(255) NULL,
  "kategori_id" uuid NOT NULL,
  "ekraf_id"   uuid NOT NULL,  
  "kota_instansi" VARCHAR(255) NULL,
  "kecamatan_instansi" VARCHAR(255) NULL,
  "deskripsi" VARCHAR(255) NULL,
  "facebook" VARCHAR(255) NULL,
  "instagram" VARCHAR(255) NULL,
  "twitter" VARCHAR(255) NULL,
  "youtube" VARCHAR(255) NULL,
  "tiktok" VARCHAR(255) NULL,
  "is_umkm" BOOLEAN DEFAULT FALSE NOT NULL,
  "is_verified_user" BOOLEAN DEFAULT FALSE NOT NULL,
  "code_verifikasi_register" VARCHAR(255) NULL,
  "code_verifikasi_forgot_password" VARCHAR(255) NULL,
  "expired_code_register" TIMESTAMP NULL,
  "expired_code_forgot_password" TIMESTAMP NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("urole_id") REFERENCES "user"."role"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("kategori_id") REFERENCES "master"."kategori"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("ekraf_id") REFERENCES "master"."ekraf"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_uaccount" ON "user"."account" ("id");
CREATE INDEX "fkey_uaccount_urole" ON "user"."account" ("urole_id");

-- create api_tokens table
DROP TABLE IF EXISTS "user"."api_tokens" CASCADE;
CREATE TABLE "user"."api_tokens"
(
  "id"         uuid          DEFAULT uuid_generate_v4() ,
  "user_id"    uuid          NOT NULL ,
  "name"       varchar(255)  NOT NULL ,
  "type"       varchar(255)  NOT NULL ,
  "token"      varchar(255)  NOT NULL ,
  "created_at" timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "expires_at" timestamp    ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("user_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE
);
CREATE INDEX "pkey_uapi_tokens" ON "user"."api_tokens" ("id");
CREATE INDEX "fkey_uapi_tokens_uaccount" ON "user"."api_tokens" ("user_id");

-- migrate:down
DROP SCHEMA IF EXISTS "user" CASCADE;
DROP TABLE IF EXISTS "user"."role" CASCADE;
DROP TABLE IF EXISTS "user"."account" CASCADE;
DROP TABLE IF EXISTS "user"."api_tokens" CASCADE;