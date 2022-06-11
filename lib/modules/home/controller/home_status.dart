// Verificar a tela para saber os status
part of 'home_controller.dart';

enum HomeStatus { initial, loading, complete, failure }

class HomeState extends Equatable {
  final List<ProjectModel> projects;
  final HomeStatus status;
  final ProjectStatus projectFilter;

  const HomeState._(
      {required this.projects,
      required this.status,
      required this.projectFilter});

  HomeState.initial()
      : this._(
            projects: [],
            status: HomeStatus.initial,
            projectFilter: ProjectStatus.em_andamento);

  HomeState copyWith(
      {List<ProjectModel>? projects,
      HomeStatus? status,
      ProjectStatus? projectFilter}) {
    return HomeState._(
        projects: projects ?? this.projects,
        status: status ?? this.status,
        projectFilter: projectFilter ?? this.projectFilter);
  }

  @override
  List<Object?> get props => [projectFilter, status, projects];
}
