class Expense {
  final int expenseid;
  final String expensename;
  final String date;
  final String type;
  final String amount;
  final double price;

  Expense({
    required this.expenseid,
    required this.expensename,
    required this.date,
    required this.type,
    required this.amount,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'ExpenseID': expenseid,
      'Expense Name': expensename,
      'Date': date,
      'Type': type,
      'Amount': amount,
      'Price': price,
    };
  }

  String toString() {
    return 'Expense{ExpenseID: $expenseid, Expense Name: $expensename, Date: $date, Type: $type, Amount: $amount, Price: $price}';
  }
}
