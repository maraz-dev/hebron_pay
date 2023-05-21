import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class TicketDetailsProps extends StatelessWidget {
  const TicketDetailsProps({
    super.key,
    required this.propertyName,
    required this.value,
  });

  final String? propertyName;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(getProportionateScreenWidth(3)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$propertyName:',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            value!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: kPrimaryColor),
          ),
        ],
      ),
    );
  }
}
