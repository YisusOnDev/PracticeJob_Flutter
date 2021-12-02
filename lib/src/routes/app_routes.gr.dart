// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'app_routes.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter(
      {GlobalKey<NavigatorState>? navigatorKey, required this.authGuard})
      : super(navigatorKey);

  final AuthGuard authGuard;

  @override
  final Map<String, PageFactory> pagesMap = {
    WelcomePageRoute.name: (routeData) {
      final args = routeData.argsAs<WelcomePageRouteArgs>(
          orElse: () => const WelcomePageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: WelcomePage(key: args.key, title: args.title));
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>(
          orElse: () => const LoginPageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: LoginPage(key: args.key, title: args.title));
    },
    SignUpPageRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpPageRouteArgs>(
          orElse: () => const SignUpPageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: SignUpPage(key: args.key, title: args.title));
    },
    HomePageRoute.name: (routeData) {
      final args = routeData.argsAs<HomePageRouteArgs>(
          orElse: () => const HomePageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: HomePage(key: args.key, title: args.title));
    },
    CompleteProfilePageRoute.name: (routeData) {
      final args = routeData.argsAs<CompleteProfilePageRouteArgs>(
          orElse: () => const CompleteProfilePageRouteArgs());
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: CompleteProfilePage(key: args.key, title: args.title));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig('/#redirect',
            path: '/', redirectTo: '/welcome', fullMatch: true),
        RouteConfig(WelcomePageRoute.name, path: '/welcome'),
        RouteConfig(LoginPageRoute.name, path: '/login'),
        RouteConfig(SignUpPageRoute.name, path: '/signup'),
        RouteConfig(HomePageRoute.name, path: '/home', guards: [authGuard]),
        RouteConfig(CompleteProfilePageRoute.name,
            path: '/completeprofile', guards: [authGuard]),
        RouteConfig('*#redirect', path: '*', redirectTo: '/', fullMatch: true)
      ];
}

/// generated route for [WelcomePage]
class WelcomePageRoute extends PageRouteInfo<WelcomePageRouteArgs> {
  WelcomePageRoute({Key? key, String? title})
      : super(name,
            path: '/welcome',
            args: WelcomePageRouteArgs(key: key, title: title));

  static const String name = 'WelcomePageRoute';
}

class WelcomePageRouteArgs {
  const WelcomePageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'WelcomePageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [LoginPage]
class LoginPageRoute extends PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({Key? key, String? title})
      : super(name,
            path: '/login', args: LoginPageRouteArgs(key: key, title: title));

  static const String name = 'LoginPageRoute';
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [SignUpPage]
class SignUpPageRoute extends PageRouteInfo<SignUpPageRouteArgs> {
  SignUpPageRoute({Key? key, String? title})
      : super(name,
            path: '/signup', args: SignUpPageRouteArgs(key: key, title: title));

  static const String name = 'SignUpPageRoute';
}

class SignUpPageRouteArgs {
  const SignUpPageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'SignUpPageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [HomePage]
class HomePageRoute extends PageRouteInfo<HomePageRouteArgs> {
  HomePageRoute({Key? key, String? title})
      : super(name,
            path: '/home', args: HomePageRouteArgs(key: key, title: title));

  static const String name = 'HomePageRoute';
}

class HomePageRouteArgs {
  const HomePageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'HomePageRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for [CompleteProfilePage]
class CompleteProfilePageRoute
    extends PageRouteInfo<CompleteProfilePageRouteArgs> {
  CompleteProfilePageRoute({Key? key, String? title})
      : super(name,
            path: '/completeprofile',
            args: CompleteProfilePageRouteArgs(key: key, title: title));

  static const String name = 'CompleteProfilePageRoute';
}

class CompleteProfilePageRouteArgs {
  const CompleteProfilePageRouteArgs({this.key, this.title});

  final Key? key;

  final String? title;

  @override
  String toString() {
    return 'CompleteProfilePageRouteArgs{key: $key, title: $title}';
  }
}
