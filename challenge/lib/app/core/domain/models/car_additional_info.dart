class CarAdditionalInfo {
  final String make;
  final String model;
  final String containerName;
  final int similarity;
  final String externalId;

  CarAdditionalInfo({
    required this.make,
    required this.model,
    required this.containerName,
    required this.similarity,
    required this.externalId,
  });

  static CarAdditionalInfo fromJson(Map<String, dynamic> json) =>
      CarAdditionalInfo(
        make: json["make"],
        model: json["model"],
        containerName: json["containerName"],
        similarity: json["similarity"],
        externalId: json["externalId"],
      );

  static List<CarAdditionalInfo> fromJsonList(List json) => json
      .map(
        (e) => fromJson(e),
      )
      .toList();

  Map<String, dynamic> toJson() => {
        "make": make,
        "model": model,
        "containerName": containerName,
        "similarity": similarity,
        "externalId": externalId,
      };

  static List<Map<String, dynamic>> toJsonList(List<CarAdditionalInfo> json) =>
      json.map((e) => e.toJson()).toList();
}
