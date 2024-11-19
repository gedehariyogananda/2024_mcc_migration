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
  "alamat" VARCHAR(255) NULL,
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
  "status_admin" VARCHAR(255) NULL,
  "aktifitas_admin" TIMESTAMP NULL,
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

-- Dummy data for user.account
INSERT INTO "user"."account" ("id", "urole_id", "pwd", "email", "no_telp", "nama", "is_verified_user", "status_admin", "aktifitas_admin") VALUES 
-- Super Admin
(uuid_generate_v4(), '0795c197-fe7c-5fe3-b708-69fda3a060bf', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'superadmin1@example.com', '1234567890', 'Super Admin 1', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), '0795c197-fe7c-5fe3-b708-69fda3a060bf', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'superadmin2@example.com', '1234567891', 'Super Admin 2', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), '0795c197-fe7c-5fe3-b708-69fda3a060bf', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'superadmin3@example.com', '1234567892', 'Super Admin 3', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), '0795c197-fe7c-5fe3-b708-69fda3a060bf', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'superadmin4@example.com', '1234567893', 'Super Admin 4', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), '0795c197-fe7c-5fe3-b708-69fda3a060bf', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'superadmin5@example.com', '1234567894', 'Super Admin 5', TRUE, 'Online', CURRENT_TIMESTAMP),

