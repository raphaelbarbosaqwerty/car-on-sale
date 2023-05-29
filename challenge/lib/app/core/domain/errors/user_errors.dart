import 'package:challenge/app/core/domain/errors/generic_errors.dart';

sealed class UserErrors extends Failure {
  UserErrors(super.message);
}

class UserNotFound extends UserErrors {
  UserNotFound([message = ""]) : super(message);
}

class UnableToClearUserCredentials extends UserErrors {
  UnableToClearUserCredentials([message = ""]) : super(message);
}

class EmptyCredentials extends UserErrors {
  EmptyCredentials([message = ""]) : super(message);
}
