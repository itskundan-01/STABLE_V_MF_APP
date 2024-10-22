import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FundDetailsScreen extends StatefulWidget {
  final String ticker;

  const FundDetailsScreen({super.key, required this.ticker, required String fundName});

  @override
  _FundDetailsScreenState createState() => _FundDetailsScreenState();
}

class _FundDetailsScreenState extends State<FundDetailsScreen> {
  Map<String, dynamic>? fundData;
  bool isLoading = true;
  String fundName = '';
  String selectedDuration = "6M";

  // Mapping of tickers to scheme codes
  final Map<String, String> schemeCodes = {
    '0P0000ON3O.BO': '112932', // Mirae
    '0P0000XVU7.BO': '120503', // Axis
    // Add other mappings as needed
    '0P0000XW1B.BO': '125497', // SBI
   '0P0001BAQT.BO': '120481', // JM Arbitrage
   '0P0000KV36.BO': '112090', // Kotak
   // Add other mappings as needed
   // Index Funds
   '0P0001IAU9.BO': '147622',
   '0P0001BBJ7.BO': '100823',
   '0P0001NS9G.BO': '149373',
   '0P0001TPX0.BO': '152908',
   '0P00005UN0.BO': '101349',
   // Mid Cap Funds
   '0P0001BAYV.BO': '127039',
   '0P0001BA3T.BO': '101065',
   '0P0001BA8J.BO': '105758',
   '0P0000XVKO.BO': '119716',
   '0P0000XVUH.BO': '120505',
   // Small Cap Funds
   '0P0000PTGR.BO': '113178',
   '0P0001EUZZ.BO': '145206',
   '0P0000XVAA.BO': '130503',
   '0P0001NJAZ.BO': '149283',
   '0P00009J37.BO': '105805',
   // Large Cap Funds
   '0P0000XVA1.BO': '118826',
   '0P0000XVTK.BO': '120466',
   '0P0001BAD3.BO': '120585',
   '0P0001BB5S.BO': '106236',
   '0P0000XW56.BO': '118462',

  };

  @override
  void initState() {
    super.initState();
    fetchFundData();
  }

  Future<void> fetchFundData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://51.20.127.176:8888/get_fund_data?ticker=${widget.ticker}'),
      );
      if (response.statusCode == 200) {
        setState(() {
          fundData = json.decode(response.body);
          isLoading = false;
        });
        await fetchFundName(); // Fetch fund name after loading fund data
      } else {
        throw Exception('Failed to load fund data');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchFundName() async {
    final schemeCode = schemeCodes[widget.ticker];
    if (schemeCode == null) {
      setState(() {
        fundName = "Fund Name Not Found";
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('https://api.mfapi.in/mf/$schemeCode'), 
      );
      if (response.statusCode == 200) {
        final fundInfo = json.decode(response.body);
        setState(() {
          fundName = fundInfo['meta']['scheme_name'] ?? 'Name not available';
        });
      } else {
        throw Exception('Failed to load fund name');
      }
    } catch (e) {
      print(e);
      setState(() {
        fundName = "Error fetching fund name";
      });
    }
  }

  Widget _buildNavImage() {
    final schemeCode = schemeCodes[widget.ticker];
    if (schemeCode == null) {
      return const Text("Scheme code not found.");
    }

    final durationMapping = {
      "7D": 1,
      "1M": 2,
      "3M": 3,
      "6M": 4,
      "1Y": 5,
      "5Y": 6,
      "ALL": 7,
    };
    final option = durationMapping[selectedDuration];

    if (option == null) {
      return const Text("Invalid duration.");
    }

    final String imageUrl =
        'http://51.20.127.176:8888/get_nav_chart/$schemeCode/$option';

    return FutureBuilder<Image>(
      future: _loadImage(imageUrl),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Text("Failed to load graph");
        } else {
          return snapshot.data!;
        }
      },
    );
  }

  Future<Image> _loadImage(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Image.memory(response.bodyBytes);
    } else {
      throw Exception('Failed to load image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fund Details'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : fundData == null
              ? const Center(child: Text('Failed to load fund data'))
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          fundName.isNotEmpty
                              ? fundName
                              : 'Loading Fund Name...',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DropdownButton<String>(
                              value: selectedDuration,
                              items: const [
                                DropdownMenuItem(value: "7D", child: Text("7D")),
                                DropdownMenuItem(value: "1M", child: Text("1M")),
                                DropdownMenuItem(value: "3M", child: Text("3M")),
                                DropdownMenuItem(value: "6M", child: Text("6M")),
                                DropdownMenuItem(value: "1Y", child: Text("1Y")),
                                DropdownMenuItem(value: "5Y", child: Text("5Y")),
                                DropdownMenuItem(value: "ALL", child: Text("ALL")),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  selectedDuration = value!;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 300,
                        padding: const EdgeInsets.all(16.0),
                        child: _buildNavImage(),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Latest NAV: ₹${fundData!['latest_nav']}',
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Top 10 Holdings',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...List.generate(
                        fundData!['holdings'].length > 10
                            ? 10
                            : fundData!['holdings'].length,
                        (index) {
                          final holding = fundData!['holdings'][index];
                          return ListTile(
                            title: Text(holding['company']),
                            subtitle: Text(
                                'Symbol: ${holding['symbol']}, % Assets: ${holding['percent_assets']}'),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Sector Weightings',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...List.generate(
                        fundData!['sectors'].length,
                        (index) {
                          final sector = fundData!['sectors'][index];
                          return ListTile(
                            title: Text(sector['sector_name']),
                            subtitle: Text('Weight: ${sector['percent']}'),
                          );
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Portfolio Composition',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...List.generate(
                        fundData!['composition'].length,
                        (index) {
                          final composition = fundData!['composition'][index];
                          return ListTile(
                            title: Text(composition['asset_class']),
                            subtitle: Text('Weight: ${composition['percent']}'),
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _showInvestmentDialog(context, 'Buy');
                              },
                              child: const Text('Buy'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _showInvestmentDialog(context, 'Sell');
                              },
                              child: const Text('Sell'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  void _showInvestmentDialog(BuildContext context, String action) {
    final TextEditingController amountController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$action Fund'),
          content: TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Enter amount (₹)'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                double amount = double.tryParse(amountController.text) ?? 0.0;
                if (amount > 0) {
                  // Perform the buy/sell action here
                  Navigator.of(context).pop(); // Close the dialog
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid amount')),
                  );
                }
              },
              child: Text(action),
            ),
          ],
        );
      },
    );
  }
}
