
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment extends StatefulWidget {
  const RazorpayPayment({super.key});

  @override
  State<RazorpayPayment> createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  final TextEditingController keyController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController orderIdController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  // new keys
  // Razorpay_mct_key : QrND7cXRkTkXBn
  // Test API Key: rzp_test_S311Wpz3K0t7oF
  // Razor pay_ Secret: tMy78KgBBwbBvFVszGlFw6pe

  String merchantKeyValue = "rzp_test_S311Wpz3K0t7oF";
  String amountValue = "100";
  String orderIdValue = "01020304";
  String mobileNumberValue = "9861962003";

  late Razorpay razorpay ;

  @override
  void initState() {
    razorpay = Razorpay();
    keyController.text = merchantKeyValue;
    amountController.text = amountValue;
    orderIdController.text = orderIdValue;
    mobileNumberController.text = mobileNumberValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razorpay Payment Integration"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              RZPEditText(
                controller: keyController,
                textInputType: TextInputType.text,
                hintText: 'Enter Key',
                labelText: 'Merchant Key',
              ),
              RZPEditText(
                controller: amountController,
                textInputType: TextInputType.number,
                hintText: 'Enter Amount',
                labelText: 'Amount',
              ),
              RZPEditText(
                controller: orderIdController,
                textInputType: TextInputType.text,
                hintText: 'Enter Order Id',
                labelText: 'Order Id',
              ),
              RZPEditText(
                controller: mobileNumberController,
                textInputType: TextInputType.number,
                hintText: 'Enter Mobile Number',
                labelText: 'Mobile Number',
              ),
              Container(
                margin: EdgeInsets.fromLTRB(12.0, 0, 12.0, 0),
                child: Text(
                  '* Note - In case of TPV the orderId is mandatory.',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: RZPButton(
                      widthSize: 200.0,
                      onPressed: () {
                        merchantKeyValue = keyController.text;
                        amountValue = amountController.text;

                        razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                        razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                        razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                        razorpay.open(getPaymentOptions());
                      },
                      labelText: 'Standard Checkout Pay',
                    ),
                  ),
                  // Expanded(
                  //   child: RZPButton(
                  //     widthSize: 200.0,
                  //     onPressed: () {
                  //       merchantKeyValue = keyController.text;
                  //       amountValue = amountController.text;
                  //       mobileNumberValue = mobileNumberController.text;
                  //       orderIdValue = orderIdController.text;
                  //
                  //       razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                  //       razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                  //       razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                  //       razorpay.open(getTurboPaymentOptions());
                  //     },
                  //     labelText: 'Turbo Pay',
                  //   ),
                  // ),
                ],
              ),
              RZPEditText(
                controller: mobileNumberController,
                textInputType: TextInputType.number,
                hintText: 'Enter Mobile Number',
                labelText: 'Mobile Number',
              ),
              RZPButton(
                widthSize: 200.0,
                labelText: "Link New Upi Account",
                onPressed: () {
                  mobileNumberValue = mobileNumberController.text;

                  // razorpay.upiTurbo.linkNewUpiAccount(customerMobile: mobileNumberValue,
                  //     color: "#ffffff",
                  //     onSuccess: (List<UpiAccount> upiAccounts) {
                  //       print("Successfully Onboarded Account : ${upiAccounts.length}");
                  //     },
                  //     onFailure:(Error error) { ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text("Error : ${error.errorDescription}")));}
                  //);
                },
              ),
              RZPButton(
                widthSize: 200.0,
                labelText: "Manage Upi Account",
                onPressed: () {
                  mobileNumberValue = mobileNumberController.text;

                  // razorpay.upiTurbo.manageUpiAccounts(customerMobile: mobileNumberValue,
                  //     color: "#ffffff",
                  //     onFailure:(Error error) { ScaffoldMessenger.of(context).showSnackBar(
                  //         SnackBar(content: Text("Error : ${error.errorDescription}")));}
                  //);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Map<String, Object> getPaymentOptions() {
    return {
      'key': '$merchantKeyValue',
      'amount': int.parse(amountValue),
      'name': 'NuLook',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': '$mobileNumberValue',
        'email': 'test@razorpay.com'
      },
      'external': {
        'wallets': ['paytm']
      }
    };
  }

  Map<String, Object> getTurboPaymentOptions() {
    return {
      'amount': int.parse(amountValue),
      'currency': 'INR',
      'prefill':{
        'contact':'$mobileNumberValue',
        'email':'test@razorpay.com'
      },
      'theme':{
        'color':'#0CA72F'
      },
      'send_sms_hash':true,
      'retry':{
        'enabled':false,
        'max_count':4
      },
      'key': '$merchantKeyValue',
      'order_id':'$orderIdValue',
      'disable_redesign_v15': false,
      'experiments.upi_turbo':true,
      'ep':'https://api-web-turbo-upi.ext.dev.razorpay.in/test/checkout.html?branch=feat/turbo/tpv'
    };
  }


  //Handle Payment Responses

  void handlePaymentErrorResponse(PaymentFailureResponse response){

    /** PaymentFailureResponse contains three values:
     * 1. Error Code
     * 2. Error Description
     * 3. Metadata
     **/
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response){

    /** Payment Success Response contains three values:
     * 1. Order ID
     * 2. Payment ID
     * 3. Signature
     **/
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response){
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message){
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }
}

class RZPButton extends StatelessWidget {
  String labelText;
  VoidCallback onPressed;
  double widthSize = 100.0;

  RZPButton(
      {required this.widthSize,
        required this.labelText,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthSize,
      height: 50.0,
      margin: EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 12.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          labelText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.indigoAccent),
        ),
      ),
    );
  }
}

class RZPEditText extends StatelessWidget {
  String hintText;
  String labelText;
  TextInputType textInputType;
  TextEditingController controller;

  RZPEditText(
      {required this.textInputType,
        required this.hintText,
        required this.labelText,
        required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.fromLTRB(16.0, 0, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey.shade400, // 👉 Border color
          width: 1.5,                  // 👉 Border width
        ),
        borderRadius: BorderRadius.circular(8), // optional
      ),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,
        style: TextStyle(),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}