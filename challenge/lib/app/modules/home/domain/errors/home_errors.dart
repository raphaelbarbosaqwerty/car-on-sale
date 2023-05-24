import 'package:challenge/app/core/domain/errors/generic_errors.dart';

class VinCodeEmpty extends Failure {
  VinCodeEmpty([message = ""]) : super(message);
}

class UnableToCacheSuggestions extends Failure {
  UnableToCacheSuggestions([message = ""]) : super(message);
}

class UnableToGetSuggestions extends Failure {
  UnableToGetSuggestions([message = ""]) : super(message);
}

class UnableToSaveCarInformation extends Failure {
  UnableToSaveCarInformation([message = ""]) : super(message);
}

class UnableToGetCarInformation extends Failure {
  UnableToGetCarInformation([message = ""]) : super(message);
}
