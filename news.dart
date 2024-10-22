import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(FinancialNewsApp());

class FinancialNewsApp extends StatelessWidget {
  const FinancialNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Financial News',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FinancialNewsPage(),
    );
  }
}

class FinancialNewsPage extends StatefulWidget {
  const FinancialNewsPage({super.key});

  @override
  _FinancialNewsPageState createState() => _FinancialNewsPageState();
}

class _FinancialNewsPageState extends State<FinancialNewsPage> {
  // Use the provided NewsAPI key
  final String apiKey = '0363abfe54f745d697b4283ae26f066b';
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?category=business&country=in&apiKey=0363abfe54f745d697b4283ae26f066b';

  List articles = [];

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          articles = jsonData['articles'];
        });
      }
    } catch (error) {
      print('Error fetching news: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial News'),
      ),
      body: articles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: article['urlToImage'] != null
                        ? Image.network(
                            article['urlToImage'],
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : Container(width: 100, color: Colors.grey),
                    title: Text(article['title'] ?? 'No Title'),
                    subtitle: Text(article['description'] ?? 'No Description'),
                    onTap: () => _launchURL(article['url']),
                  ),
                );
              },
            ),
    );
  }

  void _launchURL(String? url) async {
    if (url != null && await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}