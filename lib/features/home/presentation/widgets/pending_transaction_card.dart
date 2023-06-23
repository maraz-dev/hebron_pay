import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class PendingTransactionCard extends StatelessWidget {
  const PendingTransactionCard({
    super.key,
    required this.ticketDescription,
    required this.ticketAmount,
    this.timeCreated,
    this.dateCreated,
  });

  final String? ticketDescription;
  final String? ticketAmount;
  final String? timeCreated;
  final String? dateCreated;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
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
              SizedBox(
                width: getProportionateScreenWidth(150),
                child: Text(
                  ticketDescription!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: kDarkGrey),
                ),
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
            style: Theme.of(context)
                .textTheme
                .displaySmall!
                .copyWith(color: kErrorColorTransparent, fontSize: 16),
          )
        ],
      ),
    );
  }
}
