// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String balance = '10,000';
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Welcome Emeka',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(notificationReadIcon),
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(20)),
        child: Column(
          children: [
            /// Balcance, Withdraw and Deposit Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20),
                  vertical: getProportionateScreenHeight(20)),
              decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Balance',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: kWhiteColor),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$nairaSymbol$balance',
                        style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(color: kWhiteColor),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          eyeSlashIcon,
                          color: kWhiteColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(16)),
                  Row(
                    children: [
                      Expanded(
                        child: TransactionButton(
                          onPressed: () {},
                          text: 'Deposit',
                        ),
                      ),
                      SizedBox(width: getProportionateScreenWidth(20)),
                      Expanded(
                        child: TransactionButton(
                          text: 'Withdraw',
                          onPressed: () {},
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(16)),

            /// Ticket and EOD Button
            SizedBox(height: getProportionateScreenHeight(16)),

            /// Pending Payments
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pending Payments',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: kDarkGrey),
                  ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(16)),

            /// Recent Transactions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Transactions',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        color: kDarkGrey),
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
