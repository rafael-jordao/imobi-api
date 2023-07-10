import { Injectable } from "@nestjs/common";
import { PrismaService } from "../prisma.service";
import { hash } from 'bcryptjs';
import { CreateBrokerDto } from "src/modules/broker/dto/create-broker.dto";

@Injectable()
export class BrokerRepository {
    constructor(private readonly prismaService: PrismaService) { }

    async create(createDto: CreateBrokerDto) {
        const { name, email, password, phone, cpf, creci } = createDto;
        const hashedPassword = await hash(password, 12);

        return await this.prismaService.broker.create({
            data: {
                name: name,
                email: email,
                password: hashedPassword,
                phone: phone,
                cpf: cpf,
                creci: creci
            }
        })
    }

    async findByEmail(email: string) {
        return await this.prismaService.broker.findUnique({
            where: {
                email: email,
            },
            select: { id: true }
        });
    }
}