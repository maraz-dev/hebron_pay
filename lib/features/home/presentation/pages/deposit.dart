// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/size_config.dart';

import '../bloc/fund_wallet_cubit/fund_wallet_cubit.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  static const id = "/depositScreen";

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  /// [GlobalKey] to Validate the Sign In form
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// The [TextEditingController] for the Amount TextField
  final TextEditingController _amountController = TextEditingController();

  /// Boolean for Loading Button
  bool _isLoading = false;

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
          'Deposit',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocConsumer<FundWalletCubit, FundWalletState>(
        listener: (context, state) {
          if (state is FundWalletSuccess) {
            showSuccessSnackBar(context, "Funds Deposited Successfully");
            Navigator.pop(context);
          }
          if (state is FundWalletFailure) {
            showErrorSnackBar(context, (state).errorMessage);
          }
        },
        builder: (context, state) {
          if (state is FundWalletLoading) {
            _isLoading = true;
          } else {
            _isLoading = false;
          }
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(20),
              vertical: getProportionateScreenHeight(10),
            ),
            child: Form(
              key: _formKey,
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
                        if (value!.isEmpty) {
                          return 'Amount field cannot be empty';
                        }
                        return null;
                      }),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  GeneralButton(
                    text: 'Continue',
                    onPressed: _fundWallet,
                    isLoading: _isLoading,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _fundWallet() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await BlocProvider.of<FundWalletCubit>(context).fundWallet({
      "amount": double.parse(_amountController.text),
    });
  }
}
