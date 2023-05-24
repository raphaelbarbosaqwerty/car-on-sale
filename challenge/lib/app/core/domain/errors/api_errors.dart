import 'package:challenge/app/core/domain/models/api_error.dart';

import 'generic_errors.dart';

class TimeoutApi extends Failure {
  TimeoutApi([message = ""]) : super(message);
}

class IncorrectJsonFormat extends Failure {
  IncorrectJsonFormat([message = ""]) : super(message);
}

class InternalApiError extends Failure {
  final ApiError? extraError;
  InternalApiError(this.extraError, [message = ""]) : super(message);
}

class UnknowError extends Failure {
  UnknowError([message = ""]) : super(message);
}
