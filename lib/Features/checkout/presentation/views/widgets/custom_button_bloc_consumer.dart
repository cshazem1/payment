import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment/Features/checkout/presentation/manager/strip_payment/strip_payment_cubit.dart';
import 'package:payment/Features/checkout/presentation/views/widgets/thank_you_card.dart';

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
          PaymentIntentInputModel inputModel=PaymentIntentInputModel(amount: "200",currency: "USD");
         context.read<StripPaymentCubit>().makePayment(input:inputModel );
        },);
      },
    );
  }
}
