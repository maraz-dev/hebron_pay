import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class AuthenticationBody extends StatelessWidget {
  const AuthenticationBody({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
        onClosing: () {},
        enableDrag: false,
        builder: (context) {
          return Container(
            color: kPrimaryColor,
            child: Container(
              width: double.infinity,
              height: SizeConfig.screenHeight! * 0.7,
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(31),
                  vertical: getProportionateScreenHeight(30)),
              decoration: const BoxDecoration(
                  color: kWhiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: body,
            ),
          );
        });
  }
}
