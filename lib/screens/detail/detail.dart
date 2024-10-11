import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({
    super.key,
    required this.url,
    required this.package,
    this.tag,
  });
  final String url;
  final String package;
  final String? tag;
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
        actions: [
          //  go back
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
        ],
      ),
      body: Text('Detail Page'),
    );
  }
}
