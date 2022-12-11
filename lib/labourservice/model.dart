
// class LabourModel {
//   //final String url;
//   final String labourType;
//   final String uid;
//   final String costumername;
//   final String vehicaltype;
//   final String vehicalsize;
//   final String phone;
//   final String post;
//   final int kmprice;
//   final int mprice;

//   LabourModel({
//     required this.phone,
//    // required this.url,
//     required this.labourType,
//     required this.uid,
//     required this.costumername,
//     required this.vehicalsize,
//     required this.vehicaltype,
//     required this.post,
//     required this.kmprice,
//     required this.mprice,
//   });

//   Map<String, dynamic> getJson() {
//     return {
//      // 'url': url,
//       'labourType': labourType,
//       'uid': uid,
//       'costumername': costumername,
//       'vehicalsize': vehicalsize,
//       'vehicaltype': vehicaltype,
//       'phone': phone,
//       'post': post,
//       'mprice': mprice,
//       'kmprice': kmprice,
//     };
//   }

//   factory LabourModel.getModelFromJson(
//       {required Map<String, dynamic> json}) {
//     return LabourModel(
//       phone: json["phone"],
//      // url: json["url"],
//       uid: json["uid"],
//       costumername: json["costumername"],
//       vehicalsize: json["vehicalsize"],
//       labourType: json['labourType'],
//       vehicaltype: json["vehicaltype"],
//       post: json['post'],
//       kmprice: json['kmprice'],
//       mprice: json['mprice'],
//     );
//   }
// }
