part of 'project_detail_controller.dart';

enum ProjectDetailStatus { initial, loading, complete, failure }

class ProjectDetailState extends Equatable {
  final ProjectDetailStatus status;
  final ProjectModel? projectModel;

  /* Porque na home_page passamos o project model que é um estado necessário nesta página,
é null, porque não temos uma instância logo de imediato com o modular.
É necessário realizar em dois passos, verficar como passa este atributo no
arquivo project_detail_module.dart
*/
  const ProjectDetailState._({required this.status, this.projectModel});

  const ProjectDetailState.initial()
      : this._(status: ProjectDetailStatus.initial);

  ProjectDetailState copyWith({
    ProjectDetailStatus? status,
    ProjectModel? projectModel,
  }) {
    return ProjectDetailState._(
        status: status ?? this.status,
        projectModel: projectModel ?? this.projectModel);
  }

  @override
  List<Object?> get props => [status, projectModel];
}
