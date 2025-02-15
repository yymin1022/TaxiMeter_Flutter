import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:sprintf/sprintf.dart';
import 'package:taximeter/utils/color_util.dart';
import 'package:taximeter/utils/meter_util.dart';

class MeterCostView extends StatefulWidget {
  const MeterCostView({super.key, required this.meterUtil});

  final MeterUtil meterUtil;

  @override
  State<StatefulWidget> createState() => _MeterCostViewState();
}

class _MeterCostViewState extends State<MeterCostView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sprintf(AppLocalizations.of(context)!.meter_cost, [NumberFormat("#,##0").format(widget.meterUtil.meterCost)]),
            style: const TextStyle(
                color: MeterColor.meterTextColorWhite,
                fontSize: 75.0
            ),
          ),
          Text(
              widget.meterUtil.meterCostCounter.toString(),
              style: const TextStyle(
                  color: MeterColor.meterBlue,
                  fontSize: 35.0
              )
          ),
        ],
      ),
    );
  }
}