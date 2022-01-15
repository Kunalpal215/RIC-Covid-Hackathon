// Importing packages
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// // Importing Services
import 'package:covid_app/services/login_user.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String userMobileNumber = '';

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
      body: SizedBox(
        width: 350,
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
                await loginUser(userMobileNumber, context);
              },
              child: const Text('Get OTP'),
            )
          ],
        ),
      ),
    );
  }
}
