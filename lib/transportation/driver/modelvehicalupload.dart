class Vehicaluploadmodel {
  final String capacity;
  final int kmprice;
  final int mprice;
  final String post;
  final String uid;
  final String vehicalname;
   final String id;
    final String url;
  final String labourfacility;
    final String vehicalsize;
  final String vehicaltype;
  final String drivername;
  final String licienceno;
   final String driverphoneno;
  final String targetarea;
    final String labourcharge;


  Vehicaluploadmodel({
    required this.uid,
    required this.capacity,
    required this.kmprice,
    required this.post,
    required this.mprice,
    required this.vehicalname,
    required this.driverphoneno,
    required this.id,
    required this.licienceno,
    required this.url,
    required this.labourfacility,
    required this.vehicalsize,
    required this.vehicaltype,
    required this.drivername,
    required this.targetarea,
    required this.labourcharge,
  });
  Map<String, dynamic> getJson() {
    return {
      'capacity': capacity,
      'kmprice': kmprice,
      'post': post,
      'mprice': mprice,
      'uid': uid,
      'vehicalname': vehicalname,
      'driverphoneno': driverphoneno,
      'id': id,
      'licienceno': licienceno,
      'labourfacility': labourfacility,
      'url': url,
       'vehicaltype':vehicaltype,
       'vehicalsize': vehicalsize,
       'drivername':drivername,
       'targetarea':targetarea,
      'labourcharge':labourcharge,
    };
  }
  factory Vehicaluploadmodel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return Vehicaluploadmodel(
        uid: json["uid"],
        capacity: json["capacity"],
        kmprice: json["kmprice"],
        licienceno: json["licienceno"],
        post: json["post"],
        mprice: json["mprice"],
        driverphoneno: json['driverphoneno'],
        vehicalname: json['vehicalname'],
        url: json['url'],
        labourfacility: json['labourfacility'],
          vehicalsize: json['vehicalsize'],
        vehicaltype:json['vehicaltype'],
        drivername: json['drivername'],
        targetarea:json['targetarea'],
        labourcharge:json['labourcharge'],
        id: json['id']);
  }
}
