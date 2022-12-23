class SavingsModel {
  double amount;
  String goalId;

  SavingsModel({required this.amount, required this.goalId});

  factory SavingsModel.fromJson(Map<String, dynamic> json) {
    return SavingsModel(amount: json['amount'], goalId: json['goal_id']);
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
      };
}
