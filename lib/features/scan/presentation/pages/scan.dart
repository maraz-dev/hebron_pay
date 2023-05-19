import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/success_transaction.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/failed_transaction.dart';
import '../../../../core/widgets/widgets.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenHeight(20),
            vertical: getProportionateScreenHeight(100)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            Center(
              child: Image.asset(
                scanImage,
                scale: 4,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Text(
              'Scan QR Code to Receive \nPayment',
              style: Theme.of(context).textTheme.displayMedium!,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10),
                  horizontal: getProportionateScreenWidth(20)),
              child: Text(
                "Click the button below to scan the code on the sender’s receipt using your device camera. ",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: kDarkGrey),
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(30)),
              child: GeneralButton(
                text: 'Scan Code',
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FailedTransactionScreen();
                  }));
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
