
import 'package:flutter/material.dart';
import 'package:kopiek_resto/presentation/theme/theme.dart';

class CustomOutlineButton extends StatelessWidget {
  final Color borderColor;
  final String label;
  final double? width;
  final GestureTapCallback onPressed;

  const CustomOutlineButton({Key? key,required this.borderColor,required this.label, this.width,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??MediaQuery.of(context).size.width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            side: BorderSide(color: borderColor),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: Text(
          label,
          style: whiteTextStyle.copyWith(fontWeight: bold,color: borderColor),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
