class Fund {
  String fundName;
  double investedAmount;
  double currentValue;
  double nav; // Current NAV
  double navOnInvestment; // NAV on the day of investment
  double navOnWithdrawal; // NAV on the day of withdrawal

  Fund({
    required this.fundName,
    required this.investedAmount,
    required this.currentValue,
    required this.nav,
  })  : navOnInvestment = nav,
        navOnWithdrawal = 0.0; // Initialize to zero

  String get tickerSymbol => fundName; // Assuming fundName is used as the ticker symbol

  void invest(double amount) {
    investedAmount += amount;
    navOnInvestment = nav; // Store NAV on investment
    currentValue += amount; // Simply adding amount for simplicity; adjust as needed
  }

  void withdraw(double amount) {
    if (amount <= investedAmount) {
      investedAmount -= amount;
      navOnWithdrawal = nav; // Store NAV on withdrawal
      currentValue -= amount; // Adjust current value; might need adjustment based on NAV logic
    } else {
      throw Exception('Insufficient funds to withdraw');
    }
  }

  String getRiskLevelString() {
    // Implement your risk level logic
    return "Medium"; // Example placeholder
  }

  void updateCurrentValue(double latestNAV) {
    // Update the current value based on the latest NAV
    nav = latestNAV; // Update NAV
    // Adjust current value based on the invested amount and latest NAV
    currentValue = investedAmount * (nav / navOnInvestment);
  }
}
