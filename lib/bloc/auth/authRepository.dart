import 'dart:convert' as convert;

import 'package:dartz/dartz.dart';

import './authDataProvider.dart';
import '../serverException.dart';

Future<Either<CommonException, Map<String, dynamic>>> authenticateUser(
    {required String username, required String password}) async {
  final response = await callLoginAPI(username: username, password: password);
  if (response.statusCode == 200) {
    final jsonResponse =
        convert.jsonDecode(response.body) as Map<String, dynamic>;
    return Right(jsonResponse);
  } else {
    return Left(CommonException('Server returned error'));
  }
}
