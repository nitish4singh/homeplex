class TransportOrder {
  final String pickuptime;
  final String tracelocation;
  final double latitude;
  final double longitude;
  final String deliverylocation;
  final String vehicalname;
  final String phone;
  final String id;
  final String userName;
  final String pickupdate;
  final String labourneed;
  final String driverid;
  final String post;
  final String costumername;
  final String orderid;
  final String drivername;
  final String licienceno;
  final String driverphoneno;
  final String labourcharge;

  TransportOrder({
    required this.deliverylocation,
    required this.pickuptime,
    required this.tracelocation,
    required this.longitude,
    required this.latitude,
    required this.vehicalname,
    required this.phone,
    required this.id,
    required this.driverid,
    required this.userName,
    required this.orderid,
    required this.pickupdate,
    required this.labourneed,
    required this.post,
    required this.costumername,
    required this.drivername,
    required this.driverphoneno,
    required this.licienceno,
    required this.labourcharge
  });

  Map<String, dynamic> getJson() {
    return {
      'pickuptime': pickuptime,
      'tracelocation': tracelocation,
      'longitude': longitude,
      'latitude': latitude,
      'deliverylocation': deliverylocation,
      'vehicalname': vehicalname,
      'phone': phone,
      'driverid': driverid,
      'id': id,
      'username': userName,
      'labourneed': labourneed,
      'pickupdate': pickupdate,
      'post': post,
      'costumername': costumername,
      'orderid': orderid,
      'drivername': drivername,
      'driverphoneno': driverphoneno,
      'licienceno': licienceno,
      'labourcharge':labourcharge,
    };
  }

  factory TransportOrder.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return TransportOrder(
        deliverylocation: json["deliverylocation"],
        pickuptime: json["pickuptime"],
        tracelocation: json["tracelocation"],
        userName: json["username"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        phone: json['phone'],
        vehicalname: json['vehicalname'],
        pickupdate: json['pickupdate'],
        labourneed: json['labourneed'],
        driverid: json['driverid'],
        post: json['post'],
        costumername: json['costumername'],
        orderid: json['orderid'],
        drivername: json['drivername'],
        licienceno: json['licienceno'],
        labourcharge:json['labourcharge'],
        driverphoneno: json['driverphoneno'],
        id: json['id']);
  }
}
