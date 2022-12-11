class UserDetailsModel {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String id;
  final String profilePic;
  UserDetailsModel(
      {required this.name,
      required this.phone,
      required this.email,
      required this.id,
      required this.profilePic,
      required this.address});

  Map<String, dynamic> getJson() =>
      {'name': name,'id':id, 'address': address, 'email': email, 'phone': phone,
      'profilePic':profilePic,};

  factory UserDetailsModel.getModelFromJson(Map<String, dynamic> json) {
    return UserDetailsModel(
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        id: json["id"],
        profilePic:json["profilePic"],
        address: json["address"]);
  }
}
