import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class InputTextField extends StatelessWidget {
  final TextEditingController myController;
  final FocusNode focusNode;
  final FormFieldSetter onFiledSubmittedValue;
  final FormFieldValidator onValidator;
  final TextInputType keyboardType;
  final String hint;
  final bool obscureText;
  final bool enable, autoFocus;

  const InputTextField(
      {Key? key,
      required this.myController,
      required this.focusNode,
      required this.onFiledSubmittedValue,
      required this.onValidator,
      required this.keyboardType,
      required this.hint,
      required this.obscureText,
      this.enable = true,
      this.autoFocus = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextFormField(
        controller: myController,
        focusNode: focusNode,
        onFieldSubmitted: onFiledSubmittedValue,
        validator: onValidator,
        keyboardType: keyboardType,
        enabled: enable,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              height: 0,
              fontSize: 18,
            ),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            border: OutlineInputBorder(
                borderSide:const BorderSide(color: AppColors.textFieldDefaultFocus),
                borderRadius: BorderRadius.circular(8)),
            focusedBorder: OutlineInputBorder(
                borderSide:const BorderSide(color: AppColors.secondaryColor),
                borderRadius: BorderRadius.circular(8)),
            errorBorder: OutlineInputBorder(
                borderSide:const BorderSide(color: AppColors.alertColor),
                borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
                borderSide:
                const BorderSide(color: AppColors.textFieldDefaultBorderColor),
                borderRadius: BorderRadius.circular(8)),
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyText2!.copyWith(
                height: 0,
                color: AppColors.primaryTextTextColor.withOpacity(0.8))),
        obscureText: obscureText,
      ),
    );
  }
}
