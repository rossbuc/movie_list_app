import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataModel extends ChangeNotifier {
  var appData = [];

  void setData(movieData) {
    appData = movieData;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchData() async {
    // var apiKeyUrl = dotenv.env['API_KEY_URL'];
    final authToken = dotenv.env['AUTH_TOKEN'];
    final url = Uri.https('api.themoviedb.org', '/3/discover/movie',
        {'sort_by': 'popularity.desc'});
    print('Requesting data from: $url');
    print("And using this auth token for the request, ${authToken}");
    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${authToken}'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        setData(data);
        return data;
      } else {
        print("Error in loading data, status code: ${response.statusCode}");
        throw Exception("Failed to load data");
      }
    } catch (e) {
      print("An error occurred: $e");
      if (e is SocketException) {
        print(
            'SocketException: No internet connection or URL is not accessible');
      } else {
        print('Unexpected error: $e');
      }
      throw Exception("Failed to load data ");
    }
  }
}
