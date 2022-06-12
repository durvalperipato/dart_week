import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/modules/project/task/controller/task_controller.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import '../../../app/models/project_model.dart';
import 'task_page.dart';

class TaskModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        BlocBind.lazySingleton((i) => TaskController(projectService: i()))
      ]; //Vem do AppModule

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: ((context, args) {
          final ProjectModel projectModel = args.data; // vem do _NewTask Class
          return TaskPage(controller: Modular.get()..setProject(projectModel));
        }))
      ];
}
