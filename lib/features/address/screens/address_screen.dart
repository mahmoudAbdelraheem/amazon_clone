import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/services/address_services.dart';
import 'package:amazon_clone/features/address/widgets/current_address.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../constants/global_variables.dart';
import 'package:pay/pay.dart';

import '../../../providers/user_provider.dart';

class AddressScreen extends StatefulWidget {
  static const routeName = '/address_screen';
  final String totalAmount;
  const AddressScreen({super.key, required this.totalAmount});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();
  String addressToBeUsed = '';
  final AddressServicesImp addressServices = AddressServicesImp();

  @override
  void dispose() {
    _flatController.dispose();
    _areaController.dispose();
    _pincodeController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  //? for payment
  List<PaymentItem> items = [];
  final Future<PaymentConfiguration> _googlePayConfigFuture =
      PaymentConfiguration.fromAsset('gpay.json');

  void onGooglePayResult(paymentResult) {
    if (Provider.of<UserPorvider>(context, listen: false)
        .user
        .address
        .isEmpty) {
      addressServices.saveUserAddress(
        context: context,
        userAddress: addressToBeUsed,
      );
    }
    addressServices.placeOrder(
      context: context,
      userAddress: addressToBeUsed,
      totalSum: double.parse(widget.totalAmount),
    );
  }

  @override
  void initState() {
    super.initState();
    items.add(
      PaymentItem(
        amount: widget.totalAmount,
        label: 'Total Amount',
        status: PaymentItemStatus.final_price,
      ),
    );
  }

  void onPyPressed(String addressFromProvider) {
    addressToBeUsed = "";
    bool isForm = _flatController.text.isNotEmpty ||
        _areaController.text.isNotEmpty ||
        _pincodeController.text.isNotEmpty ||
        _cityController.text.isNotEmpty;

    if (isForm == true) {
      if (formState.currentState!.validate()) {
        addressToBeUsed =
            "${_flatController.text}, ${_areaController.text}, ${_cityController.text} - ${_pincodeController.text}";
      } else {
        throw Exception('Please Enter All Values!');
      }
    } else if (addressFromProvider.isNotEmpty) {
      addressToBeUsed = addressFromProvider;
    } else {
      showSnakBar(context, 'ERROR!');
    }
  }

  void payOnRecivePressed(String addressFromProvider, paymentResult) {
    onPyPressed(addressFromProvider);
    onGooglePayResult(paymentResult);
  }

  @override
  Widget build(BuildContext context) {
    //? get user data
    final address = context.watch<UserPorvider>().user.address;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          leading: const BackButton(color: Colors.black),
          elevation: 0,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          child: Column(
            children: [
              if (address.isNotEmpty) CurrentAddress(address: address),
              Form(
                key: formState,
                child: Column(
                  children: [
                    CustomTextField(
                      myController: _flatController,
                      hintText: 'Flat, House no, Building',
                    ),
                    CustomTextField(
                      myController: _areaController,
                      hintText: 'Area, Street',
                    ),
                    CustomTextField(
                      myController: _pincodeController,
                      hintText: 'Pincode',
                    ),
                    CustomTextField(
                      myController: _cityController,
                      hintText: 'Town/City',
                    ),
                  ],
                ),
              ),
              FutureBuilder<PaymentConfiguration>(
                future: _googlePayConfigFuture,
                builder: (context, snapshot) => snapshot.hasData
                    ? GooglePayButton(
                        onPressed: () => onPyPressed(address),
                        width: double.infinity,
                        height: 50,
                        theme: GooglePayButtonTheme.light,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: items,
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.black87, width: 1),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  onPressed: () {
                    payOnRecivePressed(address, '');
                  },
                  child: const Text(
                    'Pay On Receive',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
