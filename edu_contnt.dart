import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MutualFundEducationApp());
}

class MutualFundEducationApp extends StatelessWidget {
  const MutualFundEducationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutual Fund Education',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MutualFundEducationPage(),
    );
  }
}

class MutualFundEducationPage extends StatefulWidget {
  const MutualFundEducationPage({super.key});

  @override
  _MutualFundEducationPageState createState() => _MutualFundEducationPageState();
}

class _MutualFundEducationPageState extends State<MutualFundEducationPage> {
  // Example YouTube video IDs
  final String videoId1 = 'aVs2CXheuPs'; // What is a Mutual Fund?
  final String videoId2 = 'ljgXxG4NWGM'; // How Mutual Funds work in India?
  final String videoId3 = '6sq2o1atWLY'; // New Video 1
  final String videoId4 = 'BF6Lc9CZJWg'; // New Video 2

  late YoutubePlayerController _controller1;
  late YoutubePlayerController _controller2;
  late YoutubePlayerController _controller3;
  late YoutubePlayerController _controller4;

  @override
  void initState() {
    super.initState();
    _controller1 = YoutubePlayerController(
      initialVideoId: videoId1,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _controller2 = YoutubePlayerController(
      initialVideoId: videoId2,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _controller3 = YoutubePlayerController(
      initialVideoId: videoId3,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    _controller4 = YoutubePlayerController(
      initialVideoId: videoId4,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Fund Education'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Introduction Section
            const Text(
              'What is a Mutual Fund?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'A mutual fund is a type of financial vehicle made up of a pool of money collected from many investors to invest in securities like stocks, bonds, money market instruments, and other assets. Mutual funds are operated by professional money managers, who allocate the fund\'s assets and attempt to produce capital gains or income for the fund\'s investors.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // How to Invest Section
            const Text(
              'How to Invest in Mutual Funds?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'To invest in mutual funds in India, you can follow these steps:\n'
                  '1. Identify your investment goal.\n'
                  '2. Choose a mutual fund that aligns with your goals.\n'
                  '3. Select between growth or dividend options.\n'
                  '4. Register with a mutual fund distributor or online platform.\n'
                  '5. Complete your KYC process.\n'
                  '6. Begin your investment with either a lump sum or SIP (Systematic Investment Plan).',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // How Mutual Funds Work in India Section
            const Text(
              'How Mutual Funds Work in India?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mutual funds in India work by collecting money from several investors and investing them in a diversified portfolio of stocks, bonds, and other securities. Professional fund managers handle the investments and strive to generate returns. SEBI (Securities and Exchange Board of India) regulates mutual funds to ensure transparency and protect investor interests.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // Video Section
            const Text(
              'Videos on Mutual Funds',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            YoutubePlayer(
              controller: _controller1,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player 1 is ready.');
              },
            ),
            const SizedBox(height: 16),

            YoutubePlayer(
              controller: _controller2,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player 2 is ready.');
              },
            ),
            const SizedBox(height: 16),

            YoutubePlayer(
              controller: _controller3,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player 3 is ready.');
              },
            ),
            const SizedBox(height: 16),

            YoutubePlayer(
              controller: _controller4,
              showVideoProgressIndicator: true,
              onReady: () {
                print('Player 4 is ready.');
              },
            ),
            const SizedBox(height: 16),

            // Online Articles Section
            const Text(
              'Read More About Mutual Funds',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                const url = 'https://www.moneycontrol.com/mutualfundindia/';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text(
                '1. Mutual Funds - Moneycontrol',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                const url = 'https://www.etmoney.com/mutual-funds';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text(
                '2. Mutual Funds - ET Money',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                const url = 'https://groww.in/mutual-funds';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: const Text(
                '3. Mutual Funds - Groww',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}