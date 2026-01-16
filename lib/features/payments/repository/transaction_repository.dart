

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../common/app_snackbar.dart';

class TransactionRepository {


  doPaymentWithRazorpay({required BuildContext context,
        required String orderID,
        required Razorpay razorpay,
        required String razorpayId,
        required double price}) async {
    try {
     // String userContactNumber = context.read<UserDetailsCubit>().getUserMobile();
     // String userEmail = context.read<UserDetailsCubit>().getUserEmail();

      //var response = await TransactionRepository().createRazorpayOrder(orderID: orderID, amount: price);
      // if (response[ApiURL.errorKey] == false) {
      //   var razorpayOptions = {
      //     'key': razorpayId,
      //     'amount': price.toString(),
      //     'name': "Nulook",
      //     'description': 'Order Payment',
      //     'order_id': "",
      //     'notes': {'order_id': orderID},
      //     'prefill': {
      //       'contact': "",
      //       'email': "",
      //     },
      //   };
      //
      //   razorpay.open(razorpayOptions);
      // } else {
      //   return {
      //     'error': true,
      //     'message': '',
      //     'status': false,
      //   };
      // }
      // return response;
    } catch (e) {
      AppSnackBar.showError(context , e.toString());
    }
  }

}