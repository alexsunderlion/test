import 'package:clubforce/core/util/constants.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class ServerFailure extends Failure {
  final String errorMessage;
  final dynamic error;

  ServerFailure(this.errorMessage, {this.error});

  @override
  List<Object?> get props => [errorMessage, error];
}

class ConnectionFailure extends Failure {
  final String errorMessage = ErrorMessages.connectionError;

  @override
  List<Object?> get props => [errorMessage];
}

class FatalFailure extends Failure {
  final String errorMessage;

  FatalFailure(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
