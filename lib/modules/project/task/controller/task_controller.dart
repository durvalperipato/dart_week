import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:job_timer/app/models/project_task_model.dart';
import 'package:job_timer/services/auth/projects/project_service.dart';

import '../../../../app/models/project_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  /* 
  
  Vamos guardar esta instância na controller ao invés do TaskState pois 
  a página Task não precisa de nenhum detalhe do project model e sim somente
  quando apertamos salvar na página que cria a nova task, ou seja, retornando
  para a controller. Porém tem que ser privado para não ter acesso externo

  */

  late final ProjectModel _projectModel;
  final ProjectService _projectService;

  TaskController({required ProjectService projectService})
      : _projectService = projectService,
        super(TaskStatus.initial);

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;

  Future<void> register(String name, int duration) async {
    try {
      emit(TaskStatus.loading);
      final task = ProjectTaskModel(name: name, duration: duration);
      await _projectService.addTask(_projectModel.id!, task);
      emit(TaskStatus.success);
    } on Exception catch (e, s) {
      log('Erro ao cadastrar task', error: e, stackTrace: s);
      emit(TaskStatus.failure);
    }
  }
}
