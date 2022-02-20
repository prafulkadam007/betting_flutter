import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_login/flutter_login.dart';

//import './utils/utils.dart';
import './dashboard.dart';
import 'bloc/auth/authBloc.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class SigninView extends StatelessWidget {
  SigninView({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: 2250);

  BuildContext? storedContext;

  Future<String?> _authUser(LoginData data) async {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    BlocProvider.of<AuthBloc>(storedContext!)
        .add(StartAuthentication(username: data.name, password: data.password));

    final result = await BlocProvider.of<AuthBloc>(storedContext!)
        .stream
        .firstWhere((state) => true);

    if (result is AuthError) {
      return result.error;
    }
    return null;
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    debugPrint('Signup details: ${data.additionalSignupData}');

    /*BlocProvider.of<AuthBloc>(storedContext!).add(StartRegistration({
      'email': data.name!,
      'password': data.password!,
      ...data.additionalSignupData!
    }));

    final result = await BlocProvider.of<AuthBloc>(storedContext!)
        .stream
        .firstWhere((state) => true);

    if (result is AuthError) {
      return result.error;
    }*/
    return null;
  }

  Future<String?> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    storedContext = context;
    return FlutterLogin(
      title: 'ECORP',
      logo: const AssetImage('assets/images/ecorp.png'),
      onLogin: _authUser,
      onSignup: _signupUser,
      loginAfterSignUp: false,
      additionalSignupFields: const [
        UserFormField(
          keyName: 'fullname',
          displayName: 'Full Name',
          icon: Icon(Icons.person),
        ),
        UserFormField(
          keyName: 'mobile',
          displayName: 'Mobile Number',
          icon: Icon(Icons.mobile_friendly),
        )
      ],
      onSubmitAnimationCompleted: () =>
          Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName),
      onRecoverPassword: _recoverPassword,
    );
  }
}
