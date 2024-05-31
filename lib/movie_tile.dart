import 'package:flutter/material.dart';
import 'package:movie_list_app/data_model.dart';
import 'package:movie_list_app/movie_detail_page.dart';
import 'package:provider/provider.dart';

class MovieTile extends StatefulWidget {
  const MovieTile({
    super.key,
    required this.posterUrl,
    required this.movie,
    required this.backDropUrl,
    required this.isFavourite,
  });

  final String posterUrl;
  final movie;
  final String backDropUrl;
  final bool isFavourite;

  @override
  State<MovieTile> createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  @override
  Widget build(BuildContext context) {
    void initState() {
      super.initState();
    }

    ;

    return ListTile(
      leading: Image.network(
        widget.posterUrl,
        width: 50,
        fit: BoxFit.cover,
      ),
      title: Text("${widget.movie["original_title"]}"),
      subtitle: Text("${widget.movie["release_date"]}"),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return MovieDetailPage(
              backDropUrl: widget.backDropUrl, movie: widget.movie);
        }));
      },
      trailing: GestureDetector(
          onTap: () {
            final dataModel = Provider.of<DataModel>(context, listen: false);
            dataModel.addFavourite(widget.movie);
          },
          child: Icon(widget.isFavourite
              ? Icons.favorite
              : Icons.favorite_border_outlined)),
    );
  }
}
