import 'package:challenge/app/core/domain/errors/generic_errors.dart';

class UserNotFound extends Failure {
  UserNotFound([message = ""]) : super(message);
}

class UnableToClearUserCredentials extends Failure {
  UnableToClearUserCredentials([message = ""]) : super(message);
}

class EmptyCredentials extends Failure {
  EmptyCredentials([message = ""]) : super(message);
}
