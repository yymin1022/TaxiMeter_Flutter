import 'package:flutter/material.dart';

class DonationPage extends StatelessWidget {
  const DonationPage({super.key});

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