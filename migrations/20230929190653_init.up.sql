CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE TABLE "users" (
                         "id" uuid NOT NULL UNIQUE DEFAULT uuid_generate_v4(),
                         "name" varchar(64) NOT NULL UNIQUE,
                         "email" varchar(64) NOT NULL UNIQUE,
                         "email_confirmed" bool NOT NULL DEFAULT false,
                         "access" BOOLEAN NOT NULL DEFAULT true,
                         "hash_password" TEXT NOT NULL,
                         "blocking_reason" TEXT NOT NULL DEFAULT null,
                         "date_add" TIMESTAMP NOT NULL,
                         "date_update" TIMESTAMP NOT NULL,
                         "date_ban" TIMESTAMP NOT NULL
) WITH (
      OIDS=FALSE
      );



CREATE TABLE "roles" (
                         "id" uuid NOT NULL UNIQUE DEFAULT uuid_generate_v4(),
                         "name" varchar(36) NOT NULL UNIQUE
) WITH (
      OIDS=FALSE
      );



CREATE TABLE "user_roles" (
                              "id_role" uuid NOT NULL,
                              "id_user" uuid NOT NULL,
                              "date_add" TIMESTAMP NOT null DEFAULT now(),
                              "date_update" TIMESTAMP NOT NULL DEFAULT now()
) WITH (
      OIDS=FALSE
      );



CREATE TABLE "games" (
                         "id" uuid NOT NULL UNIQUE DEFAULT uuid_generate_v4(),
                         "release" BOOLEAN NOT NULL DEFAULT false,
                         "test" BOOLEAN NOT NULL DEFAULT false,
                         "name" varchar(128),
                         "date_release" TIMESTAMP NOT NULL,
                         "date_add" TIMESTAMP NOT NULL DEFAULT now(),
                         "date_update" TIMESTAMP NOT NULL DEFAULT now()
) WITH (
      OIDS=FALSE
      );



CREATE TABLE "section" (
                           "id" uuid NOT NULL UNIQUE DEFAULT uuid_generate_v4(),
                           "id_game" uuid NOT NULL,
                           "name" varchar(128) NOT NULL,
                           "is_open" BOOLEAN NOT NULL DEFAULT false,
                           "date_add" TIMESTAMP NOT NULL DEFAULT now(),
                           "date_update" TIMESTAMP NOT NULL DEFAULT now()
) WITH (
      OIDS=FALSE
      );



CREATE TABLE "posts" (
                         "id" uuid NOT NULL UNIQUE DEFAULT uuid_generate_v4(),
                         "id_author" uuid NOT NULL,
                         "id_section" uuid NOT NULL,
                         "title" varchar(128) NOT NULL,
                         "text" varchar(2048) NOT NULL,
                         "is_open" BOOLEAN NOT NULL DEFAULT false,
                         "date_add" TIMESTAMP NOT NULL DEFAULT now(),
                         "date_update" TIMESTAMP NOT NULL DEFAULT now(),
                         "delete_date" TIMESTAMP DEFAULT null
) WITH (
      OIDS=FALSE
      );



CREATE TABLE "messages" (
                            "id" uuid NOT NULL UNIQUE DEFAULT uuid_generate_v4(),
                            "id_parent" uuid NOT NULL UNIQUE,
                            "id_user" uuid NOT NULL,
                            "id_post" uuid NOT NULL,
                            "text" varchar(1024) NOT NULL,
                            "date_add" TIMESTAMP NOT NULL DEFAULT now(),
                            "date_update" TIMESTAMP NOT NULL DEFAULT now(),
                            "date_delete" TIMESTAMP NOT NULL DEFAULT null
) WITH (
      OIDS=FALSE
      );



CREATE TABLE "files" (
                         "id" uuid NOT NULL,
                         "id_message" uuid NOT NULL,
                         "path" TEXT NOT NULL UNIQUE,
                         CONSTRAINT "files_pk" PRIMARY KEY ("id")
) WITH (
      OIDS=FALSE
      );





ALTER TABLE user_roles ADD CONSTRAINT "user_roles_fk0" FOREIGN KEY ("id_role") REFERENCES "roles"("id");
ALTER TABLE user_roles ADD CONSTRAINT "user_roles_fk1" FOREIGN KEY ("id_user") REFERENCES "users"("id");


ALTER TABLE "section" ADD CONSTRAINT "section_fk0" FOREIGN KEY ("id_game") REFERENCES "games"("id");

ALTER TABLE "posts" ADD CONSTRAINT "posts_fk0" FOREIGN KEY ("id_author") REFERENCES "users"("id");
ALTER TABLE "posts" ADD CONSTRAINT "posts_fk1" FOREIGN KEY ("id_section") REFERENCES "section"("id");

ALTER TABLE "messages" ADD CONSTRAINT "messages_fk0" FOREIGN KEY ("id_parent") REFERENCES "messages"("id");
ALTER TABLE "messages" ADD CONSTRAINT "messages_fk1" FOREIGN KEY ("id_user") REFERENCES "users"("id");
ALTER TABLE "messages" ADD CONSTRAINT "messages_fk2" FOREIGN KEY ("id_post") REFERENCES "posts"("id");

ALTER TABLE "files" ADD CONSTRAINT "files_fk0" FOREIGN KEY ("id_message") REFERENCES "messages"("id");

