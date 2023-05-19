import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

/// Normal General Button
class GeneralButton extends StatelessWidget {
  const GeneralButton({super.key, required this.text, required this.onPressed});

  final String? text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: kPrimaryColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
          child: Center(
            child: Text(
              text!,
              style: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

/// Second Normal General Button
class SecondGeneralButton extends StatelessWidget {
  const SecondGeneralButton(
      {super.key, required this.text, required this.onPressed});

  final String? text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: kPrimaryColor, width: 3)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
          child: Center(
            child: Text(
              text!,
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

/// General Button when there's an action that has to be performed before it's activated
class InActiveGeneralButton extends StatelessWidget {
  const InActiveGeneralButton({
    super.key,
    required this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: null,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
          child: Center(
            child: Text(
              text!,
              style: const TextStyle(
                  color: kWhiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class LogOutButton extends StatelessWidget {
  const LogOutButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String? text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kErrorColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  text!,
                  style: const TextStyle(
                      color: kWhiteColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: getProportionateScreenWidth(50)),
              SvgPicture.asset(logOutIcon)
            ],
          ),
        ),
      ),
    );
  }
}

/// Transaction Button
class TransactionButton extends StatelessWidget {
  const TransactionButton(
      {super.key, required this.text, required this.onPressed});

  final String? text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: kWhiteColor, borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: getProportionateScreenHeight(10)),
          child: Center(
            child: Text(
              text!,
              style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
