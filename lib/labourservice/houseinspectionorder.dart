class HouseInspectionOrder {
  final String servicetime;
  final String tracelocation;
  final double latitude;
  final double longitude;
  final String engineername;
  final String phone;
  final String id;
  final int servicecharge;
  final String uplodername;
  final String pickupdate;
  final String speciality;
  final String servicetype;
  //   final int kmprice;
  // final int mprice;
  HouseInspectionOrder({
    required this.uplodername,
    required this.servicetime,
    required this.tracelocation,
    required this.longitude,
    required this.latitude,
    required this.engineername,
    required this.phone,
    required this.id,
    required this.servicecharge,
    required this.pickupdate,
    required this.speciality,
    required this.servicetype,
  });

  Map<String, dynamic> getJson() {
    return {
      'servicetime': servicetime,
      'tracelocation': tracelocation,
      'longitude': longitude,
      'latitude': latitude,
      'uplodername': uplodername,
      'engineername': engineername,
      'phone': phone,
      'id': id,
      'servicecharge': servicecharge,
      'pickupdate': pickupdate,
      'speciality': speciality,
       'servicetype': servicetype
    };
  }

  factory HouseInspectionOrder.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return HouseInspectionOrder(
        uplodername: json["uplodername"],
        servicetime: json["servicetime"],
        tracelocation: json["tracelocation"],
        servicecharge: json["servicecharge"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        phone: json['phone'],
        engineername: json['engineername'],
        pickupdate: json['pickupdate'],
        speciality: json['speciality'],
           servicetype: json['servicetype'],
        // mprice:json['mprice'],
        id: json['id']);
  }
}
