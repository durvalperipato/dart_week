import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/app/models/project_model.dart';
import 'package:job_timer/modules/project/detail/controller/project_detail_controller.dart';
import 'package:job_timer/modules/project/detail/project_detail.page.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class ProjectDetailModule extends Module {
  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton(
            (i) => ProjectDetailController(projectService: i()))
      ]; //Vem do AppModule

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) {
          final ProjectModel projectModel =
              args.data; //Vem da ProjectTile class
          return ProjectDetailPage(
              controller: Modular.get()..setProjectModel(projectModel));
        })),
      ];
}
