// screens/fund_recommendation_screen.dart
import 'package:flutter/material.dart';

class FundRecommendationScreen extends StatefulWidget {
  const FundRecommendationScreen({super.key});

  @override
  _FundRecommendationScreenState createState() => _FundRecommendationScreenState();
}

class _FundRecommendationScreenState extends State<FundRecommendationScreen> {
  String _riskTolerance = 'Medium';
  String _investmentHorizon = '1-3 Years';

  // Example recommendation logic
  String getFundRecommendation() {
    if (_riskTolerance == 'High' && _investmentHorizon == '5+ Years') {
      return 'Recommended Fund: Aggressive Growth Mutual Fund';
    } else if (_riskTolerance == 'Low' && _investmentHorizon == 'Less than 1 Year') {
      return 'Recommended Fund: Short-term Bond Fund';
    }
    return 'Recommended Fund: Balanced Fund';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fund Recommendation')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select your risk tolerance:'),
            DropdownButton<String>(
              value: _riskTolerance,
              onChanged: (String? newValue) {
                setState(() {
                  _riskTolerance = newValue!;
                });
              },
              items: <String>['Low', 'Medium', 'High'].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text('Select your investment horizon:'),
            DropdownButton<String>(
              value: _investmentHorizon,
              onChanged: (String? newValue) {
                setState(() {
                  _investmentHorizon = newValue!;
                });
              },
              items: <String>['Less than 1 Year', '1-3 Years', '3-5 Years', '5+ Years']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(getFundRecommendation()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Get Recommendation'),
            ),
          ],
        ),
      ),
    );
  }
}
