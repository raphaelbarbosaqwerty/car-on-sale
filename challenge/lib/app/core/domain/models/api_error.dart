import 'package:challenge/app/core/domain/models/api_error_params.dart';
import 'package:equatable/equatable.dart';

class ApiError extends Equatable {
  final String msgKey;
  final String message;
  final ApiErrorParams params;

  const ApiError({
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

  @override
  List<Object?> get props => [
        msgKey,
        message,
        params,
      ];
}
