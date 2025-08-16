import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";


class Homepage extends StatelessWidget
{
  const Homepage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meal Muse",
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          )),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.tune, size: 15),
          ),
        ],
      ),
    );
  }

}