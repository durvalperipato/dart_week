import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/modules/home/controller/home_controller.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        BlocBind.lazySingleton(
            (i) => HomeController(projectService: i())) //Vem do AppModule)
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/',
            child: ((context, args) => HomePage(
                  controller: Modular.get()
                    ..loadProjects(), //Carrega os projetos para emitir o estado de loading sem a necessidade de colocar um StatefulWidget na HomePage
                )))
      ];
}
