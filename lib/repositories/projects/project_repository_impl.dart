import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/entities/project_task.dart';
import 'package:job_timer/repositories/projects/project_repository.dart';

import '../../app/entities/project.dart';
import '../../core/exceptions/failure.dart';
import '../../core/ui/database/database.dart';

class ProjectRepositoryImpl implements ProjectRepository {
  final Database _database;

  ProjectRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<void> register(Project project) async {
    try {
      final connection = await _database.openConnection();
      await connection.writeTxn((isar) => isar.projects.put(project));
    } on IsarError catch (e, s) {
      log('Error ao cadastrar novo projeto', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao cadastrar projeto');
    }
  }

  @override
  Future<List<Project>> findByStatus(ProjectStatus status) async {
    try {
      final connection = await _database.openConnection();
      final projects =
          await connection.projects.filter().statusEqualTo(status).findAll();
      return projects;
    } on IsarError catch (e, s) {
      log('Error ao buscar projetos pelo status', error: e, stackTrace: s);
      throw Failure(message: 'Erro ao buscar pelo status');
    }
  }

  @override
  Future<Project> findById(int projectId) async {
    final connection = await _database.openConnection();
    final project = await connection.projects.get(projectId);
    if (project == null) {
      throw Failure(message: 'Projeto não encontrado');
    }

    return project;
  }

  @override
  Future<Project> addTask(int projectId, ProjectTask task) async {
    final connection = await _database.openConnection();
    final project = await findById(projectId);
    project.tasks.add(task);
    await connection.writeTxn((isar) => project.tasks.save());

    return project;
  }

  @override
  Future<void> finish(int projectId) async {
    try {
      final connection = await _database.openConnection();
      final project = await findById(projectId);
      project.status = ProjectStatus.finalizado;
      await connection.writeTxn(
          (isar) => connection.projects.put(project, saveLinks: true));
    } on IsarError catch (e, s) {
      log(e.message, error: e, stackTrace: s);
      throw Failure(message: 'Erro ao finalizar projeto');
    }
  }
}
