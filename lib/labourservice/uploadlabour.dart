class LabourOrder {
  final String servicetime;
  final String tracelocation;
  final double latitude;
  final double longitude;
  final String labourtype;
  final String phone;
  final String id;
  final String userName;
   final String uplodername;
   final String pickupdate;
   final String orderid;
  //   final int kmprice;
  // final int mprice;
    LabourOrder({
    required this.uplodername,
    required this.servicetime,
    required this.tracelocation,
    required this.longitude,
    required this.latitude,
    required this.labourtype,
    required this.phone,
    required this.id,
    required this.userName,
    required this.pickupdate,
    required this.orderid,
  });

  Map<String, dynamic> getJson() {
    return {
        'servicetime': servicetime,
      'tracelocation': tracelocation,
      'longitude': longitude,
      'latitude': latitude,
      'uplodername': uplodername,
      'labourtype': labourtype,
         'phone': phone,
      'id': id,
      'username': userName,
          'pickupdate': pickupdate,
          'orderid':orderid
          
    };
  }

  factory LabourOrder.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return LabourOrder(
        uplodername: json["uplodername"],
        servicetime: json["servicetime"],
        tracelocation: json["tracelocation"],
        userName: json["username"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        phone: json['phone'],
        labourtype: json['labourtype'],
          pickupdate: json['pickupdate'],
         orderid:json['orderid'],
        //   kmprice: json['kmprice'],
        // mprice:json['mprice'],
        id: json['id']);
  }
}
