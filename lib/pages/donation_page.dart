import 'package:flutter/material.dart';
import 'package:taximeter/utils/donation_util.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  void onBtnClick(SkuID skuID) {
    print("Button Clicked! $skuID");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DonationButton(btnOnClick: onBtnClick, btnText: "Donation 1000", skuID: SkuID.donation_1000),
              DonationButton(btnOnClick: onBtnClick, btnText: "Donation 5000", skuID: SkuID.donation_5000),
              DonationButton(btnOnClick: onBtnClick, btnText: "Donation 10000", skuID: SkuID.donation_10000),
            ],
          ),
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DonationButton(btnOnClick: onBtnClick, btnText: "Donation 50000", skuID: SkuID.donation_50000),
              DonationButton(btnOnClick: onBtnClick, btnText: "Advertisement Remove", skuID: SkuID.ad_remove)
            ],
          )
        ],
      )
    );
  }
}

class DonationButton extends StatefulWidget {
  const DonationButton({super.key, required this.btnOnClick, required this.btnText, required this.skuID});

  final Function btnOnClick;
  final String btnText;
  final SkuID skuID;

  @override
  State<StatefulWidget> createState() => _DonationButtonState();
}

class _DonationButtonState extends State<DonationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widget.btnOnClick(widget.skuID),
      child: Column(
        children: [
          skuIcon(),
          const SizedBox(height: 10.0),
          Text(widget.btnText),
        ],
      ),
    );
  }

  Icon skuIcon() {
    IconData skuIcon;
    switch(widget.skuID) {
      case SkuID.ad_remove:
        skuIcon = Icons.money_off;
      case SkuID.donation_1000:
        skuIcon = Icons.local_drink;
      case SkuID.donation_5000:
        skuIcon = Icons.coffee;
      case SkuID.donation_10000:
        skuIcon = Icons.fastfood;
      case SkuID.donation_50000:
        skuIcon = Icons.dinner_dining;
    }

    return Icon(
      skuIcon,
      size: 75.0,
    );
  }
}