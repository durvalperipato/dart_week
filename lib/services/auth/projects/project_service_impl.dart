import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/models/project_model.dart';
import 'package:job_timer/app/models/project_task_model.dart';
import 'package:job_timer/repositories/projects/project_repository.dart';
import 'package:job_timer/services/auth/projects/project_service.dart';

import '../../../app/entities/project.dart';
import '../../../app/entities/project_task.dart';

class ProjectServiceImpl extends ProjectService {
  final ProjectRepository _projectRepository;

  ProjectServiceImpl({required ProjectRepository projectRepository})
      : _projectRepository = projectRepository;

  @override
  Future<void> register(ProjectModel projectModel) async {
    final project = Project()
      ..id = projectModel.id
      ..name = projectModel.name
      ..status = projectModel.status
      ..estimate = projectModel.estimate;

    await _projectRepository.register(project);
  }

  @override
  Future<List<ProjectModel>> findByStatus(ProjectStatus status) async {
    final projects = await _projectRepository.findByStatus(status);
    //return projects.map((e) => ProjectModel.fromEntity(e)).toList();
    return projects.map(ProjectModel.fromEntity).toList(); // Flutter 3.0
  }

  @override
  Future<ProjectModel> findById(int projectId) async {
    final project = await _projectRepository.findById(projectId);
    return ProjectModel.fromEntity(project);
  }

  @override
  Future<ProjectModel> addTask(int projectId, ProjectTaskModel task) async {
    final projectTask = ProjectTask()
      ..name = task.name
      ..duration = task.duration;

    final project = await _projectRepository.addTask(projectId, projectTask);
    return ProjectModel.fromEntity(project);
  }

  @override
  Future<void> finish(int projectId) => _projectRepository.finish(projectId);
}
