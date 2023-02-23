import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  const Button(
      {Key key,
        this.colors_one,
        this.colors_two,
      this.width,
      this.title,
      this.onPressed,
      this.disable})
      : super(key: key);
  // final List<Color> colors_one = [Colors.grey,Colors.white];
  // final List<Color> colors_two = [Colors.teal, Color(0xFF80CBC4)];
  final double width;
  final String title;
  final bool disable; //this is used to disable button
  final Function() onPressed;
  final List<Color> colors_one;
  final List<Color> colors_two;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(side: BorderSide.none)
      ),
      onPressed: disable ? null : onPressed,
      child: Container(
        width: width,
        height: 50.0,
        alignment: AlignmentDirectional.centerEnd,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            gradient: LinearGradient(colors: disable? colors_one:colors_two)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("$title",
                style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            SizedBox(width: 20,),
              Icon(Icons.arrow_forward,color: Colors.white,)


          ],
        ),
      ),
    );
  }
}
