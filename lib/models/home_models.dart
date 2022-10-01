class HomeModels
{
  HomeModels();

late bool status;
   HomeDataModel data=HomeDataModel();
  HomeModels.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    if ((json['data'] != null)) {
      data = HomeDataModel.fromJson(json['data']);
    } else {
      data =  HomeDataModel.fromJson({});
    }
  }
}

class HomeDataModel
{
  HomeDataModel();
  List<BannerModel> banners=[];
  List<ProductModel> products=[];

  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductModel.fromJson(element));
    });
  }
}


class BannerModel
{
  late int id;
   late String image;
 // BannerModel();
  BannerModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}

class ProductModel
{
  ProductModel();
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool inFavorite;
  late bool inCart;

  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorite=json['in_favorites'];
    inCart=json['in_cart'];

  }
}