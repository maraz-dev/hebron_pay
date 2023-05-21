import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class TicketDivider extends StatelessWidget {
  const TicketDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: kDarkGrey,
      thickness: 1,
      height: getProportionateScreenHeight(30),
    );
  }
}
