import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_model/PaymentIntentModel.dart';
import 'package:payment/core/utils/service/api_service.dart';

class StripeService {
  ApiService apiService =ApiService();
PaymentIntentModel createPaymentIntent(PaymentIntentInputModel input){

apiService.post(body: input.toJson(), url: "https://api.stripe.com/v1/payment_intents", token: "");



}

}
