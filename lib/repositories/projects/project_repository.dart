import 'package:job_timer/app/entities/project_status.dart';

import '../../app/entities/project.dart';
import '../../app/entities/project_task.dart';

abstract class ProjectRepository {
  Future<void> register(Project project);
  Future<List<Project>> findByStatus(ProjectStatus status);
  Future<Project> findById(int projectId);
  Future<Project> addTask(int projectId, ProjectTask task);
  Future<void> finish(int projectId);
}
