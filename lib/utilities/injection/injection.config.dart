// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i4;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../application/auth_controller.dart' as _i15;
import '../../application/item_controller.dart' as _i12;
import '../../domain/interface/i_auth.dart' as _i10;
import '../../domain/interface/i_item_data_source.dart' as _i5;
import '../../infrastructure/core/database_module/dao/favorite_dao.dart' as _i9;
import '../../infrastructure/core/database_module/database_module.dart' as _i7;
import '../../infrastructure/core/register_module.dart' as _i16;
import '../../infrastructure/repository/auth_repository.dart' as _i11;
import '../../infrastructure/repository/item_repository.dart' as _i6;
import '../router/app_route_guard.dart' as _i13;
import '../router/app_router.dart' as _i14;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i4.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i5.IItemDataSource>(
        () => _i6.ItemRepository(gh<_i3.Dio>()));
    gh.lazySingleton<_i7.MyDatabase>(() => registerModule.db);
    await gh.lazySingletonAsync<_i8.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i9.FavoritesDao>(
        () => _i9.FavoritesDao(gh<_i7.MyDatabase>()));
    gh.lazySingleton<_i10.IAuth>(() => _i11.AuthRepository(
          gh<_i4.GoogleSignIn>(),
          gh<_i8.SharedPreferences>(),
        ));
    gh.lazySingleton<_i12.ItemController>(() => _i12.ItemController(
          gh<_i5.IItemDataSource>(),
          gh<_i9.FavoritesDao>(),
          gh<_i10.IAuth>(),
        ));
    gh.lazySingleton<_i13.AppRouteGuard>(
        () => _i13.AppRouteGuard(gh<_i10.IAuth>()));
    gh.lazySingleton<_i14.AppRouter>(
        () => _i14.AppRouter(gh<_i13.AppRouteGuard>()));
    gh.lazySingleton<_i15.AuthController>(
        () => _i15.AuthController(gh<_i10.IAuth>()));
    return this;
  }
}

class _$RegisterModule extends _i16.RegisterModule {}
