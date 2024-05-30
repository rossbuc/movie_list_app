import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataModel extends ChangeNotifier {
  var appData = [];
  Map<String, int> genreIds = {};

  DataModel() {
    fetchData();
    fetchGenreIds();
  }

  void setData(movieData) {
    appData = movieData;
    notifyListeners();
  }

  void setGenreIds(genreIDs) {
    genreIds = genreIDs;
    notifyListeners();
  }

  Future<Map<String, dynamic>> fetchData([int? genreId]) async {
    // var apiKeyUrl = dotenv.env['API_KEY_URL'];
    final authToken = dotenv.env['AUTH_TOKEN'];
    final queryParams = {
      'sort_by': 'popularity.desc',
      if (genreId != null) 'with_genres': genreId.toString(),
    };
    final url =
        Uri.https('api.themoviedb.org', '/3/discover/movie', queryParams);
    print('Requesting data from: $url');
    print("And using this auth token for the request, ${authToken}");
    try {
      final response = await http
          .get(url, headers: {'Authorization': 'Bearer ${authToken}'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print(data);
        setData(data['results']);
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

  Future<Map<String, int>> fetchGenreIds() async {
    final authToken = dotenv.env['AUTH_TOKEN'];
    final url = Uri.https(
        'api.themoviedb.org', '/3/genre/movie/list', {'language': 'en'});

    print("Fetching genre ids from: $url");

    try {
      final response = await http
          .get(url, headers: {"Authorization": 'Bearer ${authToken}'});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Map<String, int> genreIds = {};
        for (var genre in data['genres']) {
          genreIds[genre['name']] = genre['id'];
        }
        print("These are the genreIds ${genreIds}");
        setGenreIds(genreIds);
        return genreIds;
      } else {
        throw Exception("Failed to load genres");
      }
    } catch (e) {
      throw Exception("Failed to load genres: $e");
    }
  }
}
