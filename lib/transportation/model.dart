class TransportModel {
  final String url;
  final String vehicalname;
  final String uid;
  final String capacity;
  final String vehicaltype;
  final String vehicalsize;
  final String driverphoneno;
  final String post;
  final int kmprice;
  final int mprice;
  final String labourfacility;
  final String targetarea;
  final String licienceno;
  final String drivername;
  final String id;
   final String labourcharge;

  TransportModel({
    required this.driverphoneno,
    required this.url,
    required this.vehicalname,
    required this.uid,
    required this.capacity,
    required this.vehicalsize,
    required this.vehicaltype,
    required this.post,
    required this.kmprice,
    required this.mprice,
    required this.drivername,
    required this.labourfacility,
    required this.licienceno,
    required this.labourcharge,
    required this.targetarea,
    required this.id,
  });

  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'vehicalname': vehicalname,
      'uid': uid,
      'capacity': capacity,
      'vehicalsize': vehicalsize,
      'vehicaltype': vehicaltype,
      'driverphoneno': driverphoneno,
      'post': post,
      'mprice': mprice,
      'kmprice': kmprice,
      'targetarea': targetarea,
      'drivername': drivername,
      'licienceno': licienceno,
      'labourfacility': labourfacility,
      "id": id,
      'labourcharge':labourcharge
    };
  }

  factory TransportModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return TransportModel(
        driverphoneno: json["driverphoneno"],
        url: json["url"],
        uid: json["uid"],
        capacity: json["capacity"],
        vehicalsize: json["vehicalsize"],
        vehicalname: json['vehicalname'],
        vehicaltype: json["vehicaltype"],
        post: json['post'],
        kmprice: json['kmprice'],
        mprice: json['mprice'],
        labourfacility: json['labourfacility'],
        targetarea: json['targetarea'],
        licienceno: json['licienceno'],
        drivername: json['drivername'],
        labourcharge:json['labourcharge'],
        id: json['id']);
  }
}
