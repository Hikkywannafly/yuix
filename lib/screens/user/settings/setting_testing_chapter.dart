import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'dart:developer';

class ChapterDetailPage extends StatefulWidget {
  final String chapterUrl;
  final String chapterTitle;

  const ChapterDetailPage({
    super.key,
    required this.chapterUrl,
    required this.chapterTitle,
  });

  @override
  State<ChapterDetailPage> createState() => _ChapterDetailPageState();
}

final String proxyURl = 'http://localhost:3002/proxy?';

class _ChapterDetailPageState extends State<ChapterDetailPage> {
  Future<List<String>>? _imageFuture;

  Future<List<String>> fetchChapterImages(String url) async {
    final response = await http.get(
      Uri.parse('$url'),
      headers: {
        'User-Agent':
            'Mozilla/5.0 (Linux; Android 13) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.5735.196 Mobile Safari/537.36',
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
  void initState() {
    super.initState();
    _imageFuture = fetchChapterImages(widget.chapterUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapterTitle),
      ),
      body: FutureBuilder<List<String>>(
        future: _imageFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            log('Failed to load chapter images: ${snapshot.error}');
            return const Center(child: Text('Failed to load chapter images'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No images found'));
          }

          final imageUrls = snapshot.data!;
          return ListView.builder(
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              final imageUrl = imageUrls[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Image.network(
                  'https://yuix-proxy.hikky.workers.dev/proxy?url=https://truyengg.com&src=$imageUrl',
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
