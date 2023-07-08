import { Module } from '@nestjs/common';
import { BrokerModule } from './modules/broker/broker.module';
import { DatabaseModule } from './shared/database/database.module';

@Module({
  imports: [BrokerModule, DatabaseModule],
  controllers: [],
  providers: [],
})
export class AppModule { }
