class LoginModel
{
  LoginModel();
  late bool status;
   late String? message;
   UserModel data=UserModel();

  LoginModel.fromJson(Map<String,dynamic> json)
  {
    status=json['status'];
    message=json['message'];
    if ((json['data'] != null)) {
      data = UserModel.fromJson(json['data']);
    } else {
      data =  UserModel.fromJson({});
    }
  }
}

class UserModel
{
  late int id;
  late String name;
  late String email;
  late String phone;
  late String image;
  late int points;
  late int credit;
  late String token;
  UserModel();
  UserModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }

}