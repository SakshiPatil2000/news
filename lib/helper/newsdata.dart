import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';


class NewsData {
  List<News_Model> dataToBeSavedIn = [];
  final String _apiKey = 'c4b4518942bc48b0b5c43572fe4acf4c';

  Future<void> getNews() async {
    try {
      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          jsonData['articles']?.forEach((element) {
            if (element['urlToImage'] != null && element['description'] != null) {
              News_Model newsModel = News_Model(
                title: element['title'] ?? 'No Title',
                urlToImage: element['urlToImage'] ?? '',
                description: element['description'] ?? 'No Description',
                url: element['url'] ?? '',
              );
              dataToBeSavedIn.add(newsModel);
            }
          });
        }
      } else {
        print('Error: Failed to fetch news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}

// Fetching news by category
class CategoryNews {
  List<News_Model> dataToBeSavedIn = [];
  final String _apiKey = 'c4b4518942bc48b0b5c43572fe4acf4c'; // Use a secure storage method.

  Future<void> getNews(String category) async {
    try {
      final response = await http.get(
        Uri.parse('https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        if (jsonData['status'] == 'ok') {
          jsonData['articles']?.forEach((element) {
            if (element['urlToImage'] != null && element['description'] != null) {
              News_Model newsModel = News_Model(
                title: element['title'] ?? 'No Title',
                urlToImage: element['urlToImage'] ?? '',
                description: element['description'] ?? 'No Description',
                url: element['url'] ?? '',
              );
              dataToBeSavedIn.add(newsModel);
            }
          });
        }
      } else {
        print('Error: Failed to fetch news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
