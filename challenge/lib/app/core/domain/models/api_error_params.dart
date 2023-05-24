class ApiErrorParams {
  final int delaySeconds;

  ApiErrorParams({
    this.delaySeconds = 0,
  });

  factory ApiErrorParams.fromJson(Map<String, dynamic> json) => ApiErrorParams(
        delaySeconds: int.tryParse(json["delaySeconds"]) ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "delaySeconds": delaySeconds,
      };

  bool get hasDelay => delaySeconds != 0;
}
