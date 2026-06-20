import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/network/dio_client.dart';
import 'features/product/data/datasource/product_remote_datasource.dart';
import 'features/product/data/repositories/product_repository.dart';
import 'features/product/presentation/bloc/product_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// Dio
  sl.registerLazySingleton<Dio>(() => DioClient.instance);

  /// Data Source
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSource(sl<Dio>()),
  );

  /// Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepository(sl<ProductRemoteDataSource>()),
  );

  /// Bloc
  sl.registerFactory<ProductBloc>(() => ProductBloc(sl<ProductRepository>()));
}
