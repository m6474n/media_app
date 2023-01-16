import 'package:flutter/material.dart';
import 'package:tech_media/res/color.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback onPress;
  final Color color, textColor;
final bool loading ;
  const RoundedButton(
      {Key? key,
      required this.title,
      required this.onPress,
       this.loading = false,
      this.textColor = AppColors.whiteColor,
       this.color = AppColors.mainAppColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: loading? null : onPress,
      child: Container(
          height: 50,
     width: double.infinity,

          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(8)),
          child: Center(
              child: loading ? const CircularProgressIndicator(color: Colors.white,): Text(
            title,
            style: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 16, color: textColor),
          ))),
    );
  }
}
