import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const whiteClr = Color(0xFFC3CDD5);

TextStyle  title(double size){
  return GoogleFonts.poppins(
    fontSize: size,
    color: whiteClr,
    fontWeight: FontWeight.w600
  );
}


TextStyle city(double size){
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w400,
    color: whiteClr,

);
}

TextStyle time(double size){
  return GoogleFonts.poppins(
    fontSize: size,
    color: whiteClr,
    fontWeight: FontWeight.w500

  );
}

TextStyle temp(double size){
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w800,
    color: whiteClr,

  );
}

TextStyle description(double size){
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: whiteClr,

  );
}

TextStyle smallTemp(double size) {
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w600,
    color: whiteClr,

  );
}

TextStyle bottomText(double size){
  return GoogleFonts.poppins(
    fontSize: size,
    fontWeight: FontWeight.w500,
    color: whiteClr
  );
}
