class SavingsModel {
  double amount;
  String goalId;
  double durationAmount;

  SavingsModel(
      {required this.amount,
      required this.durationAmount,
      required this.goalId});

  factory SavingsModel.fromJson(Map<String, dynamic> json) {
    return SavingsModel(
      amount: json['amount'],
      goalId: json['goal_id'],
      durationAmount: json['duration_amount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'amount': amount,
        'duration_amount': durationAmount,
      };
}
