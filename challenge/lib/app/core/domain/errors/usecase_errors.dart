import 'package:challenge/app/core/domain/errors/generic_errors.dart';

class TimeoutApi extends Failure {
  TimeoutApi([message = ""]) : super(message);
}
