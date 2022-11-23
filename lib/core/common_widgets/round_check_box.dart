import 'package:beta_tasker/core/app_colors.dart';
import 'package:beta_tasker/data/network/cloud_data_service.dart';
import 'package:beta_tasker/data/network/provider_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../images/icons/icon_image.dart';

class RoundCheckbox extends StatefulWidget {
  final String docId;
  final bool complete;
  String? priority;
  String? proId;
  ProviderServices? provider;
  RoundCheckbox(
      {Key? key,
      required this.docId,
      required this.complete,
      this.priority,
      this.provider,
      this.proId})
      : super(key: key);

  @override
  State<RoundCheckbox> createState() => _RoundCheckboxState();
}

class _RoundCheckboxState extends State<RoundCheckbox>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    var isCheck = ValueNotifier<bool>(widget.complete);

    return InkWell(
      onTap: () async {
        isCheck.value = !isCheck.value;
        if (widget.proId != null) {
          showDialog(
              useSafeArea: true,
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return Center(
                    child: SpinKitFadingCircle(
                  color: AppColors.whiteColor,
                  controller: _controller,
                ));
              });
          await CloudDataService.updateProjectRoundCheckBox(
              isCheck, widget.docId, widget.proId!);
          await widget.provider!.updateCompleteList(widget.proId!);
          await widget.provider!.updateInCompleteList(widget.proId!);
          widget.provider!.calculatePercentage();
          Navigator.pop(context);
        } else {
          CloudDataService.updateRoundCheckBox(isCheck, widget.docId);
        }
      },
      child: ValueListenableBuilder<bool>(
        valueListenable: isCheck,
        builder: (_, value, child) {
          return Container(
            height: 24.h,
            width: 24.w,
            decoration: BoxDecoration(
                color: value ? AppColors.blueColor : AppColors.whiteColor,
                border: Border.all(
                    color: widget.priority == '1'
                        ? Colors.red
                        : widget.priority == '2'
                            ? Colors.orange
                            : widget.priority == '3'
                                ? Colors.yellow
                                : widget.priority == '4'
                                    ? Colors.grey
                                    : AppColors.recentProjectColor2,
                    width: 2.sp),
                borderRadius: BorderRadius.circular(6.r)),
            child: Center(child: Image.asset(IconImage.checkIcon)),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }
}
