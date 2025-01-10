import 'package:dartz/dartz.dart';
import 'package:payment/core/errors/failures.dart';

import '../models/payment_intent_input_model.dart';

abstract class CheckOutRepo{


Future<Either<Failure,void>>makePayment(PaymentIntentInputModel input);

}
