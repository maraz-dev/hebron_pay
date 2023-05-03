import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hebron_pay/constants.dart';
import 'package:hebron_pay/size_config.dart';

class HpPasswordFormField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  bool? obsureText;

  HpPasswordFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.title,
    required this.onChanged,
    required this.textInputAction,
    required this.textInputType,
    required this.validator,
    required this.obsureText,
  });

  @override
  State<HpPasswordFormField> createState() => _HpPasswordFormFieldState();
}

class _HpPasswordFormFieldState extends State<HpPasswordFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title!,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: kPrimaryColor,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: getProportionateScreenHeight(9)),
        TextFormField(
          cursorColor: kLightPurple,
          decoration: InputDecoration(
              hintText: widget.hintText!,
              suffixIcon: IconButton(
                icon: widget.obsureText == true
                    ? SvgPicture.asset(eyeSlash)
                    : SvgPicture.asset(eye),
                onPressed: () {
                  setState(() {
                    widget.obsureText == true
                        ? widget.obsureText = false
                        : widget.obsureText = true;
                    //print(widget.obsureText);
                  });
                },
              )),
          controller: widget.controller!,
          style: Theme.of(context).textTheme.bodyLarge,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          validator: widget.validator,
          obscureText: widget.obsureText!,
          autocorrect: false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}
