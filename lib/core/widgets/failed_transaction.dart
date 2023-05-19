import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/size_config.dart';

class FailedTransactionScreen extends StatelessWidget {
  const FailedTransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(90)),
              child: Image.asset(failedTransaction),
            ),
            SizedBox(height: getProportionateScreenHeight(20)),
            Text(
              'Transaction Unsuccessful',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(60)),
              child: Text(
                successTranText,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(40)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: GeneralButton(text: 'Try Again', onPressed: () {}),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(10)),
              child: SecondGeneralButton(
                  text: 'Go to Dashboard', onPressed: () {}),
            )
          ],
        ),
      ),
    );
  }
}
