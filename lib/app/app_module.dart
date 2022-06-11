import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/core/ui/database/database.dart';
import 'package:job_timer/core/ui/database/isar_database.dart';
import 'package:job_timer/modules/login/login_module.dart';
import 'package:job_timer/modules/splash/splash_page.dart';
import 'package:job_timer/services/auth/auth_service.dart';
import 'package:job_timer/services/auth/google_auth.dart';

import '../modules/home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<AuthService>((i) => GoogleAuth()),
        Bind.lazySingleton<Database>((i) => IsarDatabase()),
      ];

//ChildRoute são páginas
//ModuleRoute são módulos
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const SplashPage()),
        ModuleRoute('/login/', module: LoginModule()),
        ModuleRoute('/home/', module: HomeModule()),
      ];
}
