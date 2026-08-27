import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/my_user.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserUpdatedState extends UserState {
  final MyUser user;
  UserUpdatedState(this.user);}

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());
  MyUser? currentUser;

  void updateUser(MyUser user) {
    currentUser = user;
    emit(UserUpdatedState(user));
  }
}