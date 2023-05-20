import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.ticketDescription,
    required this.ticketAmount,
    this.timeCreated,
    this.dateCreated,
    required this.isDebit,
  });

  final String? ticketDescription;
  final String? ticketAmount;
  final String? timeCreated;
  final String? dateCreated;
  final bool? isDebit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isDebit! ? kErrorColor : kGreenColor)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset(isDebit! ? debitIcon : creditIcon),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ticketDescription!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: kDarkGrey),
              ),
              Container(
                padding: EdgeInsets.all(getProportionateScreenWidth(5)),
                decoration: BoxDecoration(
                    color: kLightGrey, borderRadius: BorderRadius.circular(5)),
                child: Row(
                  children: [
                    SvgPicture.asset(timeIcon),
                    SizedBox(width: getProportionateScreenWidth(7)),
                    Text(
                      '$dateCreated,',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: kDarkGrey),
                    ),
                    Text(' $timeCreated',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: kDarkGrey))
                  ],
                ),
              )
            ],
          ),
          Text(
            '- $ticketAmount',
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: isDebit! ? kErrorColor : kGreenColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}
