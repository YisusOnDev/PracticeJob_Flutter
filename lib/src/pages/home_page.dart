import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/routes/app_routes.dart';
import 'package:practicejob/src/services/auth_service.dart';

class HomePage extends StatefulWidget {
  static var pageName = 'Home Page';

  const HomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _authService = AuthService();
  final tabsItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.work),
      label: 'Ofertas',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.archive),
      label: 'Inscripciones',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Perfil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AutoTabsScaffold(
      appBarBuilder: (_, tabsRouter) => AppBar(
        backgroundColor: cPrimaryColor,
        title: Text(getCurrentTabIndexLabel(tabsRouter.activeIndex)),
        centerTitle: true,
        toolbarHeight: size.height / 12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.elliptical(size.width, 20.0),
          ),
        ),
        actions: getCurrentActions(tabsRouter.activeIndex),
        elevation: 0,
        leading: const AutoBackButton(),
      ),
      routes: const [
        JobListingPageRoute(),
        JobApplicationPageRoute(),
        ProfilePageRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return customBottomNavigationBar(tabsRouter);
      },
    );
  }

  BottomNavigationBar customBottomNavigationBar(tabsRouter) {
    return BottomNavigationBar(
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
      backgroundColor: cPrimaryLightColor,
      items: tabsItems,
    );
  }

  getCurrentTabIndexLabel(activeIndex) {
    return tabsItems[activeIndex].label;
  }

  /// Method that returns appbar icons if current page has
  List<Widget>? getCurrentActions(activeIndex) {
    if (getCurrentTabIndexLabel(activeIndex) == 'Perfil') {
      return [
        IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              _authService.logout();
              context.router.removeLast();
              context.router.replaceNamed('/');
            }),
      ];
    } else {
      return [];
    }
  }
}
