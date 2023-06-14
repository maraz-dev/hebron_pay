// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/core/widgets/widgets.dart';
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
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(20),
          vertical: getProportionateScreenHeight(10),
        ),
        child: Form(
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
                    return null;
                  }),
              SizedBox(height: getProportionateScreenHeight(10)),

              /// Amount TextField
              HpTextFormField(
                  controller: _descriptionController,
                  hintText: 'E.g. 2000',
                  title: 'Amount',
                  onChanged: (value) {},
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  validator: (value) {
                    return null;
                  }),
              SizedBox(height: getProportionateScreenHeight(30)),
              GeneralButton(text: 'Generate Ticket', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}
