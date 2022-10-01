class CategoriesModel
{
  CategoriesModel();

  late bool status;
  CategoryDataModel data=CategoryDataModel();
  CategoriesModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    if ((json['data'] != null)) {
      data = CategoryDataModel.fromJson(json['data']);
    } else {
      data =  CategoryDataModel.fromJson({});
    }
  }
}

class CategoryDataModel
{
  CategoryDataModel();
  late int currentPage;
  List<DataModel> data=[];

  CategoryDataModel.fromJson(Map<String, dynamic> json)
  {
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel
{
 //DataModel();
 late int id;
 late String image;
 late String name;

  DataModel.fromJson(Map<String, dynamic> json)
  {
    id=json['id'];
    image=json['image'];
    name=json['name'];
  }
}
