import 'package:challenge/app/core/domain/models/api_error.dart';

import 'generic_errors.dart';

sealed class ApiErrors extends Failure {
  ApiErrors(super.message);
}

class TimeoutApi extends ApiErrors {
  TimeoutApi([message = ""]) : super(message);
}

class IncorrectJsonFormat extends ApiErrors {
  IncorrectJsonFormat([message = ""]) : super(message);
}

class InternalApiError extends ApiErrors {
  final ApiError? extraError;
  InternalApiError(this.extraError, [message = ""]) : super(message);
}

class UnknowError extends ApiErrors {
  UnknowError([message = ""]) : super(message);
}
