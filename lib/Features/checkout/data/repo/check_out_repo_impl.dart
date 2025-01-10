import 'package:dartz/dartz.dart';
import 'package:payment/Features/checkout/data/repo/checkout_repo.dart';
import 'package:payment/core/errors/failures.dart';
import 'package:payment/core/utils/service/stripe_service.dart';

import '../models/payment_intent_input_model.dart';

class CheckOutRepoImpl extends CheckOutRepo {
  StripeService stripe = StripeService();
  @override
  Future<Either<Failure, void>> makePayment(
      PaymentIntentInputModel input) async {
    try {
      await stripe.makePayment(input);
      return Right(null);
    } catch (e) {
      return Left(ServerFailure(errMessages: e.toString()));
    }
  }
}
