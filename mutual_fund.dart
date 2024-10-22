class MutualFund {
  final String name;
  final String category; // e.g., Equity, Debt, etc.
  final double currentValue; // Current value per unit
  double unitsPurchased; // Number of units purchased

  MutualFund({
    required this.name,
    required this.category,
    required this.currentValue,
    this.unitsPurchased = 0,
  });

  double get investmentValue => unitsPurchased * currentValue; // Total value of the investment
}
