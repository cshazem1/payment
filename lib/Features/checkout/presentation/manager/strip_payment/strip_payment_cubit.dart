import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment/Features/checkout/data/repo/checkout_repo.dart';

part 'strip_payment_state.dart';

class StripPaymentCubit extends Cubit<StripPaymentState> {
  StripPaymentCubit(this.checkOutRepo) : super(StripPaymentInitial());
  final CheckOutRepo checkOutRepo;

  Future makePayment({required PaymentIntentInputModel input }) async {
    emit(StripPaymentLoading());
 var response= await  checkOutRepo.makePayment(input);
    response.fold((failure) {
      emit(StripPaymentFailure(failure.errMessages));
    }, (success) {
emit(StripPaymentSuccess());
    },);

}
@override
  void onChange(Change<StripPaymentState> change) {
log(change.toString());

    super.onChange(change);
  }
}
