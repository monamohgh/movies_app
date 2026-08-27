import 'package:movies_app/utils/app_assets.dart';

class MyUser {
  ///1-CollectionName
  static const String collectionName='Users';
  ///2-Attributes
  String id;
  String name;
  String email;
  String avatar;
  String phone;
  ///3-Constructor
  MyUser({required this.name,required this.email,required this.id,required this.avatar,required this.phone});
  ///4- json => object
  MyUser.fromFireStore(Map<String,dynamic> data):this(
    id:data['id'],
    name:data['name'],
    email:data['email'],
    avatar:data['avatar']??AppAssets.avatar5,
    phone: data['phone'] ?? '',
  );///calling the primary  constructor MyUser
  /// 5-object => json
  Map<String,dynamic>toFireStore(){
    return {
      'id':id,
      'name':name,
      'email':email,
      'avatar':avatar,
      'phone': phone,
    };
  }
}