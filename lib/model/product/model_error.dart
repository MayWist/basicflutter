import 'dart:convert';

ModelError userErrorFromJson(String str) =>
    ModelError.fromJson(json.decode(str));

String userErrorToJson(ModelError data) => json.encode(data.toJson());

class ModelError {
  ModelError({
    required this.code,
    required this.message,
  });

  int code;
  String message;

  factory ModelError.fromJson(Map<String, dynamic> json) => ModelError(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
      };
}
