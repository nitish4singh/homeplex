class TankerModel {
  final String url;
  final String vehicalname;
  final String uid;
  final String capacity;
  final String driverphoneno;
  final String post;
  final int kmprice;
  final String targetarea;
  final String licienceno;
  final String drivername;
  final String id;

  TankerModel({
    required this.driverphoneno,
    required this.url,
    required this.vehicalname,
    required this.uid,
    required this.capacity,
    required this.post,
    required this.kmprice,
    required this.drivername,
    required this.licienceno,
    required this.targetarea,
    required this.id,
  });

  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'vehicalname': vehicalname,
      'uid': uid,
      'capacity': capacity,
      'driverphoneno': driverphoneno,
      'post': post,
      'kmprice': kmprice,
      'targetarea': targetarea,
      'drivername': drivername,
      'licienceno': licienceno,
      "id": id,
    };
  }

  factory TankerModel.getModelFromJson({required Map<String, dynamic> json}) {
    return TankerModel(
        driverphoneno: json["driverphoneno"],
        url: json["url"],
        uid: json["uid"],
        capacity: json["capacity"],
        vehicalname: json['vehicalname'],
        post: json['post'],
        kmprice: json['kmprice'],
        targetarea: json['targetarea'],
        licienceno: json['licienceno'],
        drivername: json['drivername'],
        id: json['id']);
  }
}
