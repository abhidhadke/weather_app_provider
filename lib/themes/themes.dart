import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const whiteClr = Color(0xFFC3CDD5);

TextStyle title(){
  return GoogleFonts.poppins(
    fontSize: 30,
    color: whiteClr,
    fontWeight: FontWeight.w600
  );
}


TextStyle city(){
  return GoogleFonts.poppins(
    fontSize: 60,
    fontWeight: FontWeight.w400,
    color: whiteClr,

);
}

TextStyle time(){
  return GoogleFonts.poppins(
    fontSize: 25,
    color: whiteClr,
    fontWeight: FontWeight.w500

  );
}

TextStyle temp(){
  return GoogleFonts.poppins(
    fontSize: 80,
    fontWeight: FontWeight.w800,
    color: whiteClr,

  );
}

TextStyle description(){
  return GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: whiteClr,

  );
}

TextStyle smallTemp() {
  return GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w600,
    color: whiteClr,

  );
}

TextStyle bottomText(){
  return GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: whiteClr
  );
}
