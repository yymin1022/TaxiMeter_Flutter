import 'package:flutter/material.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  void onBtnClick(String skuID) {
    print("Button Clicked! $skuID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            DonationButton(btnOnClick: onBtnClick, btnText: "Button Text", skuID: "SKU_ID"),
          ],
        ),
      )
    );
  }
}

class DonationButton extends StatefulWidget {
  const DonationButton({super.key, required this.btnOnClick, required this.btnText, required this.skuID});

  final Function btnOnClick;
  final String btnText;
  final String skuID;

  @override
  State<StatefulWidget> createState() => _DonationButtonState();
}

class _DonationButtonState extends State<DonationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => widget.btnOnClick(widget.skuID),
        child: Text(widget.btnText),
    );
  }
}