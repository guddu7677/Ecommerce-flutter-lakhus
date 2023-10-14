import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class PinPutView extends StatefulWidget {
  TextEditingController otpController;

  PinPutView({
    super.key,
    required this.otpController,
  });

  @override
  State<PinPutView> createState() => _PinPutViewState();
}

class _PinPutViewState extends State<PinPutView> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: textfiledColor,
        border: Border.all(color: Colors.transparent),
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return Pinput(
      onChanged: (value) {
        setState(() {
          widget.otpController.text = value;
        });
      },
      controller: widget.otpController,
      defaultPinTheme: defaultPinTheme,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
