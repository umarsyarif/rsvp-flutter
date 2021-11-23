import 'package:kopiek_resto/presentation/theme/theme.dart';
import 'package:flutter/material.dart';

class CustomFlatButton extends StatelessWidget {
  final Color backgroundColor;
  final String label;
  final double? width;
  final GestureTapCallback onPressed;

  const CustomFlatButton({Key? key,required this.backgroundColor,required this.label, this.width,required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width??MediaQuery.of(context).size.width,
      child: TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            )
        ),
        child: Text(
          label,
          style: whiteTextStyle.copyWith(fontWeight: bold),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
