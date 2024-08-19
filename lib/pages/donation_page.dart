import 'dart:async';

import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:taximeter/utils/donation_util.dart';

class DonationPage extends StatefulWidget {
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  late StreamSubscription<List<PurchaseDetails>> _purchaseDetailStream;
  bool isStoreEnabled = false;

  @override
  void initState() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _purchaseDetailStream = purchaseUpdated.listen((purchaseDetailsList) {
      _processPurchase(purchaseDetailsList);
    }, onDone: () {
      _purchaseDetailStream.cancel();
    }, onError: (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to connect to Appstore"),
          duration: Duration(seconds: 2),
        )
      );
    }) as StreamSubscription<List<PurchaseDetails>>;

    InAppPurchase.instance.isAvailable().then(
      (isEnabled) => setState(() {isStoreEnabled = true;}
    ));
    super.initState();
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

  void onBtnClick(SkuID skuID) async {
    if(!isStoreEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to connect to Appstore"),
          duration: Duration(seconds: 2),
        )
      );
      return;
    }

    try {
      ProductDetailsResponse productResponse = await InAppPurchase.instance.queryProductDetails({skuID.name});
      PurchaseParam purchaseParam = PurchaseParam(productDetails: productResponse.productDetails[0]);
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    } catch(e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Failed to process purchase"),
          duration: Duration(seconds: 2),
        )
      );
    }
  }

  void _processPurchase(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if(purchaseDetails.status == PurchaseStatus.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to process purchase"),
            duration: Duration(seconds: 2),
          )
        );
      } else if(purchaseDetails.status == PurchaseStatus.purchased
          || purchaseDetails.status == PurchaseStatus.restored) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Thanks for Purchasing!"),
            duration: Duration(seconds: 2),
          )
        );
      }

      if(purchaseDetails.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    });
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
      onTap: () async => await widget.btnOnClick(widget.skuID),
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