import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:kawanlama/domain/constant/app_pages.dart';
import 'package:kawanlama/presentation/ui/auth/login_page.dart';
import 'package:kawanlama/presentation/ui/home/contact_page.dart';
import 'package:kawanlama/presentation/ui/home/favorite_page.dart';
import 'package:kawanlama/presentation/ui/home/home_page.dart';
import 'package:kawanlama/utilities/router/app_route_guard.dart';

part 'app_router.gr.dart';

@lazySingleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  final AppRouteGuard _guard;

  AppRouter(this._guard);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(path: AppPages.loginRoute, page: LoginRoute.page),
        AutoRoute(
            path: AppPages.homeRoute,
            page: HomeRoute.page,
            guards: [_guard],
            initial: true,
            children: [
              RedirectRoute(path: '', redirectTo: AppPages.homeContactRoute),
              AutoRoute(
                  path: AppPages.homeContactRoute, page: ContactRoute.page),
              AutoRoute(
                  path: AppPages.homeFavoriteRoute, page: FavoriteRoute.page),
            ]),
      ];
}
