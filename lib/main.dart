import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'core/theme/app_theme.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/cart/presentation/bloc/cart_event.dart';
import 'features/product/presentation/bloc/product_bloc.dart';
import 'features/product/presentation/bloc/product_event.dart';
import 'features/product/presentation/pages/product_list_page.dart';
import 'features/theme/presentation/cubit/theme_cubit.dart';
import 'features/theme/presentation/cubit/theme_state.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) => sl<ProductBloc>()..add(const FetchProducts()),
        ),

        BlocProvider<CartBloc>(
          create: (_) => sl<CartBloc>()..add(const LoadCart()),
        ),

        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()..loadTheme()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'ShopEase',
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const ProductListPage(),
          );
        },
      ),
    );
  }
}
