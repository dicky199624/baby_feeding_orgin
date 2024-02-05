import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../res/colours.dart';

class FadingText extends StatelessWidget {
  const FadingText (
      this.text,{
        this.colour,
        this.fontSize,
        this.fontWeight,
        this.textAlign,
        this.overflow,
        super.key,
  });

  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? colour;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      softWrap: false,
      overflow: overflow ?? TextOverflow.fade,
      textAlign: textAlign ?? TextAlign.left,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        fontWeight: fontWeight ?? FontWeight.normal,
        color: colour ?? Colours.light,
      ),
    );
  }
}
