import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_list_app/data_model.dart';
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
    return const MaterialApp(home: MyHomePage(title: "Movie Lister"));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    displaySideBar();
                  },
                ),
                title: Text(widget.title),
              ),
              body: Center(
                // Add movie class and build the list from movie tiles basically
                child: ListView.separated(
                  itemCount: value.appData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var movie = value.appData[index];
                    var posterUrl =
                        'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
                    var backDropUrl =
                        'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}';

                    return ListTile(
                      leading: Image.network(
                        posterUrl,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text("${movie["original_title"]}"),
                      subtitle: Text("${movie["release_date"]}"),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return MovieDetailPage(
                              backDropUrl: backDropUrl, movie: movie);
                        }));
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: Colors.white,
                    );
                  },
                ),
              ),
            ));
  }
}

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    super.key,
    required this.backDropUrl,
    required this.movie,
  });

  final String backDropUrl;
  final movie;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            backDropUrl,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text("${movie["original_title"]}"),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Center(
            child: Hero(
              tag: "ListTile-Hero",
              child: Text(
                "${movie["overview"]}",
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        )
      ],
    );
  }
}
