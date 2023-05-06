import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
  });

  final String? title;
  final String? icon;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(10),
                vertical: getProportionateScreenHeight(10)),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(icon!),
                Text(
                  title!,
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 16),
                ),
                SvgPicture.asset(arrowRightIcon)
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10))
        ],
      ),
    );
  }
}
