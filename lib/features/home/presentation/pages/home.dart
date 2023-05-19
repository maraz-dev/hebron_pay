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
          Padding(
            padding: EdgeInsets.only(right: getProportionateScreenWidth(20)),
            child: GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(notificationReadIcon),
            ),
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
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
                        color: kDarkGrey),
                  ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(10)),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kLightGrey)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(pendingIcon),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Chicken and Chips',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: kDarkGrey),
                      ),
                      const Text('The Time')
                    ],
                  ),
                  Text(
                    '- Amount',
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(color: kErrorColorTransparent, fontSize: 16),
                  )
                ],
              ),
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
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'See all',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 16,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w400,
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
