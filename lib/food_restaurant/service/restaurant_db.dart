class Restaurant {
  final int id;
  final String name;
  final String address;
  final String phoneNumber;
  final String imageUrl;
  final int visitorReviewCount;
  final double visitorRating;
  final int blogReviewCount;
  final int photoReviewCount;
  final String latitude;
  final String longitude;
  final String information;
  final String additionalExplanation;
  final String? homepageUrl;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.imageUrl,
    required this.visitorReviewCount,
    required this.visitorRating,
    required this.blogReviewCount,
    required this.photoReviewCount,
    required this.latitude,
    required this.longitude,
    required this.information,
    required this.additionalExplanation,
    this.homepageUrl,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      phoneNumber: json['phoneNumber'],
      imageUrl: json['imageUrl'],
      visitorReviewCount: json['visitorReviewCount'],
      visitorRating: json['visitorRating'].toDouble(),
      blogReviewCount: json['blogReviewCount'],
      photoReviewCount: json['photoReviewCount'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      information: json['information'],
      additionalExplanation: json['additionalExplanation'].replaceAll('\\n', '\n'),
      homepageUrl: json['homepageUrl'],
    );
  }
}