-- migrate:up
CREATE SCHEMA IF NOT EXISTS "user";

-- schema user modul 
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


-- tier of user role 
-- AS -> Admin Super
-- A -> Admin Normal
-- U -> User 

INSERT INTO "user"."role"("id", "code","name") VALUES ('0795c197-fe7c-5fe3-b708-69fda3a060bf','AS_SUPER_ADMIN' ,'Super Admin');
INSERT INTO "user"."role"("id", "code","name") VALUES ('078793df-0d81-51ca-9847-b4c34f506260','AS_ADMIN_PENGELOLA' ,'Admin Pengelola');
INSERT INTO "user"."role"("id", "code","name") VALUES ('abfc0b97-6fa9-4f18-a3bf-815d9af0db4f','A_ADMIN_FO' ,'Admin FO');
INSERT INTO "user"."role"("id", "code","name") VALUES ('bc8816b7-6ad1-4396-8644-8f087b75cfad','A_ADMIN_MARKETING' ,'Admin Marketing');
INSERT INTO "user"."role"("id", "code","name") VALUES ('fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577','U_USER' ,'User');


DROP TABLE IF EXISTS "user"."account" CASCADE;
CREATE TABLE "user"."account"(
  "id"                uuid            DEFAULT uuid_generate_v4() ,
  "urole_id"          uuid     		    NOT NULL ,
  "pwd"               TEXT        		NOT NULL ,
  "email"             VARCHAR(255) 		NOT NULL UNIQUE ,
  "no_telp" VARCHAR(255) NOT NULL UNIQUE ,
  "foto"               VARCHAR(255) NULL,
  "nama" VARCHAR(255) NOT NULL,
  "alamat" VARCHAR(255) NOT NULL,
  "jenis_kelamin_personal" VARCHAR(255) NULL,
  "is_ban" BOOLEAN DEFAULT FALSE NOT NULL,
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
  FOREIGN KEY ("urole_id") REFERENCES "user"."role"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_uaccount" ON "user"."account" ("id");
CREATE INDEX "fkey_uaccount_urole" ON "user"."account" ("urole_id");

DROP TABLE IF EXISTS "user"."instansi_user" CASCADE;
CREATE TABLE "user"."instansi_user"
(
  "id"         uuid          DEFAULT uuid_generate_v4() ,
  "account_id" uuid          NOT NULL ,
  "logo_instansi" varchar(255)  NULL ,
  "nama_instansi" varchar(255)  NOT NULL ,
  "website_instansi" varchar(255)  NULL ,
  "kategori_id" uuid          NOT NULL ,
  "ekraf_id"   uuid          NOT NULL ,
  "kota_instansi" varchar(255)  NOT NULL ,
  "kecamatan_instansi" varchar(255)  NOT NULL ,
  "alamat_instansi" varchar(255)  NOT NULL ,
  "deskripsi_instansi" varchar(255)  NULL ,
  "email_instansi" varchar(255)  NOT NULL ,
  "pic_instansi" varchar(255)  NOT NULL ,
  "facebook" VARCHAR(255) NULL,
  "instagram" VARCHAR(255) NULL,
  "twitter" VARCHAR(255) NULL,
  "youtube" VARCHAR(255) NULL,
  "tiktok" VARCHAR(255) NULL,
  "created_at" timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("kategori_id") REFERENCES "master"."kategori" ("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("ekraf_id") REFERENCES "master"."ekraf" ("id") ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_uinstansi_user" ON "user"."instansi_user" ("id");
CREATE INDEX "fkey_uinstansi_user_uaccount" ON "user"."instansi_user" ("account_id");


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
DROP TABLE IF EXISTS "user"."instansi_user" CASCADE;