import 'dart:convert';

import 'package:anime_galaxy/utils/logger/logger.dart';
import 'package:dio/dio.dart';

class VideoUrlExtractor {
  static Future<List<String>> getVideoUrlFromYoutube(String youtubeUrl) async {
    var link = _getVideoId(youtubeUrl);
    if (link == null) {
      print('Null Video Id from Link: $youtubeUrl');
      Logger().error('Player Error', 'Null Video Id from Link: $youtubeUrl');
    }

    var networkClient = Dio();
    var links = <String>[];
    var response = await networkClient.get(link);
    var responseText = response.data.toString();
    var sections = Uri.decodeFull(responseText).split('&');
    var playerResponse = <String, dynamic>{};
    for (int i = 0; i < sections.length; i++) {
      String s = sections[i];
      int firstEqual = s.indexOf('=');
      if (firstEqual < 0) {
        continue;
      }
      String key = s.substring(0, firstEqual);
      String value = s.substring(firstEqual + 1);
      if (key == 'player_response') {
        playerResponse = jsonDecode(value);
        break;
      }
    }

    Map data = playerResponse['streamingData'];

    if (data['formats'] != null) {
      var formatLinks = [];
      formatLinks = data['formats'];
      if (formatLinks != null) {
        print('Format Links ' + formatLinks.length.toString());
        formatLinks.forEach((element) {
          links.add(element['url']);
        });
      }
    }

    if (data['adaptiveFormats'] is List) {
      var formatLinks = [];
      formatLinks = data['adaptiveFormats'];
      print('Adaptive Links ' + formatLinks.length.toString());
      formatLinks.forEach((element) {
        links.add(element['url']);
      });
    }

    return links.isNotEmpty
        ? links
        : [
      'https://res.cloudinary.com/micksawy3r/video/upload/v1613492701/alb_tvn0963_1080p.mp4'
    ];
  }

  static String _getVideoId(String url) {
    try {
      var id = '';
      if (url.contains('http')) {
        id = url.substring(url.indexOf('?v=') + '?v='.length);
      } else {
        id = url;
      }
      return 'https://www.youtube.com/get_video_info?video_id=${id}&el=embedded&ps=default&eurl=&gl=US&hl=en';
    } catch (e) {
      return null;
    }
  }
}
