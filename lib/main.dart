import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await fetchData();
  runApp(const MyApp());
}

Future<Map<String, dynamic>> fetchData() async {
  // var apiKeyUrl = dotenv.env['API_KEY_URL'];
  final authToken = dotenv.env['AUTH_TOKEN'];
  final url = Uri.https('api.themoviedb.org', '/3/discover/movie',
      {'sort_by': 'popularity.desc'});
  print('Requesting data from: $url');
  print("And using this auth token for the request, ${authToken}");
  try {
    final response =
        await http.get(url, headers: {'Authorization': 'Bearer ${authToken}'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print(data);
      return data;
    } else {
      print("Error in loading data, status code: ${response.statusCode}");
      throw Exception("Failed to load data");
    }
  } catch (e) {
    print("An error occurred: $e");
    if (e is SocketException) {
      print('SocketException: No internet connection or URL is not accessible');
    } else {
      print('Unexpected error: $e');
    }
    throw Exception("Failed to load data ");
  }
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            displaySideBar();
          },
        ),
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('Welcome to Movie Lister!'),
      ),
    );
  }
}
