import 'package:flutter/material.dart';
import 'package:mf_app/screens/sipcal.dart';
import 'fund_selection_screen.dart';
import 'quiz_screen.dart';
import 'edu_contnt.dart'; // Import the educational content screen
import '../models/fund_model.dart'; // Import the Fund model
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Fund> selectedFunds = [];
  double walletBalance = 500000.00;

  @override
  void initState() {
    super.initState();
    updatePortfolio();
  }

  void updatePortfolio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    DateTime lastUpdated = DateTime.parse(prefs.getString('lastUpdated') ?? DateTime.now().toString());

    if (DateTime.now().difference(lastUpdated).inHours > 24) {
      for (Fund fund in selectedFunds) {
        var latestNAV = await fetchLatestNAV(fund.tickerSymbol);
        if (latestNAV != null) {
          fund.updateCurrentValue(latestNAV);
        }
      }
      await prefs.setString('lastUpdated', DateTime.now().toString());
    } else {
      print('Using cached NAV data.');
    }

    setState(() {});
  }

  Future<double?> fetchLatestNAV(String fundTicker) async {
    try {
      final response = await http.get(Uri.parse('http://51.20.127.176:8888/get_fund_data?ticker=$fundTicker'));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['latest_nav'];
      } else {
        throw Exception('Failed to load NAV');
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Fund App'),
        backgroundColor: Colors.green,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Wallet Balance',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  '₹${walletBalance.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Heading Text
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Welcome to Your Mutual Fund App',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            // Grid of Navigation Buttons
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: <Widget>[
                  _buildNavigationButton(
                    title: 'Select Funds',
                    icon: Icons.account_balance_wallet,
                    onPressed: () async {
                      final List<Fund>? result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FundSelectionScreen()),
                      );
                      if (result != null) {
                        setState(() {
                          selectedFunds.addAll(result);
                          updatePortfolio();
                        });
                      }
                    },
                  ),
                  _buildNavigationButton(
                    title: 'Take Quiz',
                    icon: Icons.quiz,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const QuizScreen()),
                      );
                    },
                  ),
                  _buildNavigationButton(
                    title: 'Learn About Mutual Funds',
                    icon: Icons.school,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MutualFundEducationApp()),
                      );
                    },
                  ),
                  _buildNavigationButton(
                    title: 'Calculate SIP',
                    icon: Icons.calculate,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MutualFundCalculatorApp()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavigationButton({required String title, required IconData icon, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
