// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/size_config.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  static const id = "/depositScreen";

  @override
  Widget build(BuildContext context) {
    /// [GlobalKey] to Validate the Sign In form
    final GlobalKey<FormState> _formKey = GlobalKey();

    /// The [TextEditingController] for the Amount TextField
    final TextEditingController _amountController = TextEditingController();
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
          'Deposit',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10),
        ),
        child: Form(
          child: Column(
            children: [
              /// Amount TextField
              HpTextFormField(
                  controller: _amountController,
                  hintText: 'E.g. 2000',
                  title: 'How much do you want to Deposit?',
                  onChanged: (value) {},
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  validator: (value) {
                    return null;
                  }),
              SizedBox(height: getProportionateScreenHeight(30)),
              GeneralButton(text: 'Continue', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
