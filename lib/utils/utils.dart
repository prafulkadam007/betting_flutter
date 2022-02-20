import 'package:flutter/material.dart';

logUserOut(BuildContext context) {
  // code for clearing the session
  Navigator.of(context).pushReplacementNamed('/');
}
