import 'package:flutter/material.dart';
import 'package:myownapp/src/pages/home_page.dart';
import 'package:myownapp/src/utils/icon_utils.dart';

import 'menu_provider.dart';

class MyCustomDrawer extends StatelessWidget {
  MyCustomDrawer({Key? key}) : super(key: key);

  final List<String> opciones = ['Uno', 'Dos', 'Tres', 'Cuatro', 'Cinque'];

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        const DrawerHeader(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
            color: Colors.purple,
          ),
          child: Center(
            child: Text("Menu",
                style: TextStyle(color: Colors.white, fontSize: 64.0)),
          ),
        ),
        /*ListView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: _generateDrawerList(context),
        )*/
        _drawerOptions(),
      ],
    ));
  }

  Widget _drawerOptions() {
    return FutureBuilder(
        future: menuProvider.loadData(),
        initialData: const [],
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          return ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: _getDrawerItems(snapshot.data, context),
          );
        });
  }

  List<Widget> _getDrawerItems(List<dynamic>? data, BuildContext context) {
    final List<Widget> opciones = [];
    data?.forEach((item) {
      final tempWidget = ListTile(
        title: Text(item['text']),
        leading: getUsableIcon(item['icon']),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          Navigator.pushNamed(context, item["route"]);
        },
      );
      opciones.add(tempWidget);
      opciones.add(const Divider());
    });
    return opciones;
  }

  List<Widget> _generateDrawerList(context) {
    return opciones.map((opcion) {
      return Column(
        children: [
          ListTile(
            title: Text(opcion),
            subtitle: const Text('hola tete'),
            leading: const Icon(Icons.account_box_rounded),
            trailing: const Icon(Icons.arrow_right),
            onTap: () {
              final route =
                  MaterialPageRoute(builder: (context) => const HomePage());
              Navigator.push(context, route);
            },
          ),
          const Divider()
        ],
      );
    }).toList();
  }
}
