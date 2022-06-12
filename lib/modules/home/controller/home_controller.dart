import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/services/auth/projects/project_service.dart';
import '../../../app/entities/project_status.dart';
import '../../../app/models/project_model.dart';

part 'home_status.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;

  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.initial());

  Future<void> loadProjects() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } on Exception catch (e, s) {
      log('Erro ao carregar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    try {
      // Necessário limpar a tela, por isso projects é []
      // Sempre verificar como funciona a sua tela
      emit(state.copyWith(status: HomeStatus.loading, projects: []));
      final projects = await _projectService.findByStatus(status);
      emit(
        state.copyWith(
            status: HomeStatus.complete,
            projects: projects,
            projectFilter: status),
      );
    } on Exception catch (e, s) {
      log('Erro ao carregar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> updateList() => filter(state.projectFilter);
}
