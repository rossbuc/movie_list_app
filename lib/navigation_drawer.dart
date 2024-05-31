import 'package:flutter/material.dart';
import 'package:movie_list_app/favourites_page.dart';
import 'package:movie_list_app/genres_page.dart';
import 'package:movie_list_app/main.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeader(context),
            buildItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
    );
  }

  Widget buildItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            leading: const Icon(Icons.movie),
            title: const Text("Genres"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const GenresPage()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text("Favourites"),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavouritesPage()));
            },
          )
        ],
      ),
    );
  }
}
