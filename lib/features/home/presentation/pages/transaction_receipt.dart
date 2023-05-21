// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/size_config.dart';

class TransactionReceipt extends StatelessWidget {
  const TransactionReceipt({super.key});
  static const id = "/transactionReceipt";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(
            backArrowIcon,
            color: kPrimaryColor,
          ),
        ),
        title: Text(
          'Ticket Details',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
            vertical: getProportionateScreenHeight(10)),
        child: Column(
          children: [
            /// QR Image
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(60)),
              child: Image.asset(qrSample),
            ),
            SizedBox(height: getProportionateScreenHeight(15)),

            /// Details Box
            Container(
              padding: EdgeInsets.all(getProportionateScreenWidth(15)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: kLightGrey),
              child: Column(
                children: [
                  const TicketDetailsProps(
                    propertyName: 'Narration',
                    value: 'Chicken and Chips',
                  ),
                  const TicketDivider(),
                  TicketDetailsProps(
                    propertyName: 'Amount',
                    value: nairaAmount(2000),
                  ),
                  const TicketDivider(),
                  const TicketDetailsProps(
                    propertyName: 'Reference',
                    value: '12TX521577568',
                  ),
                  const TicketDivider(),
                  const TicketDetailsProps(
                    propertyName: 'Date/Time',
                    value: '25-10-2022 8:50PM',
                  ),
                ],
              ),
            ),
            SizedBox(height: getProportionateScreenHeight(30)),
            GeneralButton(text: 'Download Receipt', onPressed: () {}),
            SizedBox(height: getProportionateScreenHeight(10)),
          ],
        ),
      ),
    );
  }
}
