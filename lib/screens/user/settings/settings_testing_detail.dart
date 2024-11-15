import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:developer';

class MangaDetailPage extends StatefulWidget {
  final String mangaId;
  final String title;

  const MangaDetailPage(
      {super.key, required this.mangaId, required this.title});

  @override
  State<MangaDetailPage> createState() => _MangaDetailPageState();
}

class _MangaDetailPageState extends State<MangaDetailPage> {
  Future<Map<String, dynamic>>? _detailFuture;

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

  @override
  void initState() {
    super.initState();
    _detailFuture = fetchMangaDetails(widget.mangaId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            log('Failed to load manga details: ${snapshot.error}');
            return const Center(child: Text('Failed to load manga details'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No details found'));
          }

          final mangaDetails = snapshot.data!;
          final chapters =
              mangaDetails['chapters'] as List<Map<String, dynamic>>;

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Text(
                mangaDetails['title'] ?? 'No Title',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('Views: ${mangaDetails['views'] ?? '0'}'),
              const SizedBox(height: 20),
              const Text(
                'Chapters:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...chapters.map(
                (chapter) => ListTile(
                  title: Text(chapter['title']),
                  subtitle: Text('Date: ${chapter['date']}'),
                  onTap: () {
                    // Handle chapter click here
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
