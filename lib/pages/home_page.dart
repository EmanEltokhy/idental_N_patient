import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/shared/cubit/cubit.dart';
import 'package:idental_n_patient/shared/cubit/states.dart';

import '../cells/hd_cell.dart';
import 'detail_page.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    _onCellTap(Map<String, dynamic> dentist) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detailpage(dentist: dentist,),
          ));
    }
    return BlocProvider(create: (BuildContext context) => AppCubit()..getAllDentists(),
        child: BlocConsumer<AppCubit,AppStates>(
            listener: (context,state){

            },
            builder: (context,state){
              if(state is GetDentistDataSuccessState){
                var _hDoctors = state.dentists;
                return Scaffold(
                  backgroundColor: Colors.grey[200],
                  body: SingleChildScrollView(
                    // physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipPath(
                          clipper: DrawClip(),
                          child: Container(
                              color: Colors.teal[200],
                              height: 200),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Center(
                            child: const TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                icon: Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Container(
                        //   padding: EdgeInsets.symmetric(vertical: 10),
                        //   color: Colors.teal[300],
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         height: 64,
                        //       ),
                        //       Padding(
                        //         padding: const EdgeInsets.all(15),
                        //         child: Container(
                        //           decoration: BoxDecoration(
                        //             color: Colors.white,
                        //             borderRadius: BorderRadius.circular(32),
                        //           ),
                        //           padding: EdgeInsets.symmetric(horizontal: 16),
                        //           child: Center(
                        //             child: const TextField(
                        //               decoration: InputDecoration(
                        //                 border: InputBorder.none,
                        //                 hintText: "Search",
                        //                 icon: Icon(
                        //                   Icons.search,
                        //                 ),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //       // Expanded(flex: 3,child: Placeholder()),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(height: 30,),


                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          itemCount: _hDoctors.length,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(indent: 3),
                          itemBuilder: (BuildContext context, int index) => HDCell(
                            name: _hDoctors[index]['name'],
                            image: _hDoctors[index]['profileimage'],

                            onTap: () => _onCellTap(_hDoctors[index]),
                          ),
                        ),
                      ],

                    ),
                  ),




                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

            }

          /// Highlighted Doctors Section



        )
    );
  }

}


class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height/2);
    path.cubicTo(size.width/4, 3*(size.height/2), 3*(size.width/4), size.height/2, size.width, size.height*0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}