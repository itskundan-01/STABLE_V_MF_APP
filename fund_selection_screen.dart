import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'fund_details_screen.dart'; // Import the FundDetailsScreen

class FundSelectionScreen extends StatefulWidget {
  const FundSelectionScreen({super.key});

  @override
  _FundSelectionScreenState createState() => _FundSelectionScreenState();
}

class _FundSelectionScreenState extends State<FundSelectionScreen> {
  // Categories and mutual fund details with Yahoo Finance ticker
  final Map<String, List<Map<String, String>>> categories = {
    'Equity Funds': [
      {"name": "Mirae Asset Large Cap Fund", "ticker": "0P0000ON3O.BO"},
      {"name": "Axis Bluechip Fund", "ticker": "0P0000XVU7.BO"},
      {"name": "SBI Large Cap Fund", "ticker": "0P0000XW1B.BO"},
      {"name": "JM Arbitrage Fund", "ticker": "0P0001BAQT.BO"},
      {"name": "Kotak Equity Fund", "ticker": "0P0000KV36.BO"},
    ],
    'Index Funds': [
      {"name": "Motilal Oswal Nifty 50 Index Fund", "ticker": "0P0001IAU9.BO"},
      {"name": "UTI Nifty Index Fund", "ticker": "0P0001BBJ7.BO"},
      {"name": "Axis Nifty Index Fund", "ticker": "0P0001NS9G.BO"},
      {"name": "SBI Index Fund", "ticker": "0P0001TPX0.BO"},
      {"name": "ICICI Nifty Index Fund", "ticker": "0P00005UN0.BO"},
    ],
    'Mid Cap Funds': [
      {"name": "Motilal Oswal Mid Cap Fund", "ticker": "0P0001BAYV.BO"},
      {"name": "Quant Mid Cap Fund", "ticker": "0P0001BA3T.BO"},
      {"name": "HDFC Mid Cap Fund", "ticker": "0P0001BA8J.BO"},
      {"name": "SBI Mid Cap Fund", "ticker": "0P0000XVKO.BO"},
      {"name": "Axis Mid Cap Fund", "ticker": "0P0000XVUH.BO"},
    ],
    'Small Cap Funds': [
      {"name": "Nippon Small Cap Fund", "ticker": "0P0000PTGR.BO"},
      {"name": "Tata Small Cap Fund", "ticker": "0P0001EUZZ.BO"},
      {"name": "HDFC Small Cap Fund", "ticker": "0P0000XVAA.BO"},
      {"name": "ICICI Small Cap Fund", "ticker": "0P0001NJAZ.BO"},
      {"name": "Aditya Birla Small Cap Fund", "ticker": "0P00009J37.BO"},
    ],
    'Large Cap Funds': [
      {"name": "Mirae Large Cap Fund", "ticker": "0P0000XVA1.BO"},
      {"name": "Axis Large Cap Fund", "ticker": "0P0000XVTK.BO"},
      {"name": "ICICI Large Cap Fund", "ticker": "0P0001BAD3.BO"},
      {"name": "Nippon Large Cap Fund", "ticker": "0P0001BB5S.BO"},
      {"name": "Franklin Large Cap Fund", "ticker": "0P0000XW56.BO"},
    ],
  };

  // Function to fetch fund data from the API
  Future<Map<String, dynamic>> fetchFundData(String fundCode) async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://51.20.127.176:8888/get_fund_data?ticker=$fundCode'), // Use fundCode here
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load mutual fund data');
      }
    } catch (e) {
      print('Error fetching fund data: $e');
      throw Exception('Failed to load mutual fund data');
    }
  }

  // Function to show funds in a dialog based on the selected category
  void _showFundsDialog(String category, List<Map<String, String>> funds) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$category Funds'),
          content: SingleChildScrollView(
            child: ListBody(
              children: funds.map((fund) {
                return ListTile(
                  title: Text(fund['name']!),
                  onTap: () {
                    Navigator.of(context).pop(); // Close the dialog
                    // Navigate to FundDetailsScreen with selected fund code
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FundDetailsScreen(
                          ticker: fund['ticker']!,
                          fundName: '',
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Fund Categories'),
      ),
      body: ListView(
        children: categories.keys.map((category) {
          return ListTile(
            title: Text(category),
            onTap: () {
              // Show the funds under the selected category
              _showFundsDialog(category, categories[category]!);
            },
          );
        }).toList(),
      ),
    );
  }
}
