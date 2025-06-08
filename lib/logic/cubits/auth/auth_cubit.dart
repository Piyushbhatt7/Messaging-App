import 'dart:async';

import 'package:chatt_app/data/repository/auth_repository.dart';
import 'package:chatt_app/logic/cubits/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{

    final AuthRepository _authRepository;
    StreamSubscription<User?>? _authStateSubscription;

    AuthCubit({
        required AuthRepository authRepository,

    }): _authRepository = authRepository, super( 
        const AuthState()) {
        _init();
        }

    void _init() {
        emit(state.copyWith(status: AuthStatus.initial));
    }
}