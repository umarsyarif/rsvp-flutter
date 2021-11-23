import 'package:flutter/material.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';

class TextFieldWidget extends StatelessWidget {
  final Key? textFieldKey;
  final String hintText;
  final bool isPasswordField;
  final bool isLoading;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType typeInput;
  final Icon? sufixIcon;
  final bool isInputWhite;
  final FocusNode? focusNode;

  const TextFieldWidget(
      {Key? key,
        required this.hintText,
        this.controller,
        this.isPasswordField = false,
        this.typeInput = TextInputType.text,
        this.textFieldKey,
        this.focusNode,
        this.isLoading = false,
        this.isInputWhite = true,
        this.sufixIcon,
        this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: typeInput,
      obscureText: isPasswordField,
      focusNode: focusNode,
      obscuringCharacter: '*',
      controller: controller,
      style: isInputWhite
          ? blackTextStyle.copyWith(fontSize: 12)
          : whiteTextStyle.copyWith(fontSize: 12),
      validator: validator,
      decoration: isInputWhite
          ? inputDecoration.copyWith(
          hintText: hintText,
          suffix: isLoading
              ? const SizedBox(
            child: CircularProgressIndicator(),
            height: 21.0,
            width: 21.0,
          )
              : null,
          suffixIcon: sufixIcon)
          : inputDecorationPrimary.copyWith(
          hintText: hintText, hintStyle: const TextStyle(color: Colors.white)),
    );
  }
}
