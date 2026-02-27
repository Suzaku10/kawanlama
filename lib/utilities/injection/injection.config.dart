// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../application/auth_controller.dart' as _i255;
import '../../application/item_controller.dart' as _i456;
import '../../domain/interface/i_auth.dart' as _i42;
import '../../domain/interface/i_item_data_source.dart' as _i394;
import '../../infrastructure/core/database_module/dao/favorite_dao.dart'
    as _i48;
import '../../infrastructure/core/database_module/database_module.dart' as _i64;
import '../../infrastructure/core/register_module.dart' as _i438;
import '../../infrastructure/repository/auth_repository.dart' as _i923;
import '../../infrastructure/repository/item_repository.dart' as _i675;
import '../router/app_route_guard.dart' as _i216;
import '../router/app_router.dart' as _i81;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    await gh.lazySingletonAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i64.MyDatabase>(() => registerModule.db);
    gh.lazySingleton<_i394.IItemDataSource>(
        () => _i675.ItemRepository(gh<_i361.Dio>()));
    gh.lazySingleton<_i48.FavoritesDao>(
        () => _i48.FavoritesDao(gh<_i64.MyDatabase>()));
    gh.lazySingleton<_i42.IAuth>(() => _i923.AuthRepository(
          gh<_i116.GoogleSignIn>(),
          gh<_i460.SharedPreferences>(),
        ));
    gh.lazySingleton<_i216.AppRouteGuard>(
        () => _i216.AppRouteGuard(gh<_i42.IAuth>()));
    gh.lazySingleton<_i255.AuthController>(
        () => _i255.AuthController(gh<_i42.IAuth>()));
    gh.lazySingleton<_i456.ItemController>(() => _i456.ItemController(
          gh<_i394.IItemDataSource>(),
          gh<_i48.FavoritesDao>(),
          gh<_i42.IAuth>(),
        ));
    gh.lazySingleton<_i81.AppRouter>(
        () => _i81.AppRouter(gh<_i216.AppRouteGuard>()));
    return this;
  }
}

class _$RegisterModule extends _i438.RegisterModule {}
