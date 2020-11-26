import 'package:equatable/equatable.dart';

/// defines which user is log in, and its mean
/// to be use as a family provider
/// ```dart
///   useProvider(provider(RolParameter(rol : "tutors", userId : 2))
/// ```
class RolParameter extends Equatable {
  RolParameter({this.rol, this.userId})
      : assert(
          rol != null && userId != null,
        );
  final String rol;
  final int userId;
  // final String queryName;

  @override
  List<Object> get props => [rol, userId];

  @override
  String toString() {
    return "RolParameter(rol:$rol, userId:$userId)";
  }
}
