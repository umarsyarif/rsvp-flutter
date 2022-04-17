import 'package:flutter/material.dart';

Future<void> showGambar(BuildContext context,String url)async{
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context)=>Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(url,fit: BoxFit.fitWidth,),
        ],
      ),
    )
  );
}