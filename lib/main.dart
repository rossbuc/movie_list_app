import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await fetchData();
  runApp(const MyApp());
}

Future<Map<String, dynamic>> fetchData() async {
  const apiKeyUrl = String.fromEnvironment('API_KEY');
  print(apiKeyUrl);
  final url = Uri.parse(apiKeyUrl);
  print('Requesting data from: $url');
  try {
    final response = await http.get(url);

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
