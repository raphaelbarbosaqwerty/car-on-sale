import 'package:challenge/app/core/domain/errors/generic_errors.dart';

class VinCodeEmpty extends Failure {
  VinCodeEmpty([message = ""]) : super(message);
}
