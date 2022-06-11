import 'dart:developer';

import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project_status.dart';
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
}
