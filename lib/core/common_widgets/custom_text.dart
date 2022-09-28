import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  String? style;
  CustomText(
      {Key? key,
      required this.text,
      this.color,
      required this.fontSize,
      required this.fontWeight,
      this.textAlign,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case 'inter':
        return Text(
          text,
          textAlign: textAlign,
          style: GoogleFonts.inter(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        );
      case 'gilroy':
        return Text(text,
            textAlign: textAlign,
            style: GoogleFonts.roboto(
              color: color,
              fontSize: fontSize,
              fontWeight: fontWeight,
            ));
      default:
        return Text(
          text,
          textAlign: textAlign,
          style: GoogleFonts.urbanist(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
          ),
        );
    }
  }
}
