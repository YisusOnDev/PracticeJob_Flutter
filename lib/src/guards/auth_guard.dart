import 'package:auto_route/auto_route.dart';
import 'package:practicejob/src/routes/app_routes.dart';
import 'package:practicejob/src/services/auth_service.dart';

final _authService = AuthService();

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    final isAuthenticated = await _authService.isAuthenticated();
    if (isAuthenticated) {
      resolver.next(true);
    } else {
      router.push(WelcomePageRoute());
      resolver.next(true);
    }
  }
}
