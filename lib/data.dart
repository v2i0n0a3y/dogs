import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

buildTextTitleVariation1(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: GoogleFonts.breeSerif(
        fontSize: 36,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
    ),
  );
}
//
//
const kBoxShadow = [
  BoxShadow(
    color: Colors.black12,
    offset: Offset(0, 3),
    blurRadius: 6,
  ),
];

buildTextSubTitleVariation1(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: GoogleFonts.beVietnamPro(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey[400],
      ),
    ),
  );
}

buildTextSubTitleVariation3(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: GoogleFonts.beVietnamPro(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.pink[400],
      ),
    ),
  );
}
buildRecipeTitle(String text){
  return Padding(
    padding: EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.beVietnamPro(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
buildTextNut2(String text, Color color){
  return Text(
    text,
    style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: color
    ),
  );
}
Widget buildNormalText(String text, double fontSize) {
  return Text(
    text,
    style: GoogleFonts.beVietnamPro(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
    ),
  );
}
