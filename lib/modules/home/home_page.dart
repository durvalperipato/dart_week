import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/models/project_model.dart';
import 'package:job_timer/modules/home/controller/home_controller.dart';
import 'package:job_timer/modules/home/widgets/header_projects_menu.dart';
import 'package:job_timer/modules/home/widgets/project_tile.dart';

class HomePage extends StatelessWidget {
  final HomeController controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    // Para o flutter é melhor rodar o customscrollView quando tem mais de 1 list view,
    // ao inves de usar o ListView.builder
    return BlocListener<HomeController, HomeState>(
        bloc: controller,
        listener: (context, state) {
          if (state.status == HomeStatus.failure) {
            AsukaSnackbar.alert('Erro ao carregar projetos').show();
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: const Drawer(
            child: SafeArea(
              child: ListTile(
                title: Text('Sair'),
              ),
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBar(
                  title: Text('Projetos'),
                  expandedHeight: 100,
                  toolbarHeight: 100,
                  centerTitle: true,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(15)),
                  ),
                  pinned: true,
                ),
                // A utilização deste Sliver abaixo, foi ter a opção de deixar fixo na parte superior da tela ao rolar
                SliverPersistentHeader(
                  delegate: HeaderProjectMenu(controller: controller),
                  pinned: true,
                ),
                BlocSelector<HomeController, HomeState, bool>(
                    bloc: controller,
                    selector: (state) => state.status == HomeStatus.loading,
                    builder: (context, showLoading) {
                      return SliverVisibility(
                          visible: showLoading,
                          sliver: const SliverToBoxAdapter(
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                  child: CircularProgressIndicator.adaptive()),
                            ),
                          ));
                    }),
                BlocSelector<HomeController, HomeState, List<ProjectModel>>(
                    bloc: controller,
                    selector: (state) => state.projects,
                    builder: (context, projects) {
                      return SliverList(
                          delegate: SliverChildListDelegate(projects
                              .map((project) =>
                                  ProjectTile(projectModel: project))
                              .toList()));
                    })
              ],
            ),
          ),
        ));
  }
}
