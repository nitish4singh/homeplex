class UserModel {
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? role;
  String? payment;
  UserModel({this.uid, this.role,this.payment, this.email, this.name, this.phone});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      role: map['role'],
      payment:map['payment'],

    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'role': role,
      'payment':payment,
    };
  }
}
