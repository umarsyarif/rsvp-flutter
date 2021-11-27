import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';

class TextFieldWidget extends StatelessWidget {
  final Key? textFieldKey;
  final String hintText;
  final bool isPasswordField;
  final bool isLoading;
  final int? maxLength;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextInputType typeInput;
  final Icon? sufixIcon;
  final Widget? suffixAction;
  final bool isInputWhite;
  final bool readonly;
  final GestureTapCallback? onTap;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatter;

  const TextFieldWidget(
      {Key? key,
        required this.hintText,
        this.controller,
        this.isPasswordField = false,
        this.typeInput = TextInputType.text,
        this.textFieldKey,
        this.focusNode,
        this.maxLength,
        this.isLoading = false,
        this.isInputWhite = true,
        this.sufixIcon,
        this.suffixAction,
        this.validator,
        this.onSaved,
        this.minLines,
        this.maxLines, this.inputFormatter, this.readonly=false, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: typeInput,
      onSaved: onSaved,
      obscureText: isPasswordField,
      focusNode: focusNode,
      obscuringCharacter: '*',
      minLines: minLines,
      maxLines: maxLines ?? 1,
      readOnly: readonly,
      controller: controller,
      maxLength: maxLength,
      onTap: onTap,
      inputFormatters: inputFormatter??[],
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
          suffixIcon: sufixIcon ?? suffixAction)
          : inputDecorationPrimary.copyWith(
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.white)),
    );
  }
}
