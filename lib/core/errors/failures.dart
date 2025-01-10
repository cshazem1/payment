abstract class Failure{
final String errMessages;
Failure({required this.errMessages});


}

class ServerFailure extends Failure{
  ServerFailure({required super.errMessages});


}