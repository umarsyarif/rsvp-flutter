import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog{
  CustomDialog._();
  static void showBottomSheet(BuildContext context,Widget child){
    showModalBottomSheet(context: context, builder: (context)=>Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: child,
    ),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
      isScrollControlled: true,

    );
  }
}