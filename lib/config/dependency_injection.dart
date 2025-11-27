import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/datasources/auth_datasource.dart';
import '../data/datasources/product_datasource.dart';
import '../data/datasources/scanned_product_datasource.dart';
import '../data/repositories/auth_repository.dart';
import '../data/repositories/product_repository.dart';
import '../data/repositories/scanned_product_repository.dart';
import '../presentation/auth/bloc/auth_bloc.dart';
import '../presentation/home/bloc/home_bloc.dart';
import '../presentation/product/bloc/product_bloc.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // External
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Data Sources
  getIt.registerLazySingleton<AuthDataSource>(
    () => AuthDataSource(getIt<SupabaseClient>()),
  );
  getIt.registerLazySingleton<ProductDataSource>(
    () => ProductDataSource(getIt<Dio>()),
  );
  getIt.registerLazySingleton<ScannedProductDataSource>(
    () => ScannedProductDataSource(getIt<SupabaseClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<AuthDataSource>()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepository(getIt<ProductDataSource>()),
  );
  getIt.registerLazySingleton<ScannedProductRepository>(
    () => ScannedProductRepository(getIt<ScannedProductDataSource>()),
  );

  // BLoCs
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<HomeBloc>(
    () => HomeBloc(productRepository: getIt<ProductRepository>()),
  );
  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      productRepository: getIt<ProductRepository>(),
      scannedProductRepository: getIt<ScannedProductRepository>(),
    ),
  );
}
