import 'dart:async';

import 'package:chatt_app/data/repository/auth_repository.dart';
import 'package:chatt_app/logic/cubits/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState>{

    final AuthRepository _authRepository;
    StreamSubscription<User?>? _authStateSubscription;

    AuthCubit({
        required this._authRepository,
        this._authStateSubscription,
    })
}