-- Admin FO
(uuid_generate_v4(), 'abfc0b97-6fa9-4f18-a3bf-815d9af0db4f', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminfo1@example.com', '1234567895', 'Admin FO 1', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'abfc0b97-6fa9-4f18-a3bf-815d9af0db4f', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminfo2@example.com', '1234567896', 'Admin FO 2', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'abfc0b97-6fa9-4f18-a3bf-815d9af0db4f', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminfo3@example.com', '1234567897', 'Admin FO 3', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'abfc0b97-6fa9-4f18-a3bf-815d9af0db4f', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminfo4@example.com', '1234567898', 'Admin FO 4', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'abfc0b97-6fa9-4f18-a3bf-815d9af0db4f', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminfo5@example.com', '1234567899', 'Admin FO 5', TRUE, 'Online', CURRENT_TIMESTAMP),

-- Admin Marketing
(uuid_generate_v4(), 'bc8816b7-6ad1-4396-8644-8f087b75cfad', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminmarketing1@example.com', '1234567800', 'Admin Marketing 1', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'bc8816b7-6ad1-4396-8644-8f087b75cfad', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminmarketing2@example.com', '1234567801', 'Admin Marketing 2', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'bc8816b7-6ad1-4396-8644-8f087b75cfad', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminmarketing3@example.com', '1234567802', 'Admin Marketing 3', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'bc8816b7-6ad1-4396-8644-8f087b75cfad', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminmarketing4@example.com', '1234567803', 'Admin Marketing 4', TRUE, 'Online', CURRENT_TIMESTAMP),
(uuid_generate_v4(), 'bc8816b7-6ad1-4396-8644-8f087b75cfad', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'adminmarketing5@example.com', '1234567804', 'Admin Marketing 5', TRUE, 'Online', CURRENT_TIMESTAMP),

-- User
('fdc57bb8-19ae-4291-aee5-6bee15f10216', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user1@example.com', '1234567805', 'User 1', TRUE,NULL, NULL),
('f7f19610-1a8b-4202-b4fd-7c4266baf01a', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user2@example.com', '1234567806', 'User 2', TRUE,NULL, NULL),
('f6ae0db8-2f4c-4429-9a42-5484835c61eb', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user3@example.com', '1234567807', 'User 3', TRUE,NULL, NULL),
('f45a1ea0-b2dd-4937-b89b-ef63231cbc39', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'luthfia.e2411@gmail.com', '1234567808', 'User 4', FALSE,NULL, NULL),
('e955dc84-119a-4535-b6c4-90804c10e927', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user5@example.com', '1234567809', 'User 5', TRUE,NULL, NULL),
('e26139fc-27fb-4f64-b45b-dccbfba55495', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user6@example.com', '1234567810', 'User 6', TRUE,NULL, NULL),
('e165e26e-e853-4931-af45-2d19155607ce', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user7@example.com', '1234567811', 'User 7', TRUE,NULL, NULL),
('e130e293-0169-4bd8-904d-ab45790e26f8', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user8@example.com', '1234567812', 'User 8', TRUE,NULL, NULL),
('da2bc103-7693-4960-873b-8361577c5b19', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user9@example.com', '1234567813', 'User 9', TRUE,NULL, NULL),
('d974ddc7-f0c3-446a-8d6c-b4ef892591a6', 'fa9c7b2f-3a64-4a16-b18a-dfe7b76b7577', '$argon2id$v=19$t=3,m=4096,p=1$0rCgoyIPWD/Zp6XA8875WQ$NOlvYm5rGH8uA6sic24wBg39CP0enXEqd2xlBVMl1us', 'user10@example.com', '1234567814', 'User 10', TRUE,NULL, NULL);


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

-- Dummy data for user.instansi_user
INSERT INTO "user"."instansi_user" ("id", "account_id", "nama_instansi", "kategori_id", "ekraf_id", "kota_instansi", "kecamatan_instansi", "alamat_instansi", "email_instansi", "pic_instansi") VALUES 
-- User 1
('02b572dc-8475-4621-88bb-ca4978208bd9', 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'instansi_user1_1', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Kota 1', 'Kecamatan 1', 'Alamat 1', 'instansi1@example.com', 'PIC 1'),
(uuid_generate_v4(), 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'instansi_user1_2', '19a7d0a9-2c28-49b7-a13f-c4929b769c26', '34f6811d-76e5-4e0a-8239-79c4e0444acb', 'Kota 2', 'Kecamatan 2', 'Alamat 2', 'instansi2@example.com', 'PIC 2'),
(uuid_generate_v4(), 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'instansi_user1_3', '3f2a1295-7b3e-4f69-86bb-5a76fb3051cf', '1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'Kota 3', 'Kecamatan 3', 'Alamat 3', 'instansi3@example.com', 'PIC 3'),
(uuid_generate_v4(), 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'instansi_user1_4', '4a8ed3b6-b43e-4af7-b556-7b4c9b0e602a', 'd2f709c7-627f-4f1b-8021-4f9e056ca774', 'Kota 4', 'Kecamatan 4', 'Alamat 4', 'instansi4@example.com', 'PIC 4'),
(uuid_generate_v4(), 'fdc57bb8-19ae-4291-aee5-6bee15f10216', 'instansi_user1_5', '550e8400-e29b-41d4-a716-446655440000', '110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'Kota 5', 'Kecamatan 5', 'Alamat 5', 'instansi5@example.com', 'PIC 5'),

-- User 2
(uuid_generate_v4(), 'f7f19610-1a8b-4202-b4fd-7c4266baf01a', 'instansi_user2_1', '7e43ae9c-989f-4569-8fc3-94abfc9efb55', 'a663b4ae-3729-4a53-964f-5a25bc1e2d8f', 'Kota 6', 'Kecamatan 6', 'Alamat 6', 'instansi6@example.com', 'PIC 6'),
(uuid_generate_v4(), 'f7f19610-1a8b-4202-b4fd-7c4266baf01a', 'instansi_user2_2', 'a74a2511-467b-4a78-8395-408b8b0d7619', '9f62f5d8-bbe1-4f6a-8c1b-df78d7a157f4', 'Kota 7', 'Kecamatan 7', 'Alamat 7', 'instansi7@example.com', 'PIC 7'),
(uuid_generate_v4(), 'f7f19610-1a8b-4202-b4fd-7c4266baf01a', 'instansi_user2_3', 'bcb66048-0be3-464d-9249-7b31a0ed98fa', 'dabd6ec8-4fd9-4a3a-a0b3-908ec0adad12', 'Kota 8', 'Kecamatan 8', 'Alamat 8', 'instansi8@example.com', 'PIC 8'),
(uuid_generate_v4(), 'f7f19610-1a8b-4202-b4fd-7c4266baf01a', 'instansi_user2_4', 'f94d5f72-6111-4b47-927a-df68e32956d2', '3216a1f1-4b9f-4655-a28a-dbb570cc5f0b', 'Kota 9', 'Kecamatan 9', 'Alamat 9', 'instansi9@example.com', 'PIC 9'),
(uuid_generate_v4(), 'f7f19610-1a8b-4202-b4fd-7c4266baf01a', 'instansi_user2_5', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '630d1fa6-8369-46be-b4ac-d431cb503c54', 'Kota 10', 'Kecamatan 10', 'Alamat 10', 'instansi10@example.com', 'PIC 10'),

-- User 3 (continued)
(uuid_generate_v4(), 'f6ae0db8-2f4c-4429-9a42-5484835c61eb', 'instansi_user3_1', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Kota 1', 'Kecamatan 1', 'Alamat 1', 'instansi1@example.com', 'PIC 1'),
(uuid_generate_v4(), 'f6ae0db8-2f4c-4429-9a42-5484835c61eb', 'instansi_user3_2', '19a7d0a9-2c28-49b7-a13f-c4929b769c26', '34f6811d-76e5-4e0a-8239-79c4e0444acb', 'Kota 2', 'Kecamatan 2', 'Alamat 2', 'instansi2@example.com', 'PIC 2'),
(uuid_generate_v4(), 'f6ae0db8-2f4c-4429-9a42-5484835c61eb', 'instansi_user3_3', '3f2a1295-7b3e-4f69-86bb-5a76fb3051cf', '1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'Kota 3', 'Kecamatan 3', 'Alamat 3', 'instansi3@example.com', 'PIC 3'),
(uuid_generate_v4(), 'f6ae0db8-2f4c-4429-9a42-5484835c61eb', 'instansi_user3_4', '4a8ed3b6-b43e-4af7-b556-7b4c9b0e602a', 'd2f709c7-627f-4f1b-8021-4f9e056ca774', 'Kota 4', 'Kecamatan 4', 'Alamat 4', 'instansi4@example.com', 'PIC 4'),
(uuid_generate_v4(), 'f6ae0db8-2f4c-4429-9a42-5484835c61eb', 'instansi_user3_5', '550e8400-e29b-41d4-a716-446655440000', '110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'Kota 5', 'Kecamatan 5', 'Alamat 5', 'instansi5@example.com', 'PIC 5'),

-- User 5
(uuid_generate_v4(), 'e955dc84-119a-4535-b6c4-90804c10e927', 'instansi_user5_1', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Kota 1', 'Kecamatan 1', 'Alamat 1', 'instansi1@example.com', 'PIC 1'),
(uuid_generate_v4(), 'e955dc84-119a-4535-b6c4-90804c10e927', 'instansi_user5_2', '19a7d0a9-2c28-49b7-a13f-c4929b769c26', '34f6811d-76e5-4e0a-8239-79c4e0444acb', 'Kota 2', 'Kecamatan 2', 'Alamat 2', 'instansi2@example.com', 'PIC 2'),
(uuid_generate_v4(), 'e955dc84-119a-4535-b6c4-90804c10e927', 'instansi_user5_3', '3f2a1295-7b3e-4f69-86bb-5a76fb3051cf', '1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'Kota 3', 'Kecamatan 3', 'Alamat 3', 'instansi3@example.com', 'PIC 3'),
(uuid_generate_v4(), 'e955dc84-119a-4535-b6c4-90804c10e927', 'instansi_user5_4', '4a8ed3b6-b43e-4af7-b556-7b4c9b0e602a', 'd2f709c7-627f-4f1b-8021-4f9e056ca774', 'Kota 4', 'Kecamatan 4', 'Alamat 4', 'instansi4@example.com', 'PIC 4'),
(uuid_generate_v4(), 'e955dc84-119a-4535-b6c4-90804c10e927', 'instansi_user5_5', '550e8400-e29b-41d4-a716-446655440000', '110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'Kota 5', 'Kecamatan 5', 'Alamat 5', 'instansi5@example.com', 'PIC 5'),

-- User 6
(uuid_generate_v4(), 'e26139fc-27fb-4f64-b45b-dccbfba55495', 'instansi_user6_1', '7e43ae9c-989f-4569-8fc3-94abfc9efb55', 'a663b4ae-3729-4a53-964f-5a25bc1e2d8f', 'Kota 6', 'Kecamatan 6', 'Alamat 6', 'instansi6@example.com', 'PIC 6'),
(uuid_generate_v4(), 'e26139fc-27fb-4f64-b45b-dccbfba55495', 'instansi_user6_2', 'a74a2511-467b-4a78-8395-408b8b0d7619', '9f62f5d8-bbe1-4f6a-8c1b-df78d7a157f4', 'Kota 7', 'Kecamatan 7', 'Alamat 7', 'instansi7@example.com', 'PIC 7'),
(uuid_generate_v4(), 'e26139fc-27fb-4f64-b45b-dccbfba55495', 'instansi_user6_3', 'bcb66048-0be3-464d-9249-7b31a0ed98fa', 'dabd6ec8-4fd9-4a3a-a0b3-908ec0adad12', 'Kota 8', 'Kecamatan 8', 'Alamat 8', 'instansi8@example.com', 'PIC 8'),
(uuid_generate_v4(), 'e26139fc-27fb-4f64-b45b-dccbfba55495', 'instansi_user6_4', 'f94d5f72-6111-4b47-927a-df68e32956d2', '3216a1f1-4b9f-4655-a28a-dbb570cc5f0b', 'Kota 9', 'Kecamatan 9', 'Alamat 9', 'instansi9@example.com', 'PIC 9'),
(uuid_generate_v4(), 'e26139fc-27fb-4f64-b45b-dccbfba55495', 'instansi_user6_5', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '630d1fa6-8369-46be-b4ac-d431cb503c54', 'Kota 10', 'Kecamatan 10', 'Alamat 10', 'instansi10@example.com', 'PIC 10'),

-- User 7
(uuid_generate_v4(), 'e165e26e-e853-4931-af45-2d19155607ce', 'instansi_user7_1', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Kota 1', 'Kecamatan 1', 'Alamat 1', 'instansi1@example.com', 'PIC 1'),
(uuid_generate_v4(), 'e165e26e-e853-4931-af45-2d19155607ce', 'instansi_user7_2', '19a7d0a9-2c28-49b7-a13f-c4929b769c26', '34f6811d-76e5-4e0a-8239-79c4e0444acb', 'Kota 2', 'Kecamatan 2', 'Alamat 2', 'instansi2@example.com', 'PIC 2'),
(uuid_generate_v4(), 'e165e26e-e853-4931-af45-2d19155607ce', 'instansi_user7_3', '3f2a1295-7b3e-4f69-86bb-5a76fb3051cf', '1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'Kota 3', 'Kecamatan 3', 'Alamat 3', 'instansi3@example.com', 'PIC 3'),
(uuid_generate_v4(), 'e165e26e-e853-4931-af45-2d19155607ce', 'instansi_user7_4', '4a8ed3b6-b43e-4af7-b556-7b4c9b0e602a', 'd2f709c7-627f-4f1b-8021-4f9e056ca774', 'Kota 4', 'Kecamatan 4', 'Alamat 4', 'instansi4@example.com', 'PIC 4'),
(uuid_generate_v4(), 'e165e26e-e853-4931-af45-2d19155607ce', 'instansi_user7_5', '550e8400-e29b-41d4-a716-446655440000', '110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'Kota 5', 'Kecamatan 5', 'Alamat 5', 'instansi5@example.com', 'PIC 5'),

-- User 8
(uuid_generate_v4(), 'e130e293-0169-4bd8-904d-ab45790e26f8', 'instansi_user8_1', '7e43ae9c-989f-4569-8fc3-94abfc9efb55', 'a663b4ae-3729-4a53-964f-5a25bc1e2d8f', 'Kota 6', 'Kecamatan 6', 'Alamat 6', 'instansi6@example.com', 'PIC 6'),
(uuid_generate_v4(), 'e130e293-0169-4bd8-904d-ab45790e26f8', 'instansi_user8_2', 'a74a2511-467b-4a78-8395-408b8b0d7619', '9f62f5d8-bbe1-4f6a-8c1b-df78d7a157f4', 'Kota 7', 'Kecamatan 7', 'Alamat 7', 'instansi7@example.com', 'PIC 7'),
(uuid_generate_v4(), 'e130e293-0169-4bd8-904d-ab45790e26f8', 'instansi_user8_3', 'bcb66048-0be3-464d-9249-7b31a0ed98fa', 'dabd6ec8-4fd9-4a3a-a0b3-908ec0adad12', 'Kota 8', 'Kecamatan 8', 'Alamat 8', 'instansi8@example.com', 'PIC 8'),
(uuid_generate_v4(), 'e130e293-0169-4bd8-904d-ab45790e26f8', 'instansi_user8_4', 'f94d5f72-6111-4b47-927a-df68e32956d2', '3216a1f1-4b9f-4655-a28a-dbb570cc5f0b', 'Kota 9', 'Kecamatan 9', 'Alamat 9', 'instansi9@example.com', 'PIC 9'),
(uuid_generate_v4(), 'e130e293-0169-4bd8-904d-ab45790e26f8', 'instansi_user8_5', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '630d1fa6-8369-46be-b4ac-d431cb503c54', 'Kota 10', 'Kecamatan 10', 'Alamat 10', 'instansi10@example.com', 'PIC 10'),

-- User 9
(uuid_generate_v4(), 'da2bc103-7693-4960-873b-8361577c5b19', 'instansi_user9_1', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '3fa85f64-5717-4562-b3fc-2c963f66afa6', 'Kota 1', 'Kecamatan 1', 'Alamat 1', 'instansi1@example.com', 'PIC 1'),
(uuid_generate_v4(), 'da2bc103-7693-4960-873b-8361577c5b19', 'instansi_user9_2', '19a7d0a9-2c28-49b7-a13f-c4929b769c26', '34f6811d-76e5-4e0a-8239-79c4e0444acb', 'Kota 2', 'Kecamatan 2', 'Alamat 2', 'instansi2@example.com', 'PIC 2'),
(uuid_generate_v4(), 'da2bc103-7693-4960-873b-8361577c5b19', 'instansi_user9_3', '3f2a1295-7b3e-4f69-86bb-5a76fb3051cf', '1b3b6576-7959-43fa-8c4f-41f0f948c5b0', 'Kota 3', 'Kecamatan 3', 'Alamat 3', 'instansi3@example.com', 'PIC 3'),
(uuid_generate_v4(), 'da2bc103-7693-4960-873b-8361577c5b19', 'instansi_user9_4', '4a8ed3b6-b43e-4af7-b556-7b4c9b0e602a', 'd2f709c7-627f-4f1b-8021-4f9e056ca774', 'Kota 4', 'Kecamatan 4', 'Alamat 4', 'instansi4@example.com', 'PIC 4'),
(uuid_generate_v4(), 'da2bc103-7693-4960-873b-8361577c5b19', 'instansi_user9_5', '550e8400-e29b-41d4-a716-446655440000', '110ec58a-a0f2-4ac4-8393-c866d813b8d1', 'Kota 5', 'Kecamatan 5', 'Alamat 5', 'instansi5@example.com', 'PIC 5'),

-- User 10
-- User 10 (continued)
(uuid_generate_v4(), 'd974ddc7-f0c3-446a-8d6c-b4ef892591a6', 'instansi_user10_1', '7e43ae9c-989f-4569-8fc3-94abfc9efb55', 'a663b4ae-3729-4a53-964f-5a25bc1e2d8f', 'Kota 6', 'Kecamatan 6', 'Alamat 6', 'instansi6@example.com', 'PIC 6'),
(uuid_generate_v4(), 'd974ddc7-f0c3-446a-8d6c-b4ef892591a6', 'instansi_user10_2', 'a74a2511-467b-4a78-8395-408b8b0d7619', '9f62f5d8-bbe1-4f6a-8c1b-df78d7a157f4', 'Kota 7', 'Kecamatan 7', 'Alamat 7', 'instansi7@example.com', 'PIC 7'),
(uuid_generate_v4(), 'd974ddc7-f0c3-446a-8d6c-b4ef892591a6', 'instansi_user10_3', 'bcb66048-0be3-464d-9249-7b31a0ed98fa', 'dabd6ec8-4fd9-4a3a-a0b3-908ec0adad12', 'Kota 8', 'Kecamatan 8', 'Alamat 8', 'instansi8@example.com', 'PIC 8'),
(uuid_generate_v4(), 'd974ddc7-f0c3-446a-8d6c-b4ef892591a6', 'instansi_user10_4', 'f94d5f72-6111-4b47-927a-df68e32956d2', '3216a1f1-4b9f-4655-a28a-dbb570cc5f0b', 'Kota 9', 'Kecamatan 9', 'Alamat 9', 'instansi9@example.com', 'PIC 9'),
(uuid_generate_v4(), 'd974ddc7-f0c3-446a-8d6c-b4ef892591a6', 'instansi_user10_5', '0de9879d-e999-4959-8d7a-5b8e9ab0f29d', '630d1fa6-8369-46be-b4ac-d431cb503c54', 'Kota 10', 'Kecamatan 10', 'Alamat 10', 'instansi10@example.com', 'PIC 10');



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