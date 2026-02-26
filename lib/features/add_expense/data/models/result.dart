import 'package:flutter/cupertino.dart';

sealed class Result<S,F> {}

class Success<S,F> extends Result<S,F>
{
  final S value;
  Success(this.value);
}

class Failure<S,F> extends Result<S,F>
{
  final F error;
  Failure(this.error);
}

extension MyStringExtensions on String{
  String capitalize(){
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}

class Document{
  String s = "hello";
  void fun()
  {
    debugPrint(s.capitalize());

  }
}

