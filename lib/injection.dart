import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/network/dio_client.dart';
import 'features/product/data/datasource/product_remote_datasource.dart';
import 'features/product/data/repositories/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/cart/data/datasource/cart_local_datasource.dart';
import 'features/cart/data/repositories/cart_repository.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/theme/data/datasource/theme_local_datasource.dart';
import 'features/theme/data/repositories/theme_repository.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Dio
  sl.registerLazySingleton<Dio>(() => DioClient.instance);

  /// ================= PRODUCT =================

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(sl<ProductRemoteDataSource>()),
  );

  sl.registerFactory<ProductBloc>(() => ProductBloc(sl<ProductRepository>()));

  /// ================= CART =================

  sl.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSource());

  sl.registerLazySingleton<CartRepository>(
    () => CartRepository(sl<CartLocalDataSource>()),
  );

  sl.registerFactory<CartBloc>(() => CartBloc(sl<CartRepository>()));

  /// ================= THEME =================

  sl.registerLazySingleton<ThemeLocalDataSource>(() => ThemeLocalDataSource());

  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepository(sl<ThemeLocalDataSource>()),
  );

  sl.registerLazySingleton<ThemeCubit>(() => ThemeCubit(sl<ThemeRepository>()));
}
