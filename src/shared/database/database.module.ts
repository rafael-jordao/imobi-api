import { Global, Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';
import { BrokerRepository } from './repositories/broker.repository';

@Global()
@Module({
    providers: [PrismaService, BrokerRepository],
    exports: [BrokerRepository]
})
export class DatabaseModule { }
