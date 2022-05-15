// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:mindsocial/utility/my_constant.dart';

class ShowIconButton extends StatelessWidget {
  final IconData iconData;
  final Function() pressFunc;
  final Color? colorIcon;
  const ShowIconButton({
    Key? key,
    required this.iconData,
    required this.pressFunc,
    this.colorIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: pressFunc,
      icon: Icon(
        iconData,
        color: colorIcon ?? MyConstant.active,
        size: 36,
      ),
    );
  }
}
