class TankerOrder {
  final String pickuptime;
  final String tracelocation;
  final double latitude;
  final double longitude; 
  //final String deliverylocation;
  final String vehicalname;
  final String phone;
  final String id;
  final String userName;
  final String pickupdate;
  final String driverid;
  final String post;
  final String costumername;
  final String orderid;
  final String drivername;
  final String licienceno;
  final String driverphoneno;

  TankerOrder({
   // required this.deliverylocation,
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
    required this.post,
    required this.costumername,
    required this.drivername,
    required this.driverphoneno,
    required this.licienceno,
  });

  Map<String, dynamic> getJson() {
    return {
      'pickuptime': pickuptime,
      'tracelocation': tracelocation,
      'longitude': longitude,
      'latitude': latitude,
      //'deliverylocation': deliverylocation,
      'vehicalname': vehicalname,
      'phone': phone,
      'driverid': driverid,
      'id': id,
      'username': userName,
      'pickupdate': pickupdate,
      'post': post,
      'costumername': costumername,
      'orderid': orderid,
      'drivername': drivername,
      'driverphoneno': driverphoneno,
      'licienceno': licienceno,
    };
  }

  factory TankerOrder.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return TankerOrder(
       // deliverylocation: json["deliverylocation"],
        pickuptime: json["pickuptime"],
        tracelocation: json["tracelocation"],
        userName: json["username"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        phone: json['phone'],
        vehicalname: json['vehicalname'],
        pickupdate: json['pickupdate'],
        driverid: json['driverid'],
        post: json['post'],
        costumername: json['costumername'],
        orderid: json['orderid'],
        drivername: json['drivername'],
        licienceno: json['licienceno'],
        driverphoneno: json['driverphoneno'],
        id: json['id']);
  }
}
