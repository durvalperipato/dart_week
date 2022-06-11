import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/converters/project_status_converter.dart';

import 'project_status.dart';
import 'project_task.dart';

part 'project.g.dart';

@Collection()
class Project {
  @Id()
  int? id;

  late String name;
  late int estimate;

  @ProjectStatusConverter() //Foi criado esta classe para converter o enum em um int para ser válido no Isar
  late ProjectStatus status;

  final tasks = IsarLinks<ProjectTask>(); // 1 -> n
}
