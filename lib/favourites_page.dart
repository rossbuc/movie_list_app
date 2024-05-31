import 'package:flutter/material.dart';
import 'package:movie_list_app/data_model.dart';
import 'package:movie_list_app/movie_tile.dart';
import 'package:provider/provider.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (contex, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Favourites"),
        ),
        body: Center(
          child: ListView.builder(
            itemCount: value.favourites.length,
            itemBuilder: (BuildContext context, int index) {
              var movie = value.favourites[index];
              var posterUrl =
                  'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
              var backDropUrl =
                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}';
              print(
                  "These are the genreIds in the my app section ${value.genreIds}");
              return MovieTile(
                  posterUrl: posterUrl, movie: movie, backDropUrl: backDropUrl);
            },
          ),
        ),
      ),
    );
  }
}
