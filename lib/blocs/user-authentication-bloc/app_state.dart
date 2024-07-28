part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState._({required this.status, this.user = User.empty});

  /// named constructor
  const AppState.authenticated(User user)
      : this._(status: AppStatus.authenticated, user: user);

  /// named constructor
  const AppState.unauthenticated() : this._(status: AppStatus.unauthenticated);

  final AppStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}
///Private constructors are used to prevent creating instances of a class when
///there are no instance fields or methods, such as the Math class,
///or when a method is called to obtain an instance of a class.