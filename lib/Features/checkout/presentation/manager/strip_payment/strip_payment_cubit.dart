import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'strip_payment_state.dart';

class StripPaymentCubit extends Cubit<StripPaymentState> {
  StripPaymentCubit() : super(StripPaymentInitial());
}
