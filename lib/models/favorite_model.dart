class FavoriteModel {
  bool? status;
  Data data=Data();
  FavoriteModel();
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    } else {
      data =  Data.fromJson({});
    }
  }
}

class Data {
  int? currentPage;
  List<FavoriteData> data=[];
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? path;
  int? perPage;
  int? to;
  int? total;
  Data();
  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoriteData>[];
      json['data'].forEach((v) {
        data.add(FavoriteData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }
}

class FavoriteData {
  int? id;
  late Product product;
  FavoriteData();
  FavoriteData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if ((json['product'] != null)) {
      product =Product.fromJson(json['product']);
    } else {
      product =  Product.fromJson({});
    }
  }
}

class Product {
  late int id;
  dynamic price;
  dynamic oldPrice;
  late int discount;
  late String image;
  late String name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
