import '../entities/project.dart';
import '../entities/project_status.dart';
import 'project_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimate;
  final ProjectStatus status;
  final List<ProjectTaskModel> tasks;

  ProjectModel(
      {this.id,
      required this.name,
      required this.estimate,
      required this.status,
      required this.tasks});

  factory ProjectModel.fromEntity(Project project) {
    project.tasks.loadSync(); //Carregar as tasks

    return ProjectModel(
        id: project.id,
        name: project.name,
        estimate: project.estimate,
        status: project.status,
        tasks: project.tasks
            .map(/* (e) => */ ProjectTaskModel.fromEntity /* (e) */)
            .toList()); //Flutter 3.0
  }
}