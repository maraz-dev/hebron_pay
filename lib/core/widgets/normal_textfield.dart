import 'package:flutter/material.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class HpTextFormField extends StatelessWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  bool readOnly;
  final Function()? onTapped;

  HpTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    required this.onChanged,
    required this.textInputAction,
    required this.textInputType,
    required this.validator,
    this.maxLines,
    this.readOnly = false,
    this.onTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: kPrimaryColor, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: getProportionateScreenHeight(9)),
        TextFormField(
          onTap: onTapped,
          readOnly: readOnly,
          cursorColor: kLightPurple,
          maxLength: maxLines,
          decoration: InputDecoration(hintText: hintText!),
          controller: controller!,
          style: Theme.of(context).textTheme.bodyMedium,
          keyboardType: textInputType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}
