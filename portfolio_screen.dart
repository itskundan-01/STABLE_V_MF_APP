import 'package:flutter/material.dart';
import '../models/fund_model.dart';

class PortfolioScreen extends StatefulWidget {
  final List<Fund> selectedFunds;

  const PortfolioScreen({super.key, required this.selectedFunds, required wallet});

  @override
  _PortfolioScreenState createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  // Controller for input field
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double totalInvestment = widget.selectedFunds.fold(0.0, (sum, fund) => sum + fund.investedAmount);
    double totalReturns = widget.selectedFunds.fold(0.0, (sum, fund) => sum + (fund.currentValue - fund.investedAmount));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Portfolio'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Total Investment'),
            subtitle: Text('₹$totalInvestment'),
          ),
          ListTile(
            title: const Text('Total Returns'),
            subtitle: Text('₹$totalReturns'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.selectedFunds.length,
              itemBuilder: (context, index) {
                final fund = widget.selectedFunds[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(fund.fundName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('Invested: ₹${fund.investedAmount}'),
                        Text('Current Value: ₹${fund.currentValue}'),
                        Text('Risk Level: ${fund.getRiskLevelString()}'),

                        // Input field for amount
                        TextField(
                          controller: _amountController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(labelText: 'Enter amount'),
                        ),

                        // Investment Button
                        ElevatedButton(
                          onPressed: () {
                            double investAmount = double.tryParse(_amountController.text) ?? 0.0;
                            if (investAmount > 0) {
                              setState(() {
                                fund.invest(investAmount); // Call invest function
                              });
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invested ₹$investAmount in ${fund.fundName}')));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid amount')));
                            }
                          },
                          child: const Text("Invest"),
                        ),

                        // Withdrawal Button
                        ElevatedButton(
                          onPressed: () {
                            double withdrawAmount = double.tryParse(_amountController.text) ?? 0.0;
                            if (withdrawAmount > 0) {
                              try {
                                setState(() {
                                  fund.withdraw(withdrawAmount); // Call withdraw function
                                });
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Withdrew ₹$withdrawAmount from ${fund.fundName}')));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please enter a valid amount')));
                            }
                          },
                          child: const Text("Withdraw"),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}