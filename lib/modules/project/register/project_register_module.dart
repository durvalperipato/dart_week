import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/modules/project/register/controller/project_register_controller.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'project_register_page.dart';

class ProjectRegisterModule extends Module {
  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton((i) =>
            ProjectRegisterController(projectService: i())) //Vem do AppModule
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: ((context, args) => ProjectRegisterPage(
                  controller: Modular.get(),
                )))
      ];
}
