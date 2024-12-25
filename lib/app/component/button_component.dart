import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import '../utils/style.dart';

class ButtonComponent extends StatelessWidget {
  final String? text;
  final String font;
  final double? width;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsets padding;
  final EdgeInsets stylePadding;

  final Size? minimumSize;
  final Color? buttonColor1;
  final Color? buttonColor2;
  final BorderSide? borderSide;
  final double? elevation;
  final double borderRadius;
  final FontWeight? fontWeight;
  final double? prefixIconWidth;
  final VoidCallback? onPressed;
  final VoidCallback? onLongPressed;
  final bool? cancelButton;
  final Color borderColor;

  const ButtonComponent({
    super.key,
    this.text,
    this.borderSide,
    this.elevation = 0.8,
    this.font = primaryFont,
    this.borderRadius = kFontRadius,
    required this.onPressed,
    this.onLongPressed,
    this.prefixIconWidth = 30,
    this.minimumSize = Size.zero,
    this.width = double.infinity,
    this.textColor = Colors.white,
    this.buttonColor1 = lightPrimaryColor,
    this.buttonColor2 = primaryColor,
    this.fontWeight = titleFontWeight,
    this.fontSize = textSmallFontSize,
    this.borderColor = primaryColor,
    this.cancelButton = false,
    this.padding = const EdgeInsets.fromLTRB(
      48,
      24,
      48,
      24,
    ),
    this.stylePadding = const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 14,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kFontRadius),
            gradient: cancelButton == false
                ? LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [buttonColor1!, buttonColor2!],
                  )
                : const LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [kDisabledButtonColor, kDisabledButtonColor],
                  ),
          ),
          width: width,
          child: ElevatedButton(
            onPressed: cancelButton == false ? onPressed : null,
            onLongPress: onLongPressed,
            style: ElevatedButton.styleFrom(
              foregroundColor: textColor,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              minimumSize: minimumSize,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              padding: stylePadding,
              textStyle: GoogleFonts.getFont(
                font,
                fontWeight: fontWeight,
                color: textColor,
                fontSize: fontSize,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Text(
                text ?? "",
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ));
  }
}
