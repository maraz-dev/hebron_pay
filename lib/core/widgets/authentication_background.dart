import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class AuthenticationBackground extends StatelessWidget {
  const AuthenticationBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getProportionateScreenHeight(20)),
        const Center(
            child: Text(
          'HEBRONPAY',
          style: TextStyle(
              color: kWhiteColor,
              fontSize: 36,
              fontWeight: FontWeight.bold,
              fontFamily: 'Fira Code'),
        )),
        SizedBox(height: getProportionateScreenHeight(55)),
      ],
    );
  }
}
