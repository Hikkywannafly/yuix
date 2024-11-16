import 'dart:developer';

import 'package:path/path.dart';
import 'package:yuix/utils/sources/manga/base/source_base.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class TruyenQQ implements SourceBase {
  @override
  String get sourceName => 'TruyenQQ';
  @override
  String get sourceVersion => '1.0.0';
  @override
  String get baseUrl => 'https://truyengg.com';

  @override
  Future<dynamic> fetchMangaChapters(String id) async {
    final url = Uri.parse('https://truyengg.com/truyen-tranh/$id');
    final response = await http.get(
      url,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Cookie': 'type_book=1'
      },
    );

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final titleElement = document.querySelector('.title_tale h1');
      final title = titleElement != null ? titleElement.text.trim() : "Unknown";

      final viewsElement = document.querySelector('.bi-eye-fill + p');
      final views = viewsElement != null ? viewsElement.text.trim() : "0";

      final chapterElements =
          document.querySelectorAll('.list_chap .item_chap');
      List<Map<String, dynamic>> chapterList = [];

      for (var chapterElement in chapterElements) {
        final titleElement = chapterElement.querySelector('.wc110 a');
        final dateElement = chapterElement.querySelector('.text-right span em');

        final chapterTitle =
            titleElement != null ? titleElement.text.trim() : "Unknown Chapter";
        final chapterLink =
            titleElement != null ? titleElement.attributes['href'] ?? "#" : "#";
        final chapterDate =
            dateElement != null ? dateElement.text.trim() : "Unknown Date";

        chapterList.add({
          'title': chapterTitle,
          'url': chapterLink,
          'date': chapterDate,
        });
      }

      return {
        'id': id,
        'title': title,
        'views': views,
        'chapters': chapterList.reversed.toList(),
      };
    } else {
      throw Exception("Failed to load manga details");
    }
  }

  @override
  Future<dynamic> fetchMangaSearchResults(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = Uri.parse('https://truyengg.com/tim-kiem.html?q=$encodedQuery');

    final response = await http.get(
      url,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Cookie': 'type_book=1'
      },
    );

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);

      final elements =
          document.querySelectorAll('.list_item_home .image-cover');

      final results = <Map<String, dynamic>>[];
      for (var element in elements) {
        final linkElement = element.querySelector('a');
        final imgElement = element.querySelector('img');

        final id = linkElement?.attributes['href']?.split('/').last;
        final image = imgElement?.attributes['src'];
        final title = imgElement?.attributes['alt'];

        results.add(
          {
            'id': id,
            'image': image,
            'title': title,
          },
        );
      }
      return results;
    } else {
      log('Failed to load search results, status code: ${response.statusCode} ${url}');
      throw Exception("Failed to load manga search results");
    }
  }

  @override
  Future<dynamic> fetchChapterImages(
      {required String mangaId, required String chapterId}) async {
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      },
    );
    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final imageElements =
          document.querySelectorAll('.content_detail_manga img.lazy');
      final imageUrls = imageElements
          .map((element) => element.attributes['src'] ?? '')
          .where((url) => url.isNotEmpty)
          .toList();
      return imageUrls;
    } else {
      throw Exception("Failed to load chapter images");
    }
  }

  @override
  Future<dynamic> mapToAnilist(String query) {
    throw UnimplementedError();
  }
}
