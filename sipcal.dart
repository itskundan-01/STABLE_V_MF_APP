import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MutualFundCalculatorApp());
}

class MutualFundCalculatorApp extends StatelessWidget {
  const MutualFundCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mutual Fund Return Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  const CalculatorHomePage({super.key});

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  final TextEditingController _sipAmountController = TextEditingController();
  final TextEditingController _lumpSumAmountController = TextEditingController();
  final TextEditingController _rateOfReturnController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double _sipFutureValue = 0;
  double _lumpSumFutureValue = 0;

  // SIP Future Value Calculation
  void calculateSIP() {
    double sipAmount = double.tryParse(_sipAmountController.text) ?? 0;
    double rateOfReturn = (double.tryParse(_rateOfReturnController.text) ?? 0) / 100;
    int years = int.tryParse(_yearsController.text) ?? 0;
    int months = years * 12;

    double monthlyRate = rateOfReturn / 12;

    _sipFutureValue = sipAmount *
        ((pow((1 + monthlyRate), months) - 1) / monthlyRate) * (1 + monthlyRate);

    setState(() {});
  }

  // Lump Sum Future Value Calculation
  void calculateLumpSum() {
    double lumpSumAmount = double.tryParse(_lumpSumAmountController.text) ?? 0;
    double rateOfReturn = (double.tryParse(_rateOfReturnController.text) ?? 0) / 100;
    int years = int.tryParse(_yearsController.text) ?? 0;

    _lumpSumFutureValue = lumpSumAmount * pow((1 + rateOfReturn), years);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Fund Return Calculator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'SIP Calculator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _sipAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monthly SIP Amount (₹)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateOfReturnController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Expected Annual Return (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _yearsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Investment Duration (Years)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateSIP,
              child: const Text('Calculate SIP Returns'),
            ),
            const SizedBox(height: 16),
            Text(
              'Future Value (SIP): ₹ ${_sipFutureValue.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 40),
            const Text(
              'Lump Sum Calculator',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _lumpSumAmountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Lump Sum Amount (₹)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateOfReturnController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Expected Annual Return (%)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _yearsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Investment Duration (Years)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateLumpSum,
              child: const Text('Calculate Lump Sum Returns'),
            ),
            const SizedBox(height: 16),
            Text(
              'Future Value (Lump Sum): ₹ ${_lumpSumFutureValue.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}