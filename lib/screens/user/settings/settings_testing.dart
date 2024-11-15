import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:yuix/screens/user/settings/settings_testing_detail.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  Future<List<Map<String, dynamic>>>? _searchFuture;
  Future<Map<String, dynamic>>? _detailFuture;
  final TextEditingController _searchController = TextEditingController();

  Future<List<Map<String, dynamic>>> searchManga(String query) async {
    final encodedQuery = Uri.encodeComponent(query);
    final url = Uri.parse('  https://www.toptruyenww.pro/');

    final response = await http.get(
      url,
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
        // 'Accept':
        //     'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
        // 'Accept-Encoding': 'gzip, deflate, br',
        // 'Referer': 'https://truyengg.com',
        // 'Cookie': 'type_book=1'
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
      log('Failed to load search results, status code: ${response.body} ${url}');
      return [];
    } else {
      log('Failed to load search results, status code: ${response.body} ${url}');
      throw Exception("Failed to load manga search results");
    }
  }

  // Future<List<Map<String, dynamic>>> searchManga(String query) async {
  //   final encodedQuery = Uri.encodeComponent(query);
  //   final url = Uri.parse('https://truyengg.com/tim-kiem.html?q=$encodedQuery');

  //   final response = await http.get(
  //     url,
  //     headers: {
  //       'User-Agent':
  //           'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
  //       // 'Accept':
  //       //     'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8',
  //       // 'Accept-Encoding': 'gzip, deflate, br',
  //       // 'Referer': 'https://truyengg.com',
  //       'Cookie': 'type_book=1'
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     final document = parser.parse(response.body);

  //     final elements =
  //         document.querySelectorAll('.list_item_home .image-cover');

  //     final results = <Map<String, dynamic>>[];
  //     for (var element in elements) {
  //       final linkElement = element.querySelector('a');
  //       final imgElement = element.querySelector('img');

  //       final id = linkElement?.attributes['href']?.split('/').last;
  //       final image = imgElement?.attributes['src'];
  //       final title = imgElement?.attributes['alt'];

  //       results.add(
  //         {
  //           'id': id,
  //           'image': image,
  //           'title': title,
  //         },
  //       );
  //     }
  //     return results;
  //   } else {
  //     log('Failed to load search results, status code: ${response.statusCode} ${url}');
  //     throw Exception("Failed to load manga search results");
  //   }
  // }

  Future<Map<String, dynamic>> fetchMangaDetails(String mangaId) async {
    final url = Uri.parse('https://truyengg.com/truyen-tranh/$mangaId');
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

      // Get manga title
      final titleElement = document.querySelector('.title_tale h1');
      final title = titleElement != null ? titleElement.text.trim() : "Unknown";

      // Get views
      final viewsElement = document.querySelector('.bi-eye-fill + p');
      final views = viewsElement != null ? viewsElement.text.trim() : "0";
      // Get chapters
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
        'id': mangaId,
        'title': title,
        'views': views,
        'chapters': chapterList.reversed.toList(),
      };
    } else {
      throw Exception("Failed to load manga details");
    }
  }

  void _onSearch() {
    setState(() {
      _searchFuture = searchManga(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Test Sources'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Enter manga title...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _onSearch,
                ),
              ),
              onSubmitted: (_) => _onSearch(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _searchFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    log('Failed to load manga: ${snapshot.error}');
                    return const Center(child: Text('Failed to load manga'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }

                  final results = snapshot.data!;
                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final manga = results[index];
                      return ListTile(
                        leading: Image.network(
                          manga['image'] ?? '',
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                        title: Text(manga['title'] ?? 'No title'),
                        subtitle: Text('ID: ${manga['id']}'),
                        onTap: () {
                          // Navigate to the detail page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MangaDetailPage(
                                mangaId: manga['id']!,
                                title: manga['title'] ?? 'Manga Details',
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
