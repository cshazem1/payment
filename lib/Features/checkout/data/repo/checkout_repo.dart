import 'package:dartz/dartz.dart';
import 'package:payment/core/errors/failures.dart';

abstract class CheckOutRepo{


Future<Either<Failure,void>>makePayment();

}
