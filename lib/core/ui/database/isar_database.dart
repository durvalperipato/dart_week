import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:job_timer/core/ui/database/database.dart';
import 'package:path_provider/path_provider.dart';

class IsarDatabase implements Database {
  Isar? _databaseInstance;

  @override
  Future<Isar> openConnection() async {
    if (_databaseInstance == null) {
      final dir = await getApplicationSupportDirectory();
      _databaseInstance = await Isar.open(
        schemas: [
          ProjectTaskSchema,
          ProjectSchema
        ], //Comunicar o ISAR das entidades, estas classes foram criadas ao rodar o build runner
        directory: dir.path,
        inspector: true,
      );
    }
    return _databaseInstance!;
  }
}
