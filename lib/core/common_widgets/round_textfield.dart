import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/utils.dart';
import '../app_colors.dart';

class RoundTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode node;
  final Function(String)? onFieldSubmitted;
  final Widget? prefixIcon;
  final bool? obsecure;
  final Widget? suffixIcon;
  RoundTextField({
    Key? key,
    this.suffixIcon,
    this.obsecure = false,
    this.prefixIcon,
    required this.hintText,
    required this.controller,
    required this.node,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  State<RoundTextField> createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  var fillColor = ValueNotifier<Color>(AppColors.roundTextfieldBColor);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ValueListenableBuilder<Color>(
        valueListenable: fillColor,
        builder: (_, value, child) {
          return TextFormField(
            onTap: () {
              widget.node.addListener(() {
                if (widget.node.hasFocus) {
                  fillColor.value = AppColors.textFieldFocusColor;
                } else {
                  fillColor.value = AppColors.roundTextfieldBColor;
                }
              });
            },
            cursorColor: AppColors.blackColor,
            obscuringCharacter: "*",
            obscureText: widget.obsecure!,
            focusNode: widget.node,
            controller: widget.controller,
            decoration: InputDecoration(
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                hintText: widget.hintText,
                hintStyle:
                    TextStyle(color: AppColors.hintColor, fontSize: 14.sp),
                filled: true,
                fillColor: value,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: BorderSide.none,
                ),
                focusColor: AppColors.blueColor,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.r),
                    borderSide: const BorderSide(color: AppColors.blueColor)),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w)),
            onFieldSubmitted: widget.onFieldSubmitted,
            validator: (value) {
              if (value!.isEmpty) {
                return 'please filled the field';
              } else {
                return null;
              }
            },
          );
        },
      ),
    );
  }
}
