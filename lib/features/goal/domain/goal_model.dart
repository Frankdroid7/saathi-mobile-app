class GoalModel {
  String? id;
  String name;
  String imgUrl;
  double amount;
  int duration;
  String? state;
  String description;
  double? durationAmount;
  String durationType;
  bool isActive;
  String? createdAt;

  GoalModel({
    this.id,
    required this.isActive,
    this.createdAt,
    required this.name,
    required this.imgUrl,
    required this.amount,
    required this.duration,
    required this.description,
    required this.durationType,
    this.durationAmount,
  });

  factory GoalModel.empty() {
    return GoalModel(
        name: '',
        imgUrl: '',
        amount: 0,
        duration: 0,
        description: '',
        durationType: '',
        createdAt: '',
        isActive: false,
        durationAmount: 0);
  }

  factory GoalModel.fromJson(Map<String, dynamic> json) {
    return GoalModel(
      id: json['goal_id'],
      name: json['name'],
      isActive: json['active'],
      amount: json['amount'].toDouble(),
      imgUrl: json['img_url'],
      duration: json['duration'],
      description: json['description'],
      createdAt: json['created_at'],
      durationType: json['duration_type'],
      durationAmount: json['duration_amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        "goal_id": id,
        "active": true,
        "created_at": DateTime.now().toString(),
        "duration_type": durationType,
        "duration_amount": durationAmount,
        "amount": amount,
        "img_url": imgUrl,
        "description": description,
        "duration": duration,
        "name": name,
      };
}
