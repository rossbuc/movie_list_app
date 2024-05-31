import 'package:flutter/material.dart';
import 'package:movie_list_app/data_model.dart';
import 'package:provider/provider.dart';

class GenresPage extends StatefulWidget {
  const GenresPage({super.key});

  @override
  State<GenresPage> createState() => _GenresPageState();
}

class _GenresPageState extends State<GenresPage> {
  @override
  void initState() {
    super.initState();
    final dataModel = Provider.of<DataModel>(context, listen: false);
    dataModel.fetchGenreIds();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataModel>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Genres"),
        ),
        body: ListView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: value.genreIds.length,
          itemBuilder: (context, index) {
            final genre = value.genreIds.entries.elementAt(index);
            print("This is the genresList ${value.genreIds.entries}");
            return ListTile(
              title: Text(genre.key),
              onTap: () {
                final genreId = genre.value;
                Provider.of<DataModel>(context, listen: false)
                    .fetchData(genreId);
              },
            );
          },
        ),
      ),
    );
  }
}
