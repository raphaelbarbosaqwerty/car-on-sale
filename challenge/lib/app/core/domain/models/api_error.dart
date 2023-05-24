import 'package:challenge/app/core/domain/models/api_error_params.dart';

class ApiError {
  String msgKey;
  String message;
  ApiErrorParams params;

  ApiError({
    required this.msgKey,
    required this.params,
    required this.message,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        msgKey: json["msgKey"],
        params: ApiErrorParams.fromJson(json["params"] ?? {}),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "msgKey": msgKey,
        "params": params.toJson(),
        "message": message,
      };
}
