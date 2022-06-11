import 'package:flutter/material.dart';
import 'package:job_timer/modules/home/widgets/header_projects_menu.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Para o flutter é melhor rodar o customscrollView quando tem mais de 1 list view,
    // ao inves de usar o ListView.builder
    return Scaffold(
      backgroundColor: Colors.black,
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
              delegate: HeaderProjectMenu(),
              pinned: true,
            ),
          ],
        ),
      ),
    );
  }
}
