import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_model/PaymentIntentModel.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/core/utils/service/api_service.dart';

class StripeService {
  ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(PaymentIntentInputModel input) async {
  var response= await apiService.post(
        body: input.toJson(),
        url: "https://api.stripe.com/v1/payment_intents",
        token: ApiKeys.secretKey);
    var paymentIntentModel=PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }
  Future initPaymentSheet({required String paymentIntentClientSecret})async{
    Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      merchantDisplayName: "hazem"

    ));

    Future displayPaymentSheet()async{
      Stripe.instance.presentPaymentSheet();
    }


  }
  Future makePayment(PaymentIntentInputModel input)async{
    var paymentIntentModel = await createPaymentIntent(input);
    await initPaymentSheet(paymentIntentClientSecret: paymentIntentModel.clientSecret!);
    await displayPaymentSheet();

  }

}
