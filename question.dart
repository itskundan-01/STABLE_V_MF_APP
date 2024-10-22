//lib/models/question.dart
import 'dart:math';

class Question {
  final String questionText;
  final List<String> options;
  final int correctOption;

  Question({required this.questionText, required this.options, required this.correctOption});
}

List<Question> easyQuestions = [
  Question(
    questionText: "What is a mutual fund?",
    options: ["A company", "A type of investment", "A loan", "A stock"],
    correctOption: 1,
  ),
  // ... (Add more easy questions here)

  // New easy questions:
  Question(
    questionText: "What is the primary goal of investing?",
    options: ["To lose money", "To make quick profits", "To grow wealth over time", "To avoid risk"],
    correctOption: 2,
  ),
  Question(
    questionText: "What is the difference between stocks and bonds?",
    options: ["Stocks represent ownership, bonds represent debt", "Stocks are riskier than bonds", "Bonds offer higher returns than stocks", "Stocks are issued by companies, bonds are issued by governments"],
    correctOption: 0,
  ),
  // ... (Add more easy questions here)
  Question(
    questionText: "What is the difference between saving and investing?",
    options: ["Saving is for short-term goals, investing is for long-term wealth growth", "Saving is riskier than investing", "Investing is always better than saving", "Saving and investing are the same thing"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the importance of creating a budget?",
    options: ["To track income and expenses", "To avoid debt", "To save money", "To make money"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the time value of money?",
    options: ["The concept that money has greater value today than in the future", "The idea that money grows over time", "The importance of saving for retirement", "The risk associated with investing"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the rule of 72?",
    options: ["A formula used to estimate the number of years required to double an investment", "A rule for setting financial goals", "A guideline for budgeting", "A tax rule"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is a mutual fund?",
    options: ["A type of investment that pools money from many investors", "A company that invests in stocks and bonds", "A savings account", "A loan"],
    correctOption: 0,
  ),
];

List<Question> mediumQuestions = [
  Question(
    questionText: "What is NAV in mutual funds?",
    options: ["Net Asset Value", "Net Available Value", "Net Acquisition Value", "Net Average Value"],
    correctOption: 0,
  ),
  // ... (Add more medium questions here)
  Question(
    questionText: "What is the difference between a fixed-income investment and an equity investment?",
    options: ["Fixed-income investments provide regular income, equity investments offer potential for capital appreciation", "Fixed-income investments are riskier than equity investments", "Equity investments are always better than fixed-income investments", "Fixed-income investments are only for retirement"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the importance of emergency savings?",
    options: ["To cover unexpected expenses", "To invest for retirement", "To pay off debt", "To save for a vacation"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the difference between a Roth IRA and a traditional IRA?",
    options: ["Roth IRA contributions are made with after-tax money, traditional IRA contributions are made with pre-tax money", "Roth IRA is only for retirement savings", "Traditional IRA is better for tax deductions", "There is no difference between Roth IRA and traditional IRA"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the importance of credit score?",
    options: ["It affects interest rates on loans and credit cards", "It determines your income", "It is only relevant for buying a house", "It is not important for financial health"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the difference between a stock and a bond?",
    options: ["Stocks represent ownership, bonds represent debt", "Stocks are riskier than bonds", "Bonds offer higher returns than stocks", "Stocks are issued by companies, bonds are issued by governments"],
    correctOption: 0,
  ),
  // New medium questions:
  Question(
    questionText: "What is diversification in investing?",
    options: ["Investing in a single asset class", "Investing in a variety of assets", "Investing in high-risk investments", "Investing in low-risk investments"],
    correctOption: 1,
  ),
  Question(
    questionText: "What is the role of a financial advisor?",
    options: ["To provide investment advice", "To manage your finances", "To sell you investment products", "To help you file your taxes"],
    correctOption: 0,
  ),
  // ... (Add more new medium questions here)
];

List<Question> hardQuestions = [
  Question(
    questionText: "What is an ELSS fund?",
    options: ["Equity Linked Savings Scheme", "Equity Linked Savings Stock", "Equity Lease Savings Stock", "Equity Line Savings Scheme"],
    correctOption: 0,
  ),
  // ... (Add more hard questions here)
  // ... (Add more hard questions here)
  Question(
    questionText: "What is the difference between a bull market and a bear market?",
    options: ["A bull market is characterized by rising prices, a bear market by falling prices", "A bull market is a long-term trend, a bear market is a short-term trend", "A bull market is good for investors, a bear market is bad for investors", "A bull market is caused by economic growth, a bear market is caused by economic recession"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the concept of compound interest?",
    options: ["Interest earned on both the principal and previous interest", "Interest earned only on the principal", "Interest earned at a fixed rate", "Interest earned at a variable rate"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the difference between a stock and a bond?",
    options: ["Stocks represent ownership, bonds represent debt", "Stocks are riskier than bonds", "Bonds offer higher returns than stocks", "Stocks are issued by companies, bonds are issued by governments"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the role of a financial advisor?",
    options: ["To provide investment advice", "To manage your finances", "To sell you investment products", "To help you file your taxes"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the time value of money?",
    options: ["The concept that money has greater value today than in the future", "The idea that money grows over time", "The importance of saving for retirement", "The risk associated with investing"],
    correctOption: 0,
  ),
  // New hard questions:
  Question(
    questionText: "What is the difference between a bull market and a bear market?",
    options: ["A bull market is characterized by rising prices, a bear market by falling prices", "A bull market is a long-term trend, a bear market is a short-term trend", "A bull market is good for investors, a bear market is bad for investors", "A bull market is caused by economic growth, a bear market is caused by economic recession"],
    correctOption: 0,
  ),
  Question(
    questionText: "What is the concept of compound interest?",
    options: ["Interest earned on both the principal and previous interest", "Interest earned only on the principal", "Interest earned at a fixed rate", "Interest earned at a variable rate"],
    correctOption: 0,
  ),
  // ... (Add more new hard questions here)
];

// Function to shuffle the questions randomly
List<Question> shuffleQuestions(List<Question> questions) {
  Random random = Random();
  questions.shuffle(random);
  return questions;
}