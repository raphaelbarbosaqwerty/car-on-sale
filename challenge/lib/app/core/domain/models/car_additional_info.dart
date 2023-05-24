class CarAdditionalInfo {
  String make;
  String model;
  String containerName;
  int similarity;
  String externalId;

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
}
