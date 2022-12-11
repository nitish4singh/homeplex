class ManpowerModel {
  String? uid;
  String? email;
  String? name;
  String? phone;
  String? pid;
  ManpowerModel({this.uid,this.pid, this.email, this.name, this.phone});
  // receiving data from server
  factory ManpowerModel.fromMap(map) {
    return ManpowerModel(
      uid: map['uid'],
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
           pid: map['pid'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'phone': phone,
      'pid': pid,
    };
  }
}
