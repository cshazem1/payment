part of 'strip_payment_cubit.dart';

sealed class StripPaymentState {}

final class StripPaymentInitial extends StripPaymentState {}
final class StripPaymentLoading extends StripPaymentState {}
final class StripPaymentSuccess extends StripPaymentState {}
final class StripPaymentFailure extends StripPaymentState {
  String error ;
  StripPaymentFailure(this.error);


}

