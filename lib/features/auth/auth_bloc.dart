import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthEvent {}

class TogglePasswordVisibilityEvent extends AuthEvent {}

class ToggleConfirmPasswordVisibilityEvent extends AuthEvent {}

class SelectAvatarEvent extends AuthEvent {
  final int index;
  SelectAvatarEvent(this.index);
}

class LoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  LoginSubmittedEvent({required this.email, required this.password});
}

class RegisterSubmittedEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String phone;
  final int avatarIndex;

  RegisterSubmittedEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phone,
    required this.avatarIndex,
  });
}

class GoogleSignInRequestedEvent extends AuthEvent {}

class VerifyEmailRequestedEvent extends AuthEvent {
  final String email;
  VerifyEmailRequestedEvent(this.email);
}

class NavigateToRegisterEvent extends AuthEvent {}

class NavigateToForgetPasswordEvent extends AuthEvent {}

class NavigateToLoginEvent extends AuthEvent {}

class SwitchLanguageEvent extends AuthEvent {
  final String languageCode;
  SwitchLanguageEvent(this.languageCode);
}

class ResetNavigationEvent extends AuthEvent {}

enum AuthNavigationTarget { none, login, register, forgetPassword, home }

class AuthState {
  final bool isPasswordObscured;
  final bool isConfirmPasswordObscured;
  final int selectedAvatarIndex;
  final AuthNavigationTarget navigationTarget;
  final bool isLoading;
  final String? errorMessage;
  final String? successMessage;
  final String currentLanguage;

  AuthState({
    this.isPasswordObscured = true,
    this.isConfirmPasswordObscured = true,
    this.selectedAvatarIndex = 0,
    this.navigationTarget = AuthNavigationTarget.none,
    this.isLoading = false,
    this.errorMessage,
    this.successMessage,
    this.currentLanguage = 'en',
  });

  AuthState copyWith({
    bool? isPasswordObscured,
    bool? isConfirmPasswordObscured,
    int? selectedAvatarIndex,
    AuthNavigationTarget? navigationTarget,
    bool? isLoading,
    String? errorMessage,
    String? successMessage,
    String? currentLanguage,
  }) {
    return AuthState(
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmPasswordObscured:
          isConfirmPasswordObscured ?? this.isConfirmPasswordObscured,
      selectedAvatarIndex: selectedAvatarIndex ?? this.selectedAvatarIndex,
      navigationTarget: navigationTarget ?? this.navigationTarget,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      successMessage: successMessage,
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  AuthBloc() : super(AuthState()) {
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
    });

    on<ToggleConfirmPasswordVisibilityEvent>((event, emit) {
      emit(
        state.copyWith(
          isConfirmPasswordObscured: !state.isConfirmPasswordObscured,
        ),
      );
    });

    on<SelectAvatarEvent>((event, emit) {
      emit(state.copyWith(selectedAvatarIndex: event.index));
    });

    on<NavigateToRegisterEvent>((event, emit) {
      emit(state.copyWith(navigationTarget: AuthNavigationTarget.register));
    });

    on<NavigateToForgetPasswordEvent>((event, emit) {
      emit(
        state.copyWith(navigationTarget: AuthNavigationTarget.forgetPassword),
      );
    });

    on<NavigateToLoginEvent>((event, emit) {
      emit(state.copyWith(navigationTarget: AuthNavigationTarget.login));
    });

    on<ResetNavigationEvent>((event, emit) {
      emit(state.copyWith(navigationTarget: AuthNavigationTarget.none));
    });

    on<SwitchLanguageEvent>((event, emit) {
      emit(state.copyWith(currentLanguage: event.languageCode));
    });

    on<LoginSubmittedEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await Future.delayed(const Duration(seconds: 1));
      emit(
        state.copyWith(
          isLoading: false,
          navigationTarget: AuthNavigationTarget.home,
        ),
      );
    });

    on<RegisterSubmittedEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await Future.delayed(const Duration(seconds: 1));
      emit(
        state.copyWith(
          isLoading: false,
          navigationTarget: AuthNavigationTarget.home,
        ),
      );
    });

    on<GoogleSignInRequestedEvent>((event, emit) async {
      try {
        emit(state.copyWith(isLoading: true, errorMessage: null));
        final GoogleSignInAccount? account = await _googleSignIn.signIn();
        if (account != null) {
          emit(
            state.copyWith(
              isLoading: false,
              navigationTarget: AuthNavigationTarget.home,
            ),
          );
        } else {
          emit(state.copyWith(isLoading: false));
        }
      } catch (e) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Google Sign-In failed: ${e.toString()}',
          ),
        );
      }
    });

    on<VerifyEmailRequestedEvent>((event, emit) async {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(
        state.copyWith(
          isLoading: false,
          successMessage: 'Email sent successfully ✓',
        ),
      );
    });
  }
}
