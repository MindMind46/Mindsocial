// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mindsocial/widgets/show_image.dart';
import 'package:mindsocial/widgets/show_text.dart';
import 'package:mindsocial/widgets/show_text_button.dart';

import '../widgets/show_listtile.dart';

class MyDialog {
  final BuildContext context;
  MyDialog({
    required this.context,
  });

  Future<void> twoWayAction({
    required String title,
    required String subTitle,
    String? label1,
    String? label2,
    Function()? pressFunC1,
    Function()? pressFunC2,
  }) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: ShowListtile(
          title: title,
          widget: SizedBox(
            width: 100,
            child: ShowImage(
              path: 'images/avatar.png',
            ),
          ),
        ),
        content: ShowText(label: subTitle),
        actions: [
          pressFunC1 == null
              ? const SizedBox()
              : ShowTextButton(label: label1!, pressFunc: pressFunC1),
          pressFunC2 == null
              ? const SizedBox()
              : ShowTextButton(label: label2!, pressFunc: pressFunC2),
          ShowTextButton(
              label: 'Cancel',
              pressFunc: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
