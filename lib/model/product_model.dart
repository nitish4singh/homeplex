class ProductModel {
  final String url;
  final String url2;
  final String url3;
  final String url4;
  final String productName;
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
  bool? isFavourite;

  ProductModel(
      {required this.district,
      required this.url,
      required this.url2,
      required this.url3,
      required this.url4,
      required this.productName,
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
      required this.roaddetail,
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
      'roaddetail':roaddetail,
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

  factory ProductModel.getModelFromJson({required Map<String, dynamic> json}) {
    return ProductModel(
        district: json["district"],
        url: json["url"],
        url2: json['url2'],
        url3: json["url3"],
        url4: json["url4"],
        productName: json["productName"],
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
       roaddetail: json["roaddetail"],
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
