// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
import 'package:hebron_pay/features/dashboard/presentation/pages/dashboard.dart';
import 'package:hebron_pay/features/home/presentation/bloc/generate_ticket_cubit/generate_ticket_cubit.dart';
import 'package:hebron_pay/size_config.dart';

class GenerateTicket extends StatefulWidget {
  const GenerateTicket({super.key});

  static const id = "/generateTicket";

  @override
  State<GenerateTicket> createState() => _GenerateTicketState();
}

class _GenerateTicketState extends State<GenerateTicket> {
  /// [GlobalKey] to Validate the Sign In form
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// The [TextEditingController] for the Description TextField
  final TextEditingController _descriptionController = TextEditingController();

  /// The [TextEditingController] for the Amount TextField
  final TextEditingController _amountController = TextEditingController();
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
          'Generate Ticket',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: BlocConsumer<GenerateTicketCubit, GenerateTicketState>(
        listener: (context, state) {
          if (state is GenerateTicketSuccess) {
            showSuccessSnackBar(context, 'Ticket Successfully Created');
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return DashBoard(
                currentIndex: 0,
              );
            }));
          }
          if (state is GenerateTicketFailure) {
            showErrorSnackBar(context, (state).errorMessage);
          }
        },
        builder: (context, state) {
          if (state is GenerateTicketLoading) {
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
                  /// Description TextField
                  HpTextFormField(
                      controller: _descriptionController,
                      hintText: 'E.g. Rice and Stew',
                      title: 'Description',
                      onChanged: (value) {},
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description Field cannot be Empty';
                        }
                        return null;
                      }),
                  SizedBox(height: getProportionateScreenHeight(10)),

                  /// Amount TextField
                  HpTextFormField(
                      controller: _amountController,
                      hintText: 'E.g. 2000',
                      title: 'Amount (Include Pack if Needed)',
                      onChanged: (value) {},
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Amount Field cannot be Empty';
                        }
                        return null;
                      }),
                  SizedBox(height: getProportionateScreenHeight(30)),
                  GeneralButton(
                    text: 'Generate Ticket',
                    onPressed: _generateTicket,
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

  void _generateTicket() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await BlocProvider.of<GenerateTicketCubit>(context).generateTicket(
      {
        "description": _descriptionController.text.trim(),
        "amount": double.parse(_amountController.text.trim()),
      },
    );
  }
}
