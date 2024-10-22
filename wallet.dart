import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Wallet {
  double balance;
  Map<String, dynamic> investments; // key: Fund Code, value: investment details

  Wallet({required this.balance, required this.investments});

  // Save wallet data to local storage (SharedPreferences for now)
  Future<void> saveWalletData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('balance', balance);
    prefs.setString('investments', investments.toString());
  }

  // Fetch wallet data
  Future<void> loadWalletData() async {
    final prefs = await SharedPreferences.getInstance();
    balance = prefs.getDouble('balance') ?? 500000.0; // Default balance: 5 lakhs
    final investmentsString = prefs.getString('investments') ?? '{}';
    investments = _decodeInvestments(investmentsString);
  }

  Map<String, dynamic> _decodeInvestments(String investmentsString) {
    // Convert the investments string to a Map (use JSON or other method)
    return {};
  }
}

class WalletScreen extends StatelessWidget {
  final Wallet userWallet = Wallet(balance: 500000.0, investments: {});

  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Wallet"),
      ),
      body: FutureBuilder(
        future: userWallet.loadWalletData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                Text("Balance: ₹${userWallet.balance}"),
                // Display investments
                Expanded(
                  child: ListView.builder(
                    itemCount: userWallet.investments.length,
                    itemBuilder: (context, index) {
                      final investment = userWallet.investments.values.toList()[index];
                      return ListTile(
                        title: Text("Fund: ${investment['fundName']}"),
                        subtitle: Text("Invested Amount: ₹${investment['amount']}"),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}