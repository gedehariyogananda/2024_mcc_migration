-- migrate:up

CREATE SCHEMA IF NOT EXISTS "scheduller";
CREATE TABLE "scheduller"."booking_schedule" (
    "id" uuid DEFAULT uuid_generate_v4(),
    "booking_id" uuid NULL, 
    "account_id" uuid NULL,
    "notification_type" VARCHAR(255) NOT NULL DEFAULT 'CHECKIN' , -- INI CHECKIN CHECKOUT,
    "notification_time" TIMESTAMP NOT NULL,
    "is_send" BOOLEAN NOT NULL DEFAULT FALSE,
    "created_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY ("id"),
    FOREIGN KEY ("account_id") REFERENCES "user"."account"("id") ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY ("booking_id") REFERENCES "event"."booking"("id") ON UPDATE CASCADE ON DELETE CASCADE
)

CREATE INDEX "pkey_booking_schedule" ON "scheduller"."booking_schedule" ("id");

-- migrate:down
DROP TABLE IF EXISTS "scheduller"."booking_schedule" CASCADE;

