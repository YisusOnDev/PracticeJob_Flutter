import 'package:flutter/material.dart';
import 'package:myownapp/src/utils/icon_utils.dart';

import 'menu_provider.dart';

class MyCustomDrawer extends StatelessWidget {
  const MyCustomDrawer({Key? key}) : super(key: key);

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
    final List<Widget> opts = [];
    data?.forEach((item) {
      final tempWidget = ListTile(
        title: Text(item['text']),
        leading: getUsableIcon(item['icon']),
        trailing: const Icon(Icons.arrow_right),
        onTap: () {
          Navigator.pushNamed(context, item["route"]);
        },
      );
      opts.add(tempWidget);
      opts.add(const Divider());
    });
    return opts;
  }
}
