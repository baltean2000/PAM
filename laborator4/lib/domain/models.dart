class Barbershop {
  final String name;
  final String locationWithDistance;
  final String image;
  final double reviewRate;

  Barbershop({
    required this.name,
    required this.locationWithDistance,
    required this.image,
    required this.reviewRate,
  });

  factory Barbershop.fromJson(Map<String, dynamic> json) {
    return Barbershop(
      name: json['name'] ?? '',
      locationWithDistance: json['location_with_distance'] ?? '',
      image: json['image'] ?? '',
      reviewRate: (json['review_rate'] ?? 0).toDouble(),
    );
  }
}

class AdBanner {
  final String image;
  final String buttonTitle;

  AdBanner({
    required this.image,
    required this.buttonTitle,
  });

  factory AdBanner.fromJson(Map<String, dynamic> json) {
    return AdBanner(
      image: json['image'] ?? '',
      buttonTitle: json['button_title'] ?? '',
    );
  }
}
