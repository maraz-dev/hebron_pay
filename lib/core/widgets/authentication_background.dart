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
        Align(
            alignment: Alignment.topCenter,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(150)),
                child: Image.asset(whiteLogo),
              ),
            )),
        SizedBox(height: getProportionateScreenHeight(55)),
      ],
    );
  }
}

// Text(
//           'HEBRONPAY',
//           style: TextStyle(
//               color: kWhiteColor,
//               fontSize: 36,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'Fira Code'),
//         )