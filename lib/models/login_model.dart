class LoginModel
{
  LoginModel();
   bool? status;
   String? message;
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
   int? id;
   String? name;
   String? email;
   String? phone;
   String? image;
   int? points;
   int? credit;
   String? token;
  UserModel({this.id,this.name,this.email,this.phone,this.image,this.points,this.credit,this.token});
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