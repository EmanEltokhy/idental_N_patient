import 'package:idental_n_patient/models/DentistModel.dart';
import 'package:idental_n_patient/models/doctor.dart';
import 'package:idental_n_patient/utils/custom_icons_icons.dart';
import 'package:idental_n_patient/utils/he_color.dart';
import 'package:flutter/material.dart';

class HDCell extends StatelessWidget {
  final String name;
  final String image;
  final Function onTap;

  const HDCell({
    required this.name,
    required this.image,
    required this.onTap,
  }) ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => onTap(),
        child: Container(
            width: 283,
            height: 120,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white)
            ),
            child: Stack(
              children: [
                // Positioned(
                //   left: 10,
                //     top: 10,
                //     bottom: 10,
                //     child: Container(
                //       height: 140,
                //       width: 140,
                //       decoration: BoxDecoration(
                //         color: Colors.white.withOpacity(0.3),
                //         borderRadius: BorderRadius.all(Radius.circular(15)),
                //       ),
                //     )
                // ),
                // Positioned(
                //   left: 10,
                //   top: 10,
                //   bottom: 10,
                //   child: SizedBox(
                //     width: 140,
                //     height: 140,
                //     child: Image(
                //       image: AssetImage('assets/images/bg_shape.png'),
                //     ),
                //   ),
                // ),
                Positioned(
                  top: 25,
                  left: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr.'+'${name}',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(height: 3,),
                      // Row(
                      //   children: [
                      //     SizedBox(width: 6,),
                      //     Text(
                      //       doctor.firstName,
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w700,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // Row(
                      //   children: [
                      //     SizedBox(width: 6,),
                      //     Text(
                      //       doctor.lastName,
                      //       style: TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 20,
                      //         fontWeight: FontWeight.w700,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 16,
                      // ),
                      Row(
                        children: [
                          SizedBox(width:6,),
                          Text(
                            'Dentist',
                            style: TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[350],
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                Positioned(
                  left: 13,
                  bottom: 13,
                  top: 13,
                  child: SizedBox(
                    width: 100,
                    height: 90,
                    child: Hero(
                      tag: name,
                      child: Container(
                        // color: Colors.white,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.grey[350]),
                        child: Image.network('${image}',
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,),
                        // Image(
                        //  backgroundImage: NetworkImage('${image}'),
                        //   // image: AssetImage('assets/images/' + doctor.image),
                        //
                        // ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ),
        );
    }
}