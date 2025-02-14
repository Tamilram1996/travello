import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Database/database_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget loaderWidget() {
  return Center(
      child: Container(
        // color: Colors.white,
        height: 150,
        width: 150,
        alignment: AlignmentDirectional.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          backgroundColor: Colors.white,
//     ),
        ),
      )
  );
}

void toastMessage(BuildContext context, String msg, Color color) {
  FToast fToast = FToast();
  fToast.init(context);
  Widget toast = Container(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: color,
    ),
    child: Row(
      // mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.check,
          color: Colors.white,
        ),
        SizedBox(width: 12.0),
        Expanded(
            child: Text(
              msg,
              style: TextStyle(color: Colors.white),
            ))
      ],
    ),
  );
  return fToast.showToast(
      child: toast,
      toastDuration: Duration(seconds: 3),
      gravity: ToastGravity.TOP);
}

