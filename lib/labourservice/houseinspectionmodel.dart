
class HomeInspectionModel {
  //final String url;
  final int servicecharge;
  final String engineername;
  final String engineeringtype;
  final String speciality;
  final String experience;
  final String phone;
  final String image;
  // final int kmprice;
  // final int mprice;

  HomeInspectionModel({
    required this.phone,
   // required this.url,
    required this.servicecharge,
    required this.engineername,
    required this.engineeringtype,
    required this.experience,
    required this.speciality,
    required this.image,
    // required this.kmprice,
    // required this.mprice,
  });

  Map<String, dynamic> getJson() {
    return {
     // 'url': url,
      'servicecharge': servicecharge,
      'engineername': engineername,
      'engineeringtype': engineeringtype,
      'experience': experience,
      'speciality': speciality,
      'phone': phone,
      'image': image,
      // 'mprice': mprice,
      // 'kmprice': kmprice,
    };
  }

  factory HomeInspectionModel.getModelFromJson(
      {required Map<String, dynamic> json}) {
    return HomeInspectionModel(
      phone: json["phone"],
     // url: json["url"],
      engineername: json["engineername"],
      engineeringtype: json["engineeringtype"],
      experience: json["experience"],
      servicecharge: json['servicecharge'],
      speciality: json["speciality"],
      image: json['image'],
      // kmprice: json['kmprice'],
      // mprice: json['mprice'],
    );
  }
}
