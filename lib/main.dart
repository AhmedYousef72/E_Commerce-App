import 'package:e_commerce/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/blocs/product/product_bloc.dart';
import 'package:e_commerce/blocs/wishlist/wishlist_bloc.dart';
import 'package:e_commerce/blocs/search/search_bloc.dart';
import 'package:e_commerce/repositories/product_repository.dart';
import 'package:e_commerce/repositories/wishlist_repository.dart';
import 'package:e_commerce/screens/wishlist_screen.dart';
import 'package:e_commerce/screens/search_screen.dart';
import 'package:e_commerce/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository = ProductRepository();
  final WishlistRepository wishlistRepository = WishlistRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  ProductBloc(productRepository: productRepository)
                    ..add(LoadProducts()),
        ),
        BlocProvider(
          create:
              (context) =>
                  WishlistBloc(wishlistRepository: wishlistRepository)
                    ..add(LoadWishlist()),
        ),
        BlocProvider(
          create: (context) => SearchBloc(productRepository: productRepository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tech Shop',
        theme: AppTheme.lightTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => HomeScreen(),
          '/wishlist': (context) => WishlistScreen(),
          '/search': (context) => SearchScreen(),
        },
      ),
    );
  }
}
