class WaterTankeruploadmodel {
  final String capacity;
  final int kmprice;
  final String post;
  final String uid;
  final String vehicalname;
   final String id;
    final String url;
  final String drivername;
  final String licienceno;
   final String driverphoneno;
  final String targetarea;


  WaterTankeruploadmodel({
    required this.uid,
    required this.capacity,
    required this.kmprice,
    required this.post,
    required this.vehicalname,
    required this.driverphoneno,
    required this.id,
    required this.licienceno,
    required this.url,
    required this.drivername,
    required this.targetarea,
  });
  Map<String, dynamic> getJson() {
    return {
      'capacity': capacity,
      'kmprice': kmprice,
      'post': post,
      'uid': uid,
      'vehicalname': vehicalname,
      'driverphoneno': driverphoneno,
      'id': id,
      'licienceno': licienceno,
      'url': url,
       'drivername':drivername,
       'targetarea':targetarea,
    };
  }
  factory WaterTankeruploadmodel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return WaterTankeruploadmodel(
        uid: json["uid"],
        capacity: json["capacity"],
        kmprice: json["kmprice"],
        licienceno: json["licienceno"],
        post: json["post"],
        driverphoneno: json['driverphoneno'],
        vehicalname: json['vehicalname'],
        url: json['url'],
        drivername: json['drivername'],
        targetarea:json['targetarea'],
        id: json['id']);
  }
}
