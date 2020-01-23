class UserModel {
  String gender;
  String email  ;
  String phone;

  UserModel({this.gender, this.email, this.phone});



  UserModel.fromMap(Map<String, dynamic> map) {
    gender = map['name'].toString();
    email = map['sku'].toString();
    phone = map['short_description'].toString(); ;
  }
}
