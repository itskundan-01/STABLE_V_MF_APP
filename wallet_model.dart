class Wallet {
  double balance;

  Wallet({this.balance = 0.0});

  void addFunds(double amount) {
    if (amount < 0) {
      throw Exception('Amount cannot be negative');
    }
    balance += amount;
  }

  void withdrawFunds(double amount) {
    if (amount < 0) {
      throw Exception('Amount cannot be negative');
    }
    if (amount > balance) {
      throw Exception('Insufficient funds in wallet');
    }
    balance -= amount;
  }
}
