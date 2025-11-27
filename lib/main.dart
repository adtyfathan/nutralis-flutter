import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutralis_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:nutralis_flutter/presentation/product/bloc/product_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'config/dependency_injection.dart';
import 'config/routes.dart';
import 'presentation/auth/bloc/auth_bloc.dart';
import 'presentation/auth/bloc/auth_event.dart';
import 'presentation/auth/bloc/auth_state.dart';
import 'presentation/auth/login_screen.dart';
import 'presentation/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url: AppConstants.supabaseUrl,
    anonKey: AppConstants.supabaseAnonKey,
  );

  // Setup dependencies
  await setupDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => getIt<AuthBloc>()..add(AuthCheckRequested()),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => getIt<HomeBloc>(),
        ),
        BlocProvider<ProductBloc>(
          create: (context) => getIt<ProductBloc>(),
        )
      ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        onGenerateRoute: AppRoutes.generateRoute,
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state.status == AuthStatus.loading ||
                state.status == AuthStatus.initial) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (state.status == AuthStatus.authenticated &&
                state.user != null) {
              return const HomeScreen();
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
