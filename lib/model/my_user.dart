class MyUser {
  ///1-CollectionName
  static const String collectionName='Users';
  ///2-Attributes
  String id;
  String name;
  String email;
  ///3-Constructor
  MyUser({required this.name,required this.email,required this.id});
  ///4- json => object
  MyUser.fromFireStore(Map<String,dynamic> data):this(
    id:data['id'],
    name:data['name'],
    email:data['email'],
  );///calling the primary  constructor MyUser
  /// 5-object => json
  Map<String,dynamic>toFireStore(){
    return {
      'id':id,
      'name':name,
      'email':email,
    };
  }
}