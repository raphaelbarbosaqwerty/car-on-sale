import 'package:equatable/equatable.dart';

class ApiErrorParams extends Equatable {
  final int delaySeconds;

  const ApiErrorParams({
    this.delaySeconds = 0,
  });

  factory ApiErrorParams.fromJson(Map<String, dynamic> json) => ApiErrorParams(
        delaySeconds: int.tryParse(json["delaySeconds"]) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "delaySeconds": delaySeconds,
      };

  bool get hasDelay => delaySeconds != 0;

  @override
  List<Object?> get props => [
        delaySeconds,
      ];
}
