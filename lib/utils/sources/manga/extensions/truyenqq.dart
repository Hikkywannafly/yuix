import 'dart:developer';
import 'package:yuix/utils/sources/manga/helper/jaro_helper.dart';
import 'package:yuix/utils/sources/manga/base/source_base.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;

class TruyenQQ implements SourceBase {
  @override
  String get baseUrl => 'https://truyengg.com';

  @override
  String get sourceName => 'TruyenQQ';

  @override
  String get locale => 'vi-VN';

  @override
  Future<Map<String, dynamic>> fetchMangaChapters(String mangaId) async {
    final String url = '$baseUrl/truyen-tranh/$mangaId';
    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        'Cookie': 'type_book=1',
      });

      if (response.statusCode == 200) {
        final document = parse(response.body);

        final titleElement = document.querySelector('.title_tale h1');
        final title = titleElement?.text.trim() ?? 'Unknown Title';

        final chapterElements =
            document.querySelectorAll('.list_chap .item_chap');
        final List<Map<String, dynamic>> chapterList =
            chapterElements.map((element) {
          final chapterTitle = element.querySelector('.wc110 a')?.text.trim() ??
              'Unknown Chapter';
          final chapterLink =
              element.querySelector('.wc110 a')?.attributes['href'] ?? '#';
          final chapterDate =
              element.querySelector('.text-right span em')?.text.trim() ??
                  'Unknown Date';
          final chapterNumber = int.tryParse(chapterTitle.split(' ')[1]) ?? 0;

          return {
            'id': chapterLink.split('/').last,
            'title': chapterTitle,
            'path': chapterLink,
            'date': chapterDate,
            'views': 'Unknown Views',
            'number': chapterNumber.toString(),
          };
        }).toList();

        final metaData = {
          'id': mangaId,
          'title': title,
          'chapterList': chapterList.reversed.toList(),
        };
        return metaData;
      } else {
        throw Exception(
            'Failed to load manga information. Status code: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred while scraping manga info: ${e.toString()}');
      return {};
    }
  }

  @override
  Future<dynamic> fetchMangaSearchResults(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = '$baseUrl/tim-kiem.html?q=$encodedQuery';

    final response = await http.get(Uri.parse(url), headers: {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      'Cookie': 'type_book=1',
    });

    if (response.statusCode == 200) {
      final document = parse(response.body);
      final List<Map<String, String>> mangaList = [];

      document
          .querySelectorAll('.list_item_home .image-cover')
          .forEach((element) {
        final linkElement = element.querySelector('a');
        final imgElement = element.querySelector('img');

        final id = linkElement?.attributes['href']?.split('/').last ?? '';
        final image = imgElement?.attributes['src'] ?? '';
        final title = imgElement?.attributes['alt'] ?? '';

        mangaList.add({
          'id': id,
          'title': title,
          'link': linkElement?.attributes['href'] ?? '',
          'image': image,
        });
      });
      return mangaList;
    } else {
      throw Exception('Failed to load manga search results');
    }
  }

  Future<dynamic> fetchChapterImages({
    required String mangaId,
    required String chapterId,
  }) async {
    final url = '$baseUrl/truyen-tranh/$chapterId';
    int index = 0;

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
      });

      if (response.statusCode == 200) {
        final document = parse(response.body);
        final target = document.querySelector('.content_detail_manga');

        final title = document
            .querySelector('.panel-chapter-info-top h1')
            ?.text
            .split('Chapter')
            .first
            .trim();

        final currentChapter =
            'Chapter${document.querySelector('.panel-chapter-info-top h1')?.text.split('Chapter').last ?? ''}';

        final chapterNavLink =
            document.querySelector('.navi-change-chapter-btn');
        final nextChapterLink = chapterNavLink
                ?.querySelector('.navi-change-chapter-btn-next')
                ?.attributes['href'] ??
            '';
        final prevChapterLink = chapterNavLink
                ?.querySelector('.navi-change-chapter-btn-prev')
                ?.attributes['href'] ??
            '';

        final images = target?.querySelectorAll('img.lazy').map((img) {
              index++;
              return {
                'title': img.attributes['title'] ?? '',
                'image': img.attributes['src'] ?? '',
              };
            }).toList() ??
            [];

        final assets = {
          'source': baseUrl,
          'title': title,
          'currentChapter': currentChapter,
          'nextChapterId': nextChapterLink.split('/').last,
          'prevChapterId': prevChapterLink.split('/').last,
          'images': images,
          'totalImages': index,
        };

        print(assets.toString());
        return assets;
      } else {
        log('Failed to load chapter details, status code: ${response.statusCode}');
        return {};
      }
    } catch (e) {
      log('Error: $e');
      return {};
    }
  }

  @override
  Future<dynamic> mapToAnilist(String query) async {
    final mangaList = await fetchMangaSearchResults(query);
    final bestMatchId = findBestMatch(query, mangaList);
    final data = mangaList[0];
    print('Best Match ID: $data');
    if (bestMatchId.isNotEmpty) {
      return await fetchMangaChapters(bestMatchId);
    } else {
      throw Exception('No suitable match found for the query');
    }
  }
}
