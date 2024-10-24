-- migrate:up
CREATE SCHEMA IF NOT EXISTS "tracking";

-- tracking manusia2 yang ada di MCC modul schema (hold version)
DROP TABLE IF EXISTS "tracking"."tracking" CASCADE;
CREATE TABLE "tracking"."tracking"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "account_id" uuid NOT NULL,
  "date" timestamp NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("account_id") REFERENCES "user"."account"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE INDEX "pkey_tracking" ON "tracking"."tracking" ("id");

-- migrate:down
DROP SCHEMA IF EXISTS "tracking" CASCADE;
DROP TABLE IF EXISTS "tracking"."tracking" CASCADE;

