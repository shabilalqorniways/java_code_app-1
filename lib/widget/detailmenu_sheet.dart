import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class BottomSheetDetailMenu extends StatelessWidget {
  final Widget content;
  final String title;

  const BottomSheetDetailMenu({
    Key? key,
    required this.content,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      padding: const EdgeInsets.symmetric(vertical: SpaceDims.sp12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpaceDims.sp16),
        child: Column(
          children: [
            SizedBox(
              width: 104.0,
              height: 4.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: ColorSty.grey,
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
            const SizedBox(height: SpaceDims.sp16),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text(title, style: TypoSty.title),
            ),
            content,
          ],
        ),
      ),
    );
  }
}
