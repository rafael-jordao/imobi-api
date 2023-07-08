import { Injectable } from "@nestjs/common";
import { type Prisma } from '@prisma/client';
import { PrismaService } from "../prisma.service";

@Injectable()
export class BrokerRepository {
    constructor(private readonly prismaService: PrismaService) { }

    create(createDto: Prisma.BrokerCreateArgs) {
        return this.prismaService.broker.create(createDto)
    }

    findByEmail(findUniqueDto: Prisma.BrokerFindUniqueArgs) {
        return this.prismaService.broker.findUnique(findUniqueDto);
    }
}