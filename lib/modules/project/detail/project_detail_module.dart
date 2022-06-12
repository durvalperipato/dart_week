import 'package:flutter_modular/flutter_modular.dart';
import 'package:job_timer/modules/project/detail/project_detail.page.dart';

class ProjectDetailModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes =>
      [ChildRoute('/', child: ((context, args) => const ProjectDetailPage()))];
}
