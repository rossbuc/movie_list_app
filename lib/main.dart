import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  fetchData();
  runApp(const MyApp());
}

void fetchData() async {
  final url = Uri.parse(
      'https://movie-database-alternative.p.rapidapi.com/?s=Avengers%20Endgame');
  print(url);
  final response = await http.get(url, headers: {
    'X-RapidAPI-Key': 'baa216fbefmsh1eb2e559e9272a7p13e0a8jsnf9079f31be9f',
    'X-RapidAPI-Host': 'movie-database-alternative.p.rapidapi.com'
  });

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    print(data);
  } else {
    print("error in loading data, status code: ${response.statusCode}");
    throw Exception("Failed to load data");
  }
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
    return const Scaffold();
  }
}
