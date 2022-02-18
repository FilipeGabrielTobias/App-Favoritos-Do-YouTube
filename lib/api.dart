import 'dart:convert';

import 'package:favoritos_youtube/models/video.dart';
import 'package:http/http.dart' as http;

const API_KEY = '';

class Api {
  search(String search) async {
    http.Response response = await http.get(
      'https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10'
    );

    decode(response);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 20) {
      var decoded = json.decode(response.body);

      List<Video> videos = decoded['items'].map<Video>((map) {
        return Video.fromJson(map);
      }).toList();

      print(videos);

      return videos;
    } else {
      throw Exception('Failed to load videos');
    }
  }
}