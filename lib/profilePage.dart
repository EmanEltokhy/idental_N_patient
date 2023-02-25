import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:idental_n_patient/shared/components/components.dart';
import 'package:idental_n_patient/shared/cubit/cubit.dart';
import 'package:idental_n_patient/shared/cubit/states.dart';


class profileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    bool showPassword = false;
    bool edit = true;
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    return BlocProvider(
        create:(BuildContext context) => AppCubit()..getUserData(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state){

          },
          builder: (context,state) {


            Size size = MediaQuery.of(context).size;
            if(state is GetPatientDataSuccessState){
              var model = state.patient;
              nameController.text= model.name!;
              phoneController.text = model.phone!;


              return Scaffold(

                body: Container(
                  padding: EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.arrow_back_ios),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Center(
                                child: Text(
                                  "Edit Profile",
                                  style: GoogleFonts.montserrat(
                                      fontSize: 25),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: TextButton(
                                  child: Text("Edit",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 20,
                                        color: Colors.teal,)),
                                  onPressed: () {

                                    AppCubit.get(context).uploadProfileImage(
                                      name: nameController.text,
                                      phone:phoneController.text,


                                    ); }
                              ),
                            )
                          ]
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              // decoration: BoxDecoration(
                              //     border: Border.all(
                              //         width: 4,
                              //         // color: Theme.of(context).scaffoldBackgroundColor),
                              //         color: Color(0xFD4D4D5FA)),
                              //     boxShadow: [
                              //       BoxShadow(
                              //           spreadRadius: 2,
                              //           blurRadius: 10,
                              //           color: Colors.black.withOpacity(0.1),
                              //           offset: Offset(0, 10)
                              //       )
                              //     ],
                              //     shape: BoxShape.circle,
                              //     image: DecorationImage(
                              //         fit: BoxFit.cover,
                              //         image: NetworkImage(
                              //           '${state.dentist.profileimage}'
                              //    )
                              //     )
                              // ),
                              child: CircleAvatar(
                                radius: 64.0,
                                backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                                child: state.patient.profileimage!.startsWith('https')?CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage: NetworkImage(state.patient.profileimage!)

                                ):CircleAvatar(
                                    radius: 60.0,
                                    backgroundImage:  FileImage(File(state.patient.profileimage!))

                                ),
                              ),

                            ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 3,
                                      color: Theme
                                          .of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child:
                                  IconButton(
                                    icon: Icon(Icons.camera_alt_outlined),
                                    color: Colors.teal,
                                    onPressed: (){
                                      AppCubit.get(context).getProfileImage();
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      defaultFormField(

                        controller: nameController,

                        type: TextInputType.name,
                        label: 'NAME',
                        prefix: Icons.person,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      defaultFormField(

                        controller: phoneController,
                        type: TextInputType.phone,
                        label: 'PHONE',
                        prefix: Icons.phone_android,
                        style: GoogleFonts.montserrat(
                            fontSize: 15,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),


                      SizedBox(
                        height: 35,
                      ),
                      defaultButton(size.width, 50.0, "Logout", false, () {
                        print(nameController.text);
                      })
                    ],
                  ),
                ),
              );
            }
            else if(state is GetPatientDataLoadingState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(state is GetPatientDataErrorState ){
              return Center(
                child: Text(state.error),
              );
            }
            else if (state is UpdatePatientDataErrorState){
              return Center(
                child: Text(state.error),
              );
            }
            else{
              return SizedBox();
            }

          },
        )
    );
  }
}
