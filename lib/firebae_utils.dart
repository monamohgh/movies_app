import 'package:cloud_firestore/cloud_firestore.dart';

import 'model/my_user.dart';

///withConverter=>make the firestore know the type of the variable that store in it
class FirebaseUtils {
  static CollectionReference<MyUser> getUserCollections() {
    /// get or create collection
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFireStore(),
        );
  }

  static Future<void> addUserInFireStore(MyUser myUser) {
    //todo:1- create collection
    CollectionReference<MyUser> collectionRef = getUserCollections();
    //todo:2-create document
    DocumentReference<MyUser> docRef = collectionRef.doc(myUser.id);
    //todo:add data
    return docRef.set(myUser);

    ///the solution in one line
    /// getUserCollections().doc(myUser.id).set(mFuture<MyUser?>
  }

  static Future<MyUser?> readUserFromFireStore(String uId) async {
    DocumentSnapshot<MyUser> querySnapshot = await getUserCollections()
        .doc(uId)
        .get();
    return querySnapshot.data();
  }
  static Future<void>deleteUserFireSore(String id){
    return getUserCollections().doc(id).delete();
  }
}
