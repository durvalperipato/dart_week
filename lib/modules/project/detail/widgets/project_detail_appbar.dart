import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/modules/project/detail/controller/project_detail_controller.dart';

import '../../../../app/models/project_model.dart';

class ProjectDetailAppBar extends SliverAppBar {
  ProjectDetailAppBar({required ProjectModel projectModel, super.key})
      : super(
          expandedHeight: 100,
          pinned: true,
          toolbarHeight: 100,
          title: Text(projectModel.name),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(15))),
          flexibleSpace: Stack(
            children: [
              // A ideia do Material é para possuir o atributo Elevation
              Align(
                alignment: const Alignment(0, 1.5),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Material(
                    elevation: 2,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${projectModel.tasks.length}"),
                            Visibility(
                                visible: projectModel.status !=
                                    ProjectStatus.finalizado,
                                replacement: const Text('Projeto Finalizado'),
                                child: _NewTask(projectModel: projectModel)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
}

class _NewTask extends StatelessWidget {
  final ProjectModel projectModel;

  const _NewTask({Key? key, required this.projectModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() async {
        await Modular.to.pushNamed('/project/task', arguments: projectModel);
        Modular.get<ProjectDetailController>().updateProject();
      }),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
          const Text('Adicionar Task'),
        ],
      ),
    );
  }
}
