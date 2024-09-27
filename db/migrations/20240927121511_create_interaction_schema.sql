-- migrate:up
CREATE SCHEMA IF NOT EXISTS "interaction";

DROP TABLE IF EXISTS "interaction"."follow" CASCADE;
CREATE TABLE "interaction"."follow"(
  "id"            uuid          DEFAULT uuid_generate_v4() ,
  "follower_id" uuid NOT NULL,
  "following_id" uuid NOT NULL,
  "status_follow" BOOLEAN DEFAULT FALSE NOT NULL,
  "created_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  "updated_at"        TIMESTAMP   		NOT NULL  DEFAULT CURRENT_TIMESTAMP ,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("follower_id") REFERENCES "user"."account"("id")  ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("following_id") REFERENCES "user"."account"("id")  ON UPDATE CASCADE ON DELETE CASCADE
);

-- migrate:down
DROP SCHEMA IF EXISTS "interaction" CASCADE;
DROP TABLE IF EXISTS "interaction"."follow" CASCADE;

