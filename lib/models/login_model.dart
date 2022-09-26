class LoginModel{
  late bool status;
   String? message;
  UserData? data;

  LoginModel(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
    data=json['data']!=null ? UserData(json['data']) : null;
  }

}

class UserData{
  String? name;
  int? id;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData(Map<String ,dynamic> data){
    name=data['name'];
    id=data['id'];
    email=data['email'];
    phone=data['phone'];
    image=data['image'];
    points=data['points'];
    credit=data['credit'];
    token=data['token'];
  }
}