import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      log('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.asset('assets/images/logo_transparent.png'),
              ),
              const Text(
                'YuiX',
                style: TextStyle(fontSize: 28),
              ),
              const SizedBox(height: 20),
              Text(
                'Version: 2.1.0',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.secondary),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(10.0),
                child: const Text(
                  'f',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () => (),
                    icon: const Icon(Icons.telegram, size: 50),
                  ),
                  IconButton(
                    onPressed: () => (),
                    icon: const Icon(Ionicons.logo_github, size: 48),
                  ),
                ],
              ),
              const Expanded(child: SizedBox.shrink()),
              const Text('- Ryan Yuuki >_<'),
            ],
          ),
        ),
      ),
    );
  }
}
