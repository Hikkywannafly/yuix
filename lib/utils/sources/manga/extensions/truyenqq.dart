import 'dart:developer';

import 'package:yuix/utils/sources/manga/base/source_base.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

// class TruyenQQ implements SourceBase {
//   @override
//   String get baseUrl => 'https://truyenqqto.com/';
//   @override
//   String get sourceName => 'TruyenQQ';
//   @override
//   String get sourceVersion => '1.0';

//   @override
//   Future<dynamic> fetchMangaChapters(String id) {
//     return null;
//   }

//   @override
//   Future<dynamic> fetchMangaSearchResults(String query) async {
//     final String url = '$baseUrl/tim-kiem/trang-1.html?q=$query';
//     try {
//       final response = await http.get(Uri.parse(url));
//       final list = <Map<String, dynamic>>[];

//       if (response.statusCode == 200) {
//       } else {
//         log('Failed to load manga details, status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }

// @override
// Future<dynamic> fetchMangaSearchResults(String query) {}
// @override
// Future<dynamic> fetchChapterImages(
//     {required String mangaId, required String chapterId}) {}
// @override
// Future<dynamic> mapToAnilist(String query) {}
// }

Future<List<Map<String, dynamic>>> searchManga(String query) async {
  final url = Uri.parse('https://truyenqqto.com/trang-1.html?q=$query');
  final response = await http.get(url);
  if (response.statusCode == 200) {
    final document = parser.parse(response.body);
    final elements = document.querySelectorAll('.book_avatar');

    final results = <Map<String, dynamic>>[];
    for (var element in elements) {
      results.add(
        {
          'id': element.querySelector('a')?.attributes['href']?.split('/').last,
          'image': element.querySelector('img')?.attributes['src'],
          'title': element.querySelector('img')?.attributes['alt'],
        },
      );
    }

    return results;
  } else {
    log('Failed to load search results, status code: ${response.statusCode}');
    throw Exception("Failed to load manga search results");
  }
}
