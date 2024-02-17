import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:search_image/data/remote/api/api_service.dart';
import 'package:search_image/data/remote/api/repository/api_repository_impl.dart';
import 'package:search_image/presentation/constants/RouteName.dart';
import 'package:search_image/presentation/ui/screen/home_screen.dart';
import 'package:search_image/presentation/ui/screen/image_view_screen.dart';
import 'package:search_image/presentation/ui/screen/search_image_list_screen.dart';
import 'package:search_image/presentation/utils/color_schemes.g.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';



Future<void> main() async {
  await dotenv.load(fileName: ".env");//환경 변수 로드

  //DI 등록
  GetIt getIt = GetIt.instance;
  void setupGetIt() {
    final dio = Dio();
    // Dio 로깅 설정
    dio.interceptors.add(LogInterceptor(
        requestHeader: true,
        responseBody: true,
        request: true,
        error: true,
        requestBody: true,
        responseHeader: true));


      dio.options.headers = {
        'Authorization': '${dotenv.env['KAKAO_REST_API_KEY']}',
      };

    log('#### ${dotenv.env['KAKAO_REST_API_KEY']}');

    getIt.registerSingleton<Dio>(dio);

    getIt.registerLazySingleton<ApiService>(
          () => ApiService(getIt<Dio>()), // GetIt을 사용하여 Dio 의존성 주입
    );
    getIt.registerLazySingleton<ApiRepositoryImpl>(() => ApiRepositoryImpl());
  }

  WidgetsFlutterBinding.ensureInitialized();
  setupGetIt();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );

}

class MyApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return MaterialApp(
        title: 'Search Image',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
        ),
        themeMode: ThemeMode.system,
        initialRoute: RouteName.homeScreen,
        routes: {
          RouteName.homeScreen: (context) => HomeScreen(),
          RouteName.searchImageListScreen: (context) => SearchImageListScreen(),
          RouteName.imageViewScreen: (context) => ImageViewScreen(),

        });
  }
}
