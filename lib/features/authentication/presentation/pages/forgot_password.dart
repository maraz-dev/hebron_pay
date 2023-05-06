import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/size_config.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static const id = '/forgotPassword';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailAddressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(backArrowIcon),
        ),
      ),
      body: const AuthenticationBackground(),
      bottomSheet: AuthenticationBody(
        body: Column(children: [
          Center(
              child: Text(
            'Forgot Password',
            style: Theme.of(context).textTheme.displayMedium,
          )),
          Text(
            "Reset your Password Here",
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          Form(
            child: HpTextFormField(
              controller: _emailAddressController,
              hintText: 'student@stu.cu.edu.ng',
              title: 'Email Address',
              onChanged: (value) {},
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.emailAddress,
              validator: (value) {
                return null;
              },
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          GeneralButton(text: 'Continue', onPressed: () {})
        ]),
      ),
    );
  }
}
