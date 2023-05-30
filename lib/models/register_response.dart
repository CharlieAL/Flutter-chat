// To parse this JSON data, do
//
//     final errors = errorsFromJson(jsonString);

import 'dart:convert';

Errors errorsFromJson(String str) => Errors.fromJson(json.decode(str));

String errorsToJson(Errors data) => json.encode(data.toJson());

class Errors {
  bool ok;
  String msg;

  Errors({
    required this.ok,
    required this.msg,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        ok: json["ok"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
      };
}
