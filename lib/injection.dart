import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';

import 'features/product/data/datasource/product_remote_datasource.dart';
import 'features/product/data/repositories/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

import 'features/cart/data/datasource/cart_local_datasource.dart';
import 'features/cart/data/repositories/cart_repository.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Dio
  sl.registerLazySingleton<Dio>(() => DioClient.instance);

  /// ---------------- Product ----------------

  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(sl<Dio>()),
  );

  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(sl<ProductRemoteDataSource>()),
  );

  sl.registerFactory<ProductBloc>(() => ProductBloc(sl<ProductRepository>()));

  /// ---------------- Cart ----------------

  sl.registerLazySingleton<CartLocalDataSource>(() => CartLocalDataSource());

  sl.registerLazySingleton<CartRepository>(
    () => CartRepository(sl<CartLocalDataSource>()),
  );

  sl.registerFactory<CartBloc>(() => CartBloc(sl<CartRepository>()));
}
