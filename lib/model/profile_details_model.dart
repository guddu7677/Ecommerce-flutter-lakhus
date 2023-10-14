class ProfileDetailsModel {
  int id;
  String phone;
  String? fname;
  String? image;
  String? city;
  String? state;
  bool verified;
  String? whatsapp;
  bool isVerified;

  ProfileDetailsModel({
    required this.id,
    required this.phone,
    this.fname,
    this.image,
    this.city,
    this.state,
    required this.verified,
    this.whatsapp,
    required this.isVerified,
  });

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsModel(
      id: json['id'] as int,
      phone: json['phone'] as String,
      fname: json['fname'] as String?,
      image: json['image'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      verified: json['verified'] as bool,
      whatsapp: json['whatsapp'] as String?,
      isVerified: json['is_verified'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'phone': phone,
      'fname': fname,
      'image': image,
      'city': city,
      'state': state,
      'verified': verified,
      'whatsapp': whatsapp,
      'is_verified': isVerified,
    };
  }
}
