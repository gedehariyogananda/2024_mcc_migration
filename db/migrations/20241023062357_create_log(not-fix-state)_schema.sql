-- migrate:up

-- log modul schema 
CREATE SCHEMA IF NOT EXISTS "log";

CREATE TABLE "log"."log" (
  "id" uuid DEFAULT uuid_generate_v4(),
  "admin_log_id" uuid NOT NULL,
  "booking_id" uuid NOT NULL,
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("admin_log_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id") ON UPDATE CASCADE ON DELETE CASCADE
);


-- migrate:down

