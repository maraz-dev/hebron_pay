import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/sign_up.dart';
import 'package:hebron_pay/size_config.dart';
import '../../../../core/widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const id = '/loginScreen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// [GlobalKey] to Validate the Sign In form
  final GlobalKey _formKey = GlobalKey();

  /// The [TextEditingController] for the Email Address TextField
  final TextEditingController _emailAddressController = TextEditingController();

  /// The [TextEditingController] for the Password TextField
  final TextEditingController _passwordController = TextEditingController();

  /// Boolean for Password suffix Icon
  final bool _showPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(backArrow),
        ),
      ),
      body: const AuthenticationBackground(),
      bottomSheet: AuthenticationBody(
        body: SingleChildScrollView(
          child: Column(children: [
            Center(
                child: Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.displayMedium,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an Account? ",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, SignUpScreen.id),
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: getProportionateScreenHeight(25)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  ///Email Address
                  HpTextFormField(
                      controller: _emailAddressController,
                      hintText: 'student@stu.cu.edu.ng',
                      title: 'Email Address',
                      onChanged: (value) {},
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        return null;
                      }),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  /// Password
                  HpPasswordFormField(
                    controller: _passwordController,
                    hintText: 'Password',
                    title: 'Password',
                    onChanged: (value) {},
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.text,
                    validator: (value) {
                      return null;
                    },
                    obsureText: _showPassword,
                  ),
                  SizedBox(height: getProportionateScreenHeight(12)),

                  ///Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () =>
                          Navigator.pushNamed(context, SignUpScreen.id),
                      child: Text(
                        'Forgot Password?',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: kErrorColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),

                  /// Sign In Button
                  GeneralButton(text: 'Sign In', onPressed: () {})
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}