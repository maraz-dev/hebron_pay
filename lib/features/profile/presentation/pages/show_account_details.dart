import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/bloc/cubit/user_details_cubit.dart';
import 'package:hebron_pay/core/domain/user_entity.dart';
import 'package:hebron_pay/core/widgets/general_button.dart';
import 'package:hebron_pay/size_config.dart';

import '../../../../core/widgets/normal_textfield.dart';

class ShowAccountDetails extends StatefulWidget {
  const ShowAccountDetails({super.key});

  @override
  State<ShowAccountDetails> createState() => _ShowAccountDetailsState();
}

class _ShowAccountDetailsState extends State<ShowAccountDetails> {
  /// Variable to Hold the User's stuff
  SubAccountEntity? userDetails;

  /// [TextEditingController] Controller to Hold something sha
  final TextEditingController _accountNameController = TextEditingController();

  /// [TextEditingController] Controller to Hold something sha

  final TextEditingController _emailAddressController = TextEditingController();

  /// [TextEditingController] Controller to Hold something sha

  final TextEditingController _mobileNumberController = TextEditingController();

  /// [TextEditingController] Controller to Hold something sha

  final TextEditingController _bankNameController = TextEditingController();

  /// [TextEditingController] Controller to Hold something sha

  final TextEditingController _accountNumberController =
      TextEditingController();

  /// [TextEditingController] Controller to Hold something sha

  final TextEditingController _accountStatusController =
      TextEditingController();

  bool _isLoading = false;

  void _getSubAccountDetails() async {
    setState(() {
      _isLoading = true;
    });
    var accountDetails =
        await BlocProvider.of<UserDetailsCubit>(context).getSubAccoutDetails();
    userDetails = accountDetails;
    setState(() {
      _isLoading = false;
      _accountNameController.text = userDetails!.accountName;
      _emailAddressController.text = userDetails!.email;
      _mobileNumberController.text = userDetails!.mobilenumber;
      _bankNameController.text = userDetails!.bankName;
      _accountNumberController.text = userDetails!.nuban;
      _accountStatusController.text = userDetails!.status;
    });
  }

  @override
  void initState() {
    super.initState();
    _getSubAccountDetails();
  }

  @override
  Widget build(BuildContext context) {
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
          'HebronPay Account Details',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: _isLoading
          ? const Center(
              child: SpinKitRotatingCircle(
              color: kPrimaryColor,
            ))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20)),
                child: Column(
                  children: [
                    SizedBox(height: getProportionateScreenHeight(10)),

                    /// Account Name
                    HpTextFormField(
                        controller: _accountNameController,
                        readOnly: true,
                        hintText: '',
                        title: 'Account Name',
                        onChanged: (value) {},
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    /// Email Address
                    HpTextFormField(
                        controller: _emailAddressController,
                        readOnly: true,
                        hintText: '',
                        title: 'Email Address',
                        onChanged: (value) {},
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    /// Mobile Number
                    HpTextFormField(
                        controller: _mobileNumberController,
                        readOnly: true,
                        hintText: '',
                        title: 'Mobile Number',
                        onChanged: (value) {},
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    /// Bank Account Name
                    HpTextFormField(
                        controller: _bankNameController,
                        readOnly: true,
                        hintText: '',
                        title: 'Bank Account Name',
                        onChanged: (value) {},
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    /// Bank Account Number
                    HpTextFormField(
                        controller: _accountNumberController,
                        readOnly: true,
                        hintText: '',
                        title: 'Bank Account Number',
                        onChanged: (value) {},
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    /// Account Status
                    HpTextFormField(
                        controller: _accountStatusController,
                        readOnly: true,
                        hintText: '',
                        title: 'Account Status',
                        onChanged: (value) {},
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.text,
                        validator: (value) {
                          return null;
                        }),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    GeneralButton(
                        text: 'Copy Account Number',
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                                  text: _accountNumberController.text))
                              .then((_) => showSuccessSnackBar(
                                  context, 'Account Number Copied'))
                              .catchError((e) =>
                                  showErrorSnackBar(context, e.toString()));
                        })
                  ],
                ),
              ),
            ),
    );
  }
}
