class CarInformation {
  String id;
  String feedback;
  DateTime valuatedAt;
  DateTime requestedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String make;
  String model;
  String externalId;
  String fkSellerUser;
  String price;
  bool positiveCustomerFeedback;
  String fkUuidAuction;
  DateTime inspectorRequestedAt;
  String origin;
  String estimationRequestId;

  CarInformation({
    required this.id,
    required this.feedback,
    required this.valuatedAt,
    required this.requestedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.make,
    required this.model,
    required this.externalId,
    required this.fkSellerUser,
    required this.price,
    required this.positiveCustomerFeedback,
    required this.fkUuidAuction,
    required this.inspectorRequestedAt,
    required this.origin,
    required this.estimationRequestId,
  });

  factory CarInformation.fromJson(Map<String, dynamic> json) => CarInformation(
        id: json["id"],
        feedback: json["feedback"],
        valuatedAt: DateTime.parse(json["valuatedAt"]),
        requestedAt: DateTime.parse(json["requestedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        make: json["make"],
        model: json["model"],
        externalId: json["externalId"],
        fkSellerUser: json["_fk_sellerUser"],
        price: json["price"],
        positiveCustomerFeedback: json["positiveCustomerFeedback"],
        fkUuidAuction: json["_fk_uuid_auction"],
        inspectorRequestedAt: DateTime.parse(json["inspectorRequestedAt"]),
        origin: json["origin"],
        estimationRequestId: json["estimationRequestId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feedback": feedback,
        "valuatedAt": valuatedAt.toIso8601String(),
        "requestedAt": requestedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "make": make,
        "model": model,
        "externalId": externalId,
        "_fk_sellerUser": fkSellerUser,
        "price": price,
        "positiveCustomerFeedback": positiveCustomerFeedback,
        "_fk_uuid_auction": fkUuidAuction,
        "inspectorRequestedAt": inspectorRequestedAt.toIso8601String(),
        "origin": origin,
        "estimationRequestId": estimationRequestId,
      };
}
