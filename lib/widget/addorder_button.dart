
import 'package:flutter/material.dart';
import 'package:java_code_app/thame/colors.dart';
import 'package:java_code_app/thame/text_style.dart';

class AddOrderButton extends StatefulWidget {
  final ValueChanged<int> onChange;

  const AddOrderButton({Key? key, required this.onChange}) : super(key: key);

  @override
  _AddOrderButtonState createState() => _AddOrderButtonState();
}

class _AddOrderButtonState extends State<AddOrderButton> {
  int jumlahOrder = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (jumlahOrder != 0)
          TextButton(
            onPressed: () {
              setState(() => jumlahOrder--);
              widget.onChange(jumlahOrder);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(25, 25),
              side: const BorderSide(color: ColorSty.primary, width: 2),
            ),
            child: const Icon(Icons.remove),
          ),
        if (jumlahOrder != 0) Text("$jumlahOrder", style: TypoSty.subtitle),
        TextButton(
          onPressed: () {
            setState(() => jumlahOrder++);
            widget.onChange(jumlahOrder);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: const Size(25, 25),
            primary: ColorSty.white,
            backgroundColor: ColorSty.primary,
          ),
          child: const Icon(Icons.add, color: ColorSty.white),
        )
      ],
    );
  }
}
