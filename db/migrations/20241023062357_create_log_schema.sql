-- migrate:up

-- log modul schema 
CREATE SCHEMA IF NOT EXISTS "log";

CREATE TABLE "log"."log" (
  "id" uuid DEFAULT uuid_generate_v4(),
  "account_id" uuid NOT NULL,
  "booking_id" uuid NOT NULL,
  "is_sistem" BOOLEAN NOT NULL DEFAULT FALSE, -- SISTEM OTOMATIS DARI ADMIN
  "aktifitas_log" TEXT NULL, -- USER_CREATED || USER_CHECKIN || ADMIN_CREATED || ADMIN_UPDATED || ADMIN_DELETED || ADMIN_APPROVED || ADMIN_REJECTED || ADMIN_ASSIGNED 
  "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY ("id"),
  FOREIGN KEY ("admin_log_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id") ON UPDATE CASCADE ON DELETE CASCADE
);

-- migrate:down