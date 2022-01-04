
import 'package:flutter/material.dart';
import 'package:java_code_app/route/route.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/spacing.dart';
import 'package:java_code_app/thame/text_style.dart';

class CardCoupon extends StatelessWidget {
  const CardCoupon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 158.0,
      padding : const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
      margin: const EdgeInsets.symmetric(horizontal: SpaceDims.sp12),
      child: TextButton(
        onPressed: () => Navigate.toPromoPage(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Diskon",
                  style: TypoSty.heading.copyWith(
                    color: ColorSty.white,
                  ),
                ),
                const SizedBox(width: SpaceDims.sp12),
                Text(
                  "10 %",
                  style: TypoSty.heading.copyWith(
                    fontSize: 36.0,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 1
                      ..color = ColorSty.white,
                  ),
                ),
              ],
            ),
            Text(
              "Lorem ipsum dolor sit amet",
              style: TypoSty.caption.copyWith(color: ColorSty.white),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: ColorSty.primary,
        borderRadius: BorderRadius.circular(7.0),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            ColorSty.primary.withOpacity(0.1),
            BlendMode.dstATop,
          ),
          image: const AssetImage('assert/image/bg_coupon_card.png'),
        ),
      ),
    );
  }
}
