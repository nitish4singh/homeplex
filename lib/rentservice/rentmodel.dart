class RentModel {
  List<dynamic> imagesUrl;
  final String productName;
  // final int cost;
  //final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final String floor;
  final int totalroom;
  final String roomdetail;
  final int rate;
  final String famousplacenearby;
  final String formuploadername;
  final String phoneno;
  final String roaddetail;
  final String internet;
  final String family;
  final String tracelocation;
  final double latitude;
  final double longitude;
  final String district;
  final String type;
  final String post;
  final String id;
  final int totalcarparking;
  final int totalbikeparking;

  RentModel({
    required this.district,
    required this.imagesUrl,
    required this.productName,
    // required this.cost,
    //required this.discount,
    required this.uid,
    required this.sellerName,
    required this.sellerUid,
    required this.totalroom,
    required this.roomdetail,
    required this.rate,
    required this.famousplacenearby,
    required this.formuploadername,
    required this.phoneno,
    required this.floor,
    required this.roaddetail,
    required this.internet,
    required this.family,
    required this.tracelocation,
    required this.longitude,
    required this.latitude,
    required this.type,
    required this.post,
    required this.id,
    required this.totalbikeparking,
    required this.totalcarparking,
  });

  Map<String, dynamic> getJson() {
    return {
      'imagesUrl': imagesUrl,

      'productName': productName,
      //'cost': cost,
      //'discount': discount,
      'uid': uid,
      'sellerName': sellerName,
      'sellerUid': sellerUid,
      'totalroom': totalroom,
      'roomdetail': roomdetail,
      'rate': rate,
      'famousplacenearby': famousplacenearby,
      'formuploadername': formuploadername,
      'phoneno': phoneno,
      'floor': floor,
      'roaddetail': roaddetail,
      'internet': internet,
      'family': family,
      'tracelocation': tracelocation,
      'longitude': longitude,
      'latitude': latitude,
      'district': district,
      'type': type,
      'post': post,
      'id': id,
      'totalcarparking': totalcarparking,
      'totalbikeparking': totalbikeparking,
    };
  }

  factory RentModel.getModelFromJson({required Map<String, dynamic> json}) {
    return RentModel(
        district: json["district"],
        imagesUrl: json["imagesUrl"],
        productName: json["productName"],
        // cost: json["cost"],
        // discount: json["discount"],
        uid: json["uid"],
        sellerName: json["sellerName"],
        sellerUid: json["sellerUid"],
        totalroom: json["totalroom"],
        roomdetail: json["roomdetail"],
        rate: json["rate"],
        famousplacenearby: json["famousplacenearby"],
        formuploadername: json["formuploadername"],
        phoneno: json["phoneno"],
        floor: json["floor"],
        roaddetail: json["roaddetail"],
        internet: json['internet'],
        family: json["family"],
        tracelocation: json["tracelocation"],
        type: json["type"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        post: json['post'],
        totalcarparking: json['totalcarparking'],
        totalbikeparking: json['totalbikeparking'],
        id: json['id']);
  }
  //  await db.add(data);
}
