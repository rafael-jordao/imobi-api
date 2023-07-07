/*
  Warnings:

  - You are about to drop the `Client` table. If the table is not empty, all the data it contains will be lost.

*/
-- CreateEnum
CREATE TYPE "property_finality_type" AS ENUM ('VENDA', 'ALUGUEL');

-- CreateEnum
CREATE TYPE "status_type" AS ENUM ('LANCAMENTO', 'PRONTO', 'CONSTRUCAO');

-- DropTable
DROP TABLE "Client";

-- CreateTable
CREATE TABLE "client" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "broker" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "cpf" TEXT NOT NULL,
    "creci" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "broker_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "property" (
    "id" UUID NOT NULL,
    "broker_id" UUID NOT NULL,
    "category_id" UUID NOT NULL,
    "building_finality" "property_finality_type" NOT NULL,
    "status" "status_type" NOT NULL,
    "private_area" DOUBLE PRECISION NOT NULL,
    "total_area" DOUBLE PRECISION NOT NULL,
    "bedrooms" INTEGER NOT NULL,
    "suites" INTEGER NOT NULL,
    "garages" INTEGER NOT NULL,
    "details" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "condominium_fee" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "brokerId" UUID NOT NULL,

    CONSTRAINT "property_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "category" (
    "id" UUID NOT NULL,
    "property_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "icon" TEXT NOT NULL,

    CONSTRAINT "category_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "address" (
    "id" UUID NOT NULL,
    "property_id" UUID NOT NULL,
    "city" TEXT NOT NULL,
    "neighborhood" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "number" TEXT NOT NULL,
    "landmark" TEXT NOT NULL,

    CONSTRAINT "address_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "property_photo" (
    "id" UUID NOT NULL,
    "property_id" UUID NOT NULL,
    "image_path" TEXT NOT NULL,
    "details" TEXT NOT NULL,
    "order" INTEGER NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "property_photo_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "client_email_key" ON "client"("email");

-- CreateIndex
CREATE UNIQUE INDEX "client_cpf_key" ON "client"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "broker_email_key" ON "broker"("email");

-- CreateIndex
CREATE UNIQUE INDEX "broker_cpf_key" ON "broker"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "broker_creci_key" ON "broker"("creci");

-- CreateIndex
CREATE UNIQUE INDEX "address_property_id_key" ON "address"("property_id");

-- AddForeignKey
ALTER TABLE "property" ADD CONSTRAINT "property_broker_id_fkey" FOREIGN KEY ("broker_id") REFERENCES "broker"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "property" ADD CONSTRAINT "property_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "category"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "address" ADD CONSTRAINT "address_property_id_fkey" FOREIGN KEY ("property_id") REFERENCES "property"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "property_photo" ADD CONSTRAINT "property_photo_property_id_fkey" FOREIGN KEY ("property_id") REFERENCES "property"("id") ON DELETE CASCADE ON UPDATE CASCADE;
