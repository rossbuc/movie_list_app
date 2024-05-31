import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_list_app/data_model.dart';
import 'package:movie_list_app/genres_page.dart';
import 'package:movie_list_app/movie_detail_page.dart';
import 'package:movie_list_app/my_home_page.dart';
import 'package:movie_list_app/navigation_drawer.dart' as custom;
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // await fetchData();
  runApp(ChangeNotifierProvider(
    create: (context) => DataModel(),
    child: const MyApp(),
  ));
}

void displaySideBar() {
  print("Display sidebar called");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      brightness: MediaQuery.platformBrightnessOf(context),
      seedColor: Colors.indigo,
    );
    return MaterialApp(
        title: "Movie Lister App demo",
        theme: ThemeData(
          colorScheme: colorScheme,
        ),
        home: const MyHomePage(title: "Movie Lister"));
  }
}
