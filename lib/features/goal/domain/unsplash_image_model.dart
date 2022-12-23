class UnsplashImageModel {
  String id;
  String imageUrl;

  UnsplashImageModel({required this.imageUrl, required this.id});

  factory UnsplashImageModel.fromJson(Map<String, dynamic> json) {
    return UnsplashImageModel(
        imageUrl: json['urls']['regular'], id: json['id']);
  }
}
