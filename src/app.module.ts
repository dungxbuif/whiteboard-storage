import { MiddlewareConsumer, Module } from '@nestjs/common';
import { FilesController } from './files/files.controller';
import { RawParserMiddleware } from './raw-parser.middleware';
import { StorageService } from './storage/storage.service';

@Module({
  controllers: [FilesController],
  providers: [StorageService],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(RawParserMiddleware).forRoutes('**');
  }
}
