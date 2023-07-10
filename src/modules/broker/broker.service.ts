import { ConflictException, Injectable } from '@nestjs/common';
import { CreateBrokerDto } from './dto/create-broker.dto';
import { UpdateBrokerDto } from './dto/update-broker.dto';
import { BrokerRepository } from 'src/shared/database/repositories/broker.repository';

@Injectable()
export class BrokerService {
  constructor(private readonly brokerRepo: BrokerRepository) { }

  async create(createBrokerDto: CreateBrokerDto) {
    const { name, email, password, phone, cpf, creci } = createBrokerDto;

    const emailIsAlreadyInUse = await this.brokerRepo.findByEmail(email);

    if (emailIsAlreadyInUse) {
      throw new ConflictException('This email is already in use')
    }

    const broker = await this.brokerRepo.create({ name, email, password, phone, cpf, creci });

    return {
      name: broker.name,
      email: broker.email,
    };
  }

  findAll() {
    return `This action returns all broker`;
  }

  findOne(id: number) {
    return `This action returns a #${id} broker`;
  }

  update(id: number, updateBrokerDto: UpdateBrokerDto) {
    return `This action updates a #${id} broker`;
  }

  remove(id: number) {
    return `This action removes a #${id} broker`;
  }
}
