import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:taximeter/utils/donation_util.dart';
import 'package:taximeter/utils/preference_util.dart';

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
        SnackBar(
          content: Text(AppLocalizations.of(context)!.donation_error_connect),
          duration: const Duration(seconds: 2),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DonationButton(btnOnClick: _onBtnClick, btnText: AppLocalizations.of(context)!.donation_btn_donate_1000, skuID: SkuID.donation_1000),
                DonationButton(btnOnClick: _onBtnClick, btnText: AppLocalizations.of(context)!.donation_btn_donate_5000, skuID: SkuID.donation_5000),
                DonationButton(btnOnClick: _onBtnClick, btnText: AppLocalizations.of(context)!.donation_btn_donate_10000, skuID: SkuID.donation_10000),
              ],
            ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DonationButton(btnOnClick: _onBtnClick, btnText: AppLocalizations.of(context)!.donation_btn_donate_50000, skuID: SkuID.donation_50000),
                DonationButton(btnOnClick: _onBtnClick, btnText: AppLocalizations.of(context)!.donation_btn_ad_remove, skuID: SkuID.ad_remove),
                DonationButton(btnOnClick: _restorePurchase, btnText: AppLocalizations.of(context)!.donation_btn_restore, skuID: null),
              ],
            ),
            const SizedBox(height: 100.0),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(AppLocalizations.of(context)!.donation_info_text),
            )
          ],
        ),
      )
    );
  }

  void _onBtnClick(SkuID skuID) async {
    if(!isStoreEnabled || !mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.donation_error_connect),
          duration: const Duration(seconds: 2),
        )
      );
      return;
    }

    try {
      ProductDetailsResponse productResponse = await InAppPurchase.instance.queryProductDetails({skuID.name});
      PurchaseParam purchaseParam = PurchaseParam(productDetails: productResponse.productDetails[0]);
      InAppPurchase.instance.buyConsumable(purchaseParam: purchaseParam);
    } catch(e) {
      if(mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.donation_error_process),
            duration: const Duration(seconds: 2),
          )
        );
      }
    }
  }

  void _processPurchase(List<PurchaseDetails> purchaseDetailsList) async {
    int successCount = 0;
    for(var purchaseDetail in purchaseDetailsList) {
      if(purchaseDetail.status == PurchaseStatus.error && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.donation_error_process),
            duration: const Duration(seconds: 2),
          )
        );
      } else if((purchaseDetail.status == PurchaseStatus.purchased
          || purchaseDetail.status == PurchaseStatus.restored) && mounted) {
        if(purchaseDetail.productID == SkuID.ad_remove.name) {
          PreferenceUtil().setPrefsValue("ad_remove", true);
        }
        successCount++;
      }

      if(purchaseDetail.pendingCompletePurchase) {
        await InAppPurchase.instance.completePurchase(purchaseDetail);
      }
    }

    if(successCount > 0 && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.donation_purchase_done),
          duration: const Duration(seconds: 2),
        )
      );
    }
  }

  void _restorePurchase() async {
    if(mounted) {
      InAppPurchase.instance.restorePurchases()
        .then((res) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context)!.donation_restore_done),
              duration: const Duration(seconds: 2),
            )
          );
        }
      );
    }
  }
}

class DonationButton extends StatefulWidget {
  const DonationButton({super.key, required this.btnOnClick, required this.btnText, required this.skuID});

  final Function btnOnClick;
  final String btnText;
  final SkuID? skuID;

  @override
  State<StatefulWidget> createState() => _DonationButtonState();
}

class _DonationButtonState extends State<DonationButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async => widget.skuID != null
        ? await widget.btnOnClick(widget.skuID)
        : await widget.btnOnClick(),
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
    if(widget.skuID == null) {
      return const Icon(
        Icons.restore,
        size: 75.0,
      );
    }

    IconData skuIcon;
    switch(widget.skuID!) {
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