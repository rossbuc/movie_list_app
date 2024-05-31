import 'package:flutter/material.dart';

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
