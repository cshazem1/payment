import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/Features/checkout/presentation/manager/strip_payment/strip_payment_cubit.dart';
import 'package:payment/Features/checkout/presentation/views/widgets/thank_you_card.dart';
import 'package:payment/core/utils/api_keys.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../../../data/models/payment_intent_input_model.dart';
import '../thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StripPaymentCubit, StripPaymentState>(
      listenWhen:(previous, current) => current is StripPaymentSuccess||current is StripPaymentFailure ,
      listener: (context, state) {
        if (state is StripPaymentSuccess)
          {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
              return ThankYouView();
            },));


          }
        else if(state is StripPaymentFailure)
        {
          Navigator.of(context).pop();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));

        }
      },
      builder: (

          context, state) {
        if(state is StripPaymentLoading){
          return CircularProgressIndicator();

        }
        return CustomButton(text: 'Continue',onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => PaypalCheckoutView(
              sandboxMode: true,
              clientId: "YOUR CLIENT ID",
              secretKey: "YOUR SECRET KEY",
              transactions: const [
                {
                  "amount": {
                    "total": '100',
                    "currency": "USD",
                    "details": {
                      "subtotal": '100',
                      "shipping": '0',
                      "shipping_discount": 0
                    }
                  },
                  "description": "The payment transaction description.",
                  // "payment_options": {
                  //   "allowed_payment_method":
                  //       "INSTANT_FUNDING_SOURCE"
                  // },
                  "item_list": {
                    "items": [
                      {
                        "name": "Apple",
                        "quantity": 4,
                        "price": '10',
                        "currency": "USD"
                      },
                      {
                        "name": "Pineapple",
                        "quantity": 5,
                        "price": '12',
                        "currency": "USD"
                      }
                    ],

                    // Optional
                    //   "shipping_address": {
                    //     "recipient_name": "Tharwat samy",
                    //     "line1": "tharwat",
                    //     "line2": "",
                    //     "city": "tharwat",
                    //     "country_code": "EG",
                    //     "postal_code": "25025",
                    //     "phone": "+00000000",
                    //     "state": "ALex"
                    //  },
                  }
                }
              ],
              note: "Contact us for any questions on your order.",
              onSuccess: (Map params) async {
                log("onSuccess: $params");
                Navigator.pop(context);
              },
              onError: (error) {
                log("onError: $error");
                Navigator.pop(context);
              },
              onCancel: () {
                print('cancelled:');
                Navigator.pop(context);
              },
            ),
          ));


         //  PaymentIntentInputModel inputModel=PaymentIntentInputModel(amount: "200",currency: "USD",customerId: ApiKeys.customerID);
         // context.read<StripPaymentCubit>().makePayment(input:inputModel );
        },);
      },
    );
  }
}
