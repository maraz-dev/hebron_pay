import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/password_validator_card.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/login.dart';
import 'package:hebron_pay/features/authentication/presentation/pages/otp_verification.dart';
import 'package:hebron_pay/features/profile/presentation/pages/terms_and_condition.dart';
import 'package:hebron_pay/password_validator.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/widgets.dart';
import '../bloc/sign_in_cubit/sign_up_cubit_cubit.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const id = '/signUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// A variable to hold the key for the SignUp form
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// The [TextEditingController] for the First Name TextField
  final TextEditingController _firstNameController = TextEditingController();

  /// The [TextEditingController] for the Last Name TextField
  final TextEditingController _lastNameController = TextEditingController();

  /// The [TextEditingController] for the User Name TextField
  final TextEditingController _userNameController = TextEditingController();

  /// The [TextEditingController] for the Email Address TextField
  final TextEditingController _emailController = TextEditingController();

  /// The [TextEditingController] for the Phone Number TextField
  final TextEditingController _phoneNumberController = TextEditingController();

  /// The [TextEditingController] for the Password TextField
  final TextEditingController _passwordController = TextEditingController();

  /// The [TextEditingController] for the Confirm Password TextField
  final TextEditingController _confirmPassController = TextEditingController();

  /// Boolean for Password suffix Icon
  final bool _showPassword = true;

  /// Boolean for Terms and Conditions
  bool? _isAgreed = false;

  /// Is Loading bool
  bool _isLoading = false;

  /// Boolean to show Validate Password Container
  //bool _showValidatePassword = false;

  /// Gender List
  List<String> genders = ['Male', 'Female'];

  /// Selected Gender
  String? _selectedGender;

  /// Selected Date
  DateTime? _selectedDate;

  /// Set the last date to anyone above 16 years
  int lastDate = int.parse(DateTime.now().year.toString()) - 16;

  ///[TextEditingController] for the Date Formfield
  final TextEditingController _dateController = TextEditingController();

  /// Function to show the Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime(lastDate),
        firstDate: DateTime(1990),
        builder: (context, child) {
          return Theme(
              data: Theme.of(context).copyWith(
                  datePickerTheme: const DatePickerThemeData(
                headerBackgroundColor: kPrimaryColor,
              )),
              child: child!);
        },
        lastDate: DateTime(lastDate));

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd')
            .format(_selectedDate ?? DateTime(lastDate))
            .toString();
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      extendBodyBehindAppBar: false,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(backArrowIcon),
        ),
      ),
      body: const AuthenticationBackground(),
      bottomSheet: BlocConsumer<SignUpCubit, SignUpCubitState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return OTPVerification(
                emailAddress: _emailController.text.trim(),
              );
            }));
          }
          if (state is SignUpFailure) {
            final exception = (state.errorMessage);
            showErrorSnackBar(context, exception);
          }
        },
        builder: (context, state) {
          if (state is SignUpLoading) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
          return BottomSheet(
            enableDrag: false,
            onClosing: () {},
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          'Create An Account',
                          style: Theme.of(context).textTheme.displayMedium,
                        )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already a User? ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            GestureDetector(
                              onTap: () =>
                                  Navigator.pushNamed(context, LoginScreen.id),
                              child: Text(
                                'Sign In',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: getProportionateScreenHeight(25)),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// First Name
                              HpTextFormField(
                                  controller: _firstNameController,
                                  hintText: 'Enter First Name',
                                  title: 'First Name',
                                  onChanged: (value) {},
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'First Name field cannot be empty';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              /// Last Name
                              HpTextFormField(
                                  controller: _lastNameController,
                                  hintText: 'Enter Last Name',
                                  title: 'Last Name',
                                  onChanged: (value) {},
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Last Name field cannot be empty';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              /// Email Address
                              HpTextFormField(
                                  controller: _emailController,
                                  hintText: 'student@stu.cu.edu.ng',
                                  title: 'Email Address',
                                  onChanged: (value) {},
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    String pattern =
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                                    if (value!.isEmpty) {
                                      return 'E-mail field cannot be empty';
                                    } else {
                                      RegExp regExp = RegExp(pattern);
                                      if (regExp.hasMatch(value)) {
                                        return null;
                                      } else {
                                        return 'Please use a VALID E-mail address';
                                      }
                                    }
                                  }),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              ///Username
                              HpTextFormField(
                                  controller: _userNameController,
                                  hintText: 'Enter your Unique Username',
                                  title: 'Username',
                                  onChanged: (value) {},
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'User Name field cannot be empty';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              /// Phone Number
                              HpTextFormField(
                                  controller: _phoneNumberController,
                                  hintText: '08012345678',
                                  title: 'Phone Number',
                                  onChanged: (value) {},
                                  maxLines: 11,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.phone,
                                  validator: (value) {
                                    String pattern =
                                        r"(^(?:[+0]9)?[0-9]{10,12}$)";
                                    RegExp regExp = RegExp(pattern);
                                    if (value!.isEmpty) {
                                      return 'First Name field cannot be empty';
                                    } else if (!regExp.hasMatch(value)) {
                                      return 'Please enter a Valid Phone Number';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              /// Date Of Birth
                              HpTextFormField(
                                  controller: _dateController,
                                  hintText: 'Pick your Date of Birth',
                                  title: 'Date of Birth',
                                  readOnly: true,
                                  onTapped: () {
                                    _selectDate(context);
                                  },
                                  onChanged: (value) {},
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.emailAddress,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Date field cannot be empty';
                                    }
                                    return null;
                                  }),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              /// Gender
                              Text(
                                'Gender',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w400),
                              ),
                              SizedBox(height: getProportionateScreenHeight(9)),
                              DropdownButtonFormField(
                                value: _selectedGender,
                                hint: Text(
                                  'Select your Gender',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: kLightPurple),
                                ),
                                items: genders.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Text(items),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGender = value;
                                  });
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Gender field cannot be empty';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              ///Password
                              HpPasswordFormField(
                                controller: _passwordController,
                                hintText: 'Enter Password',
                                title: 'Password',
                                onChanged: (value) {
                                  // setState(() {
                                  //   _showValidatePassword = true;
                                  //   if (value.isEmpty) {
                                  //     setState(() {
                                  //       _showValidatePassword = false;
                                  //     });
                                  //   }
                                  // });
                                },
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  validatePassword(value!);
                                  return null;
                                },
                                obsureText: _showPassword,
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),
                              PasswordValidator(
                                  controller: _passwordController),
                              SizedBox(
                                  height: getProportionateScreenHeight(10)),

                              ///Confirm Password
                              HpPasswordFormField(
                                controller: _confirmPassController,
                                hintText: 'Confirm Password',
                                title: 'Confirm Password',
                                onChanged: (value) {},
                                textInputAction: TextInputAction.done,
                                textInputType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Password field cannot be empty';
                                  } else if (value !=
                                      _passwordController.text) {
                                    return "Password doesn't match";
                                  }
                                  return null;
                                },
                                obsureText: _showPassword,
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(22)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    value: _isAgreed,
                                    onChanged: (value) {
                                      setState(() {
                                        _isAgreed = value;
                                      });
                                    },
                                    activeColor: kPrimaryColor,
                                  ),
                                  SizedBox(
                                      width: getProportionateScreenWidth(0)),
                                  RichText(
                                    text: TextSpan(
                                        text: "I hereby agree to the",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        children: [
                                          TextSpan(
                                            text: " Terms and Conditions\n",
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () =>
                                                  TermsAndConditionScreen.id,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  color: kPrimaryColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                          TextSpan(
                                              text: 'guiding this app.',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium)
                                        ]),
                                  )
                                ],
                              ),
                              SizedBox(
                                  height: getProportionateScreenHeight(20)),
                              _isAgreed == false
                                  ? const InActiveGeneralButton(
                                      text: 'Register')
                                  : GeneralButton(
                                      isLoading: _isLoading,
                                      text: 'Register',
                                      onPressed: () {
                                        _submitSignUp();
                                      }),
                              SizedBox(height: getProportionateScreenHeight(10))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _submitSignUp() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await BlocProvider.of<SignUpCubit>(context).submitSignUp(
      {
        "firstName": _firstNameController.text.trim(),
        "lastName": _lastNameController.text.trim(),
        "userName": _userNameController.text.trim(),
        "email": _emailController.text.trim(),
        "password": _passwordController.text,
        "confirmPassword": _confirmPassController.text,
        "gender": _selectedGender,
        "phoneNumber": _phoneNumberController.text.trim(),
        "dateofBirth": _dateController.text.trim()
      },
    );
  }
}
