
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


buildPinkContainer(String text, String image){
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.pink,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(image, color: Colors.white, height: 30,width: 30,),
        SizedBox(width: 15,),
        Text(
          text,
          style: GoogleFonts.beVietnamPro(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        )
        //Text(, style: const TextStyle(fontSize: 14, color: Colors.white)),
      ],
    ),
  );

}