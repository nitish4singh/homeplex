class HouseModel {
  final String url;
  final String url2;
  final String url3;
  final String url4;
  final String productName;
  final double cost;
  final int discount;
  final String uid;
  final String sellerName;
  final String sellerUid;
  final int totalcarparking;
  final int totalbikeparking;

  final String floor;
  final int totalroom;
  final String roomdetail;
  final int rate;
  final String famousplacenearby;
  final String formuploadername;
  final String phoneno;
  final String parking;
  final String internet;
  final String family;
  final String tracelocation;
  final double latitude;
  final double longitude;
  final String district;
  final String type;
  final String post;
  final String id;
  bool? isFavourite;

  HouseModel(
      {required this.district,
      required this.url,
      required this.url2,
      required this.url3,
      required this.url4,
      required this.productName,
      required this.cost,
      required this.discount,
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
      required this.parking,
      required this.internet,
      required this.family,
      required this.tracelocation,
      required this.longitude,
      required this.latitude,
      required this.type,
      required this.post,
      required this.id,
      required this.isFavourite,
required this.totalbikeparking,
required this.totalcarparking,
      });

  Map<String, dynamic> getJson() {
    return {
      'url': url,
      'url2': url2,
      'url3': url3,
      'url4': url4,
      'productName': productName,
      'cost': cost,
      'discount': discount,
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
      'parking': parking,
      'internet': internet,
      'family': family,
      'tracelocation': tracelocation,
      'longitude': longitude,
      'latitude': latitude,
      'district': district,
      'type': type,
      'post': post,
      'id': id,
      'isFavourite': isFavourite,
      'totalcarparking':totalcarparking,
      'totalbikeparking':totalbikeparking,
    };
  }

  factory HouseModel.getModelFromJson({required Map<String, dynamic> json}) {
    return HouseModel(
        district: json["district"],
        url: json["url"],
        url2: json['url2'],
        url3: json["url3"],
        url4: json["url4"],
        productName: json["productName"],
        cost: json["cost"],
        discount: json["discount"],
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
        parking: json["parking"],
        internet: json['internet'],
        family: json["family"],
        tracelocation: json["tracelocation"],
        type: json["type"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        post: json['post'],
        isFavourite: json['isFavourite'],
        totalcarparking: json['totalcarparking'],
        totalbikeparking:json['totalbikeparking'] ,
        id: json['id']);
  }
}
