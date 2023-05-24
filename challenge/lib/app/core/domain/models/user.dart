import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final String email;

  const User({
    this.name = "",
    this.email = "",
  });

  @override
  List<Object?> get props => [
        name,
        email,
      ];
}
