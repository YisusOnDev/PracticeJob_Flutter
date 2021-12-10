import 'package:auto_route/auto_route.dart';
import 'package:practicejob/src/routes/app_routes.dart';
import 'package:practicejob/src/services/auth_service.dart';

class AuthGuard extends AutoRouteGuard {
  final _authService = AuthService();

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final authorized = await _authService.isAuthorized();
    if (authorized) {
      resolver.next(true);
    } else {
      router.push(const SplashScreenRoute());
      resolver.next(true);
    }
  }
}
