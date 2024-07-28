import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
  });

  /// The current details
  final String? email;
  final String id;
  final String? name;
  final String? photo;
  static const empty = User(id: ''); ///User.empty ~ Empty user ~ an unauthenticated user.
  bool get isEmpty => this == User.empty; ///to determine whether the current user is empty.
  bool get isNotEmpty => this != User.empty; ///to determine whether the current user is not empty.

  @override
  List<Object?> get props => [email, id, name,photo];
}