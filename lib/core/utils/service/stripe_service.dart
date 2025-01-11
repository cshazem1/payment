import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/Features/checkout/data/models/create_ephemeral_model/create_ephemeral_model.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_model/PaymentIntentModel.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/core/utils/service/api_service.dart';

class StripeService {
  ApiService apiService = ApiService();
  Future<PaymentIntentModel> createPaymentIntent(PaymentIntentInputModel input) async {
  var response= await apiService.post(
    contentType: Headers.formUrlEncodedContentType,
        body: input.toJson(),

        url: "https://api.stripe.com/v1/payment_intents",
        token: ApiKeys.secretKey);
    var paymentIntentModel=PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future<CreateEphemeralModel> createEphemeralKey(String customerId) async {
    var response= await apiService.post(
        contentType: Headers.formUrlEncodedContentType,
        body: {
          "customer":customerId

        },
headers: {
  'Authorization': "Bearer ${ApiKeys.secretKey}",
  'Stripe-Version': "2024-12-18.acacia"
},
        url: "https://api.stripe.com/v1/ephemeral_keys",
        token: ApiKeys.secretKey);
    var createEphemeralModel=CreateEphemeralModel.fromJson(response.data);
    return createEphemeralModel ;
  }

  Future initPaymentSheet({required String paymentIntentClientSecret,required String ephemeralKey})async{
   await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
      paymentIntentClientSecret: paymentIntentClientSecret,
      customerId: ApiKeys.customerID,
      customerEphemeralKeySecret:ephemeralKey ,
      merchantDisplayName: "hazem"

    ));




  }



  Future displayPaymentSheet()async{
   await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(PaymentIntentInputModel input)async{
    var paymentIntentModel = await createPaymentIntent(input);

    var ephemeralModel=await createEphemeralKey(ApiKeys.customerID);
    await initPaymentSheet(paymentIntentClientSecret: paymentIntentModel.clientSecret!,ephemeralKey: ephemeralModel.secret!);
    await displayPaymentSheet();

  }

}
//paymentIntentModel create payment intent(amount,currency,customer Id)
//keySecret create EphemeralKey (customerId)==>Header ==>stripeVersion
//initPaymentSheet(merchantDisplayName,paymentIntentClientSecret,ephemeralKeySecret)
//displayPaymentSheet