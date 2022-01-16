// Importing packages
// // Importing Services
import 'package:covid_app/services/login_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String userMobileNumber = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: WillPopScope(
        onWillPop: () async{
          EasyLoading.dismiss();
          return true;
        },
        child: SizedBox(
          width: 350,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Enter your mobile number: '),
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    userMobileNumber = number.phoneNumber!;
                    // print(userMobileNumber);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.DROPDOWN,
                  ),
                  initialValue: number,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputBorder: const OutlineInputBorder(),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await loginUser(userMobileNumber, context);
                    }
                  },
                  child: const Text('Get OTP'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}
