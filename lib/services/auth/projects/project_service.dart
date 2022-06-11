import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/models/project_model.dart';

/*
Porque nunca retornar entidades na camada de service?

Pois as entidades estão ligadas diretas ao banco de dados
e se caso fizer uma alteração de forma errada, vai alterar o banco
de dados, ao vezes, sem ao menos saber que houve alteração

*/
abstract class ProjectService {
  Future<void> register(ProjectModel projectModel);
  Future<List<ProjectModel>> findByStatus(ProjectStatus status);
}
