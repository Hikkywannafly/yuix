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
  final TextEditingController _searchController = TextEditingController();

  // Future<List<Map<String, dynamic>>> searchManga(String query) async {
  //   final encodedQuery = Uri.encodeComponent(query);
  //   final url = Uri.parse('
  // https://www.toptruyenww.pro/');

  Future<List<Map<String, dynamic>>> searchManga(String query) async {
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
      log('Failed to load search results, status code: ${response.statusCode}');
      throw Exception("Failed to load manga search results");
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
