import 'package:flutter/material.dart';
import 'package:inject/inject.dart';

@provide
class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String err = ModalRoute.of(context).settings.arguments.toString();
    return Scaffold(body: Center(child: Text(err)));
  }
}
