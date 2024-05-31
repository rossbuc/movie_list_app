import 'package:flutter/material.dart';
import 'package:movie_list_app/data_model.dart';
import 'package:movie_list_app/movie_detail_page.dart';
import 'package:movie_list_app/movie_tile.dart';
import 'package:movie_list_app/navigation_drawer.dart' as custom;
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    return Consumer<DataModel>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                backgroundColor: colorScheme.surfaceContainerHighest,
                shadowColor: colorScheme.shadow,
                title: Text(widget.title),
              ),
              drawer: const custom.NavigationDrawer(),
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
                    print(
                        "These are the genreIds in the my app section ${value.genreIds}");
                    var isFavourite = value.favourites.contains(movie);
                    return MovieTile(
                      posterUrl: posterUrl,
                      movie: movie,
                      backDropUrl: backDropUrl,
                      isFavourite: isFavourite,
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
