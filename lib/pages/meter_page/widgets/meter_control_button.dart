import 'package:flutter/material.dart';
import 'package:taximeter/utils/color_util.dart';

class MeterControlButton extends StatefulWidget {
  const MeterControlButton({super.key, required this.btnColor, required this.btnText, required this.onClickFunction});

  final Color btnColor;
  final String btnText;
  final void Function() onClickFunction;

  @override
  State<StatefulWidget> createState() => _MeterControlButtonState();
}

class _MeterControlButtonState extends State<MeterControlButton> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: widget.btnColor
              ),
              child: InkWell(
                onTap: widget.onClickFunction,
                child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text(
                        widget.btnText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: MeterColor.meterBtnText,
                            fontSize: 17.5
                        ),
                      ),
                    )
                ),
              )
          ),
        )
    );
  }
}