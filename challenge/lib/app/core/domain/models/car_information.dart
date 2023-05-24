class CarInformation {
  final String id;
  final String feedback;
  final DateTime? valuatedAt;
  final DateTime? requestedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String make;
  final String model;
  final String externalId;
  final String fkSellerUser;
  final String price;
  final bool positiveCustomerFeedback;
  final String fkUuidAuction;
  final DateTime? inspectorRequestedAt;
  final String origin;
  final String estimationRequestId;

  CarInformation({
    this.id = "",
    this.feedback = "",
    this.valuatedAt,
    this.requestedAt,
    this.createdAt,
    this.updatedAt,
    this.make = "",
    this.model = "",
    this.externalId = "",
    this.fkSellerUser = "",
    this.price = "",
    this.positiveCustomerFeedback = false,
    this.fkUuidAuction = "",
    this.inspectorRequestedAt,
    this.origin = "",
    this.estimationRequestId = "",
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

  static CarInformation fromMapWithPatternMatching(Map<String, dynamic> json) {
    return CarInformation();
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "feedback": feedback,
        "valuatedAt": valuatedAt?.toIso8601String(),
        "requestedAt": requestedAt?.toIso8601String(),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "make": make,
        "model": model,
        "externalId": externalId,
        "_fk_sellerUser": fkSellerUser,
        "price": price,
        "positiveCustomerFeedback": positiveCustomerFeedback,
        "_fk_uuid_auction": fkUuidAuction,
        "inspectorRequestedAt": inspectorRequestedAt?.toIso8601String(),
        "origin": origin,
        "estimationRequestId": estimationRequestId,
      };
}
