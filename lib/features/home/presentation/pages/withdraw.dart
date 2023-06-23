// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/transaction_pin.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/home/domain/entity/account_details_entity.dart';
import 'package:hebron_pay/features/home/domain/entity/bank_entity.dart';
import 'package:hebron_pay/features/home/presentation/bloc/bank_details_cubit/bank_details_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/get_bank_cubit/get_bank_cubit.dart';
import 'package:hebron_pay/features/home/presentation/bloc/withdraw_cubit.dart/withdraw_cubit.dart';
import 'package:hebron_pay/size_config.dart';
import 'package:pinput/pinput.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  static const id = "/withdrawScreen";

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  /// [GlobalKey] to Validate the Sign In form
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// [GlobalKey] to Validate the Sign In form
  final GlobalKey<FormState> _pinFormKey = GlobalKey();

  /// A [TextEditingController] variable to hold the amount to be Withdrawn
  final TextEditingController _amountController = TextEditingController();

  /// A [TextEditingController] variable to hold the amount to be Withdrawn
  final TextEditingController _accountNumberController =
      TextEditingController();

  /// A [TextEditingController] variable to hold the amount to be Withdrawn
  final TextEditingController _narrationController = TextEditingController();

  /// A [TextEditingController] variable to hold the amount to be Withdrawn
  final TextEditingController _pinController = TextEditingController();

  String? errorText;

  /// A [List] of all the available Banks
  List<BankEntity>? _availableBanks;

  void _getBanks() async {
    var bankRes = await BlocProvider.of<GetBankCubit>(context).getBanks();
    _availableBanks = bankRes;
  }

  /// A varirable to hold the User's selected Bank
  BankEntity? _selectedBank;
  AccountDetailsEntity? bankUserDetails;

  bool _isLoading = false;

  bool _proceedToWithdraw = false;

  int maxInputs = 10;

  String? accountName;

  @override
  void initState() {
    super.initState();
    _getBanks();
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
            'Withdraw Funds',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(10),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Narration TextField
                  HpTextFormField(
                      controller: _narrationController,
                      hintText: 'E.g. Saving',
                      title: 'Narration',
                      onChanged: (value) {},
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This Field cannot be Empty';
                        }
                        return null;
                      }),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  /// Amount TextField
                  HpTextFormField(
                      controller: _amountController,
                      hintText: 'E.g. 2000',
                      title: 'How much would you like to Withdraw?',
                      onChanged: (value) {},
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'This Field cannot be Empty';
                        }
                        return null;
                      }),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  /// Bank
                  Text(
                    'Bank Name',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: kPrimaryColor, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: getProportionateScreenHeight(9)),
                  BlocConsumer<GetBankCubit, GetBankState>(
                    listener: (context, state) {
                      if (state is GetBankFailure) {
                        showErrorSnackBar(context, (state).errorMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is GetBankLoading) {
                        _isLoading = true;
                      } else {
                        _isLoading = false;
                      }
                      if (state is GetBankSuccess) {
                        _availableBanks = (state).availaibleBanks;
                      }
                      return _isLoading
                          ? const SpinKitPouringHourGlassRefined(
                              color: kPrimaryColor)
                          : DropdownButtonFormField(
                              isExpanded: true,
                              value: _selectedBank,
                              hint: Text(
                                'Select Bank',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: kLightPurple),
                              ),
                              items: _availableBanks!.map((items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.name),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedBank = value;
                                });
                              },
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Bank Name can't be Empty";
                                }
                                return null;
                              },
                            );
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  /// Account Number
                  HpTextFormField(
                      controller: _accountNumberController,
                      hintText: '1535448799',
                      maxLines: maxInputs,
                      title: 'Account Number',
                      onChanged: (value) async {
                        if (value.length == maxInputs) {
                          FocusScope.of(context).unfocus();
                          bankUserDetails =
                              await BlocProvider.of<BankDetailsCubit>(context)
                                  .getAccountDetails(
                            {
                              "account_number": _accountNumberController.text,
                              "account_bank": _selectedBank!.code.toString()
                            },
                          );
                        }
                      },
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This Field cannot be Empty";
                        }
                        return null;
                      }),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  BlocConsumer<BankDetailsCubit, BankDetailsState>(
                    listener: (context, state) {
                      if (state is BankDetailsFailure) {
                        showErrorSnackBar(context, (state).errorMessage);
                      }
                      if (state is BankDetailsSuccess) {
                        accountName = bankUserDetails!.accountName;
                      }
                    },
                    builder: (context, state) {
                      if (state is BankDetailsLoading) {
                        _isLoading = true;
                      } else {
                        _isLoading = false;
                      }
                      return _isLoading
                          ? const SpinKitPulse(color: kPrimaryColor)
                          : Text(
                              bankUserDetails == null ? "" : accountName!,
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 16),
                            );
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(30)),

                  BlocConsumer<WithdrawCubit, WithdrawState>(
                    listener: (context, state) {
                      if (state is WithdrawSuccess) {
                        Navigator.pop(context);
                        showSuccessSnackBar(
                            context, 'Successfully Withdrawn Funds');
                      }
                      if (state is WithdrawFailure) {
                        showErrorSnackBar(context, (state).errorMessage);
                      }
                    },
                    builder: (context, state) {
                      if (state is WithdrawLoading) {
                        _isLoading = true;
                      } else {
                        _isLoading = false;
                      }
                      return GeneralButton(
                          isLoading: _isLoading,
                          text: _proceedToWithdraw
                              ? 'Withdraw Funds'
                              : "Enter Pin",
                          onPressed: () {
                            if (!_formKey.currentState!.validate()) return;
                            if (_proceedToWithdraw == false) {
                              _showPinBottomSheet(context);
                            } else {
                              _submitWithdraw();
                            }
                          });
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }

  /// Transaction PIN Modal Sheet
  void _showPinBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context);
              errorText = null;
              return false;
            },
            child: Container(
              padding: EdgeInsets.only(
                  top: getProportionateScreenHeight(20),
                  left: getProportionateScreenWidth(20),
                  right: getProportionateScreenWidth(20),
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                color: kWhiteColor,
              ),
              child: Form(
                key: _pinFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        'Enter PIN',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(5)),
                    Text(
                      'Enter your Transaction PIN below to continue',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    errorText == null
                        ? Container()
                        : Center(
                            child: Text(
                            errorText!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: kErrorColor,
                                    fontWeight: FontWeight.bold),
                          )),
                    SizedBox(height: getProportionateScreenHeight(20)),

                    /// Transaction PIN Box
                    Center(
                      child: Pinput(
                        controller: _pinController,
                        length: 4,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        defaultPinTheme: kDefaultPin(context),
                        focusedPinTheme: kFocusedPin(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Field Cannot be Empty';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),
                    GeneralButton(
                        isLoading: _isLoading,
                        text: 'Continue',
                        onPressed: () async {
                          FlutterSecureStorage secureStorage =
                              const FlutterSecureStorage();
                          String? userPin =
                              await secureStorage.read(key: 'userPin');
                          if (!_pinFormKey.currentState!.validate()) return;

                          if (int.parse(userPin!) ==
                              int.parse(_pinController.text)) {
                            setState(() {
                              _proceedToWithdraw = true;
                            });
                            Navigator.pop(context);
                            _pinController.clear();
                          } else {
                            Navigator.pop(context);
                            showErrorSnackBar(context, 'Incorrect Pin');
                            setState(() {
                              _proceedToWithdraw = false;
                            });
                            _pinController.clear();
                          }
                        }),
                    SizedBox(height: getProportionateScreenHeight(20))
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _submitWithdraw() async {
    await BlocProvider.of<WithdrawCubit>(context).withdrawFunds(
      {
        "account_number": _accountNumberController.text.trim(),
        "account_name": _selectedBank!.name,
        "account_bank": _selectedBank!.code,
        "narration": _narrationController.text.trim(),
        "amount": int.parse(_amountController.text.trim())
      },
    );
  }
}
