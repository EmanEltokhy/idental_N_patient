import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/shared/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../models/Appointment.dart';
import '../../models/patient.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitalState());

  static AppCubit get(context) => BlocProvider.of(context);

  PatientModel model = PatientModel();
  List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
  // uId: value.user!.uid;
  void getUserData() {
    final userid = FirebaseAuth.instance.currentUser!.uid;

    emit(GetPatientDataLoadingState());

    FirebaseFirestore.instance
        .collection('Patients')
        .where('uId', isEqualTo: userid)
        .get()
        .then((value) {
      print(value.docs.first.data());
      data = value.docs;
      if (data.isEmpty) {
        emit(GetPatientDataErrorState('User Not Found'));
      } else {
        model = PatientModel.fromdoc(data.first);
        if (model != null) {
          emit(GetPatientDataSuccessState(patient: model));
        } else {
          emit(GetPatientDataErrorState('User Not Found'));
        }
      }
    }).catchError((error) {
      emit(GetPatientDataErrorState(error.toString()));
    });
  }

  late File profileimage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    emit(GetPatientDataLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileimage = File(pickedFile.path);

      print(profileimage.path);
      model = model.copyWith(profileimage: profileimage.path);
      print(model.profileimage);
      emit(ProfileImagePickedSuccessState());
      emit(GetPatientDataSuccessState(patient: model));
    } else {
      emit(GetPatientDataSuccessState(patient: model));
    }
  }

  Future<void> uploadProfileImage({
    required String name,
    required String phone,
  }) async {
    if (profileimage != null) {
      // upload image only if there is file
      emit(UpdatePatientDataLoadingState());

      // FirebaseStorage.instance
      //     .ref().child('Dentists/${Uri.file(profileimage.path).pathSegments.last}')
      //     .putFile(profileimage!).then((value){
      //       print('upload result ${value.ref.fullPath}');
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages =
          referenceRoot.child('patient_profileimages');
      Reference referenceImageToUpload =
          referenceDirImages.child(uniqueFileName);
      try {
        await referenceImageToUpload.putFile(File(profileimage.path));
        String url = await referenceImageToUpload.getDownloadURL();
        editData(
          name: name,
          phone: phone,
          profile_image: url,
        );
      } catch (error) {}
      // value.ref.getDownloadURL().then((value) {
      //   print(value);
      //   editData(name: name,
      //     phone: phone,
      //     clinic_name: clinic_name,
      //     clinic_address: clinic_address,
      //     profile_image: value,);
      // }
      // ).catchError((error){
      //   emit(UpdateDentistDataErrorState(error.toString()));
      // });

      // // ).catchError((error){
      // //   emit(UpdateDentistDataErrorState(error.toString()));
      // });
    } else {
      emit(UpdatePatientDataLoadingState());
      editData(
        name: name,
        phone: phone,
      );
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  void editData(
      {
    required String name,
    required String phone,
    String? profile_image,
  }
  ) {
    PatientModel patient = PatientModel(
      name: name,
      phone: phone,
      profileimage: profile_image ?? model.profileimage,
      email: model.email,
      uId: model.uId,
      docid: model.docid,
    );
    FirebaseFirestore.instance
        .collection('Patients')
        .doc(model.uId)
        .update(patient.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdatePatientDataErrorState(error.toString()));
    });
  }

  void getAllDentists() {
    List<Map<String, dynamic>> Alldentists = [];
    // final userid = FirebaseAuth.instance.currentUser!.uid;
    var collection = FirebaseFirestore.instance.collection('Dentists');
    collection.snapshots().listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Alldentists.add(doc.data());
      }

      emit(GetDentistDataSuccessState(dentists: Alldentists));

    });
  }

  void SearchDentist(String query) {
    List<Map<String, dynamic>> dentist_result = [];
    // final userid = FirebaseAuth.instance.currentUser!.uid;
    var collection = FirebaseFirestore.instance.collection('Dentists');
    collection.where('name', isEqualTo: query).snapshots()..listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
       dentist_result.add(doc.data());
         print(doc.data());
      }
      emit(GetsearchDataSuccessState(dentists: dentist_result));
    });
  }



  void getPatientReports(){
    List<Map<String, dynamic>> Allreports= [];
    final useremail = FirebaseAuth.instance.currentUser!.email;
    var collection = FirebaseFirestore.instance.collection('Reports');
    collection.where('patientemail', isEqualTo:useremail ).snapshots().listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Allreports.add(doc.data());

      }

      emit(GetReportSuccessState(Allreports));

    });

  }


  CalendarFormat format = CalendarFormat.month;

  DateTime focusDay = DateTime.now();
  DateTime currentDay = DateTime.now();
  int? currentIndex = 0;
  bool isWeekend = false;
  bool dateSelected = false;
  bool timeSelected = false;

  void Change_format(format) {
    format = format;
    emit(ChangeClanderFormatState(format: format));
  }

  void Select_day(selectedDay, focusedDay) {
    emit(SelectdayloadingState());
    currentDay = selectedDay;
    focusDay = focusedDay;
    dateSelected = true;

    //check if weekend is selected
    if (selectedDay.weekday == 5 || selectedDay.weekday == 6) {
      isWeekend = true;
      timeSelected = false;
      currentIndex = null;
      emit(SelectdaySuccessState());
    } else {
      isWeekend = false;
      emit(SelectdaySuccessState());
    }
  }

  void changeIndex(index) {
    currentIndex = index;
    timeSelected = true;
    emit(ChangeIndexState());
  }

  Appointment app_model = Appointment();
  void AppointmentCreate({
    String? patientemail,
    String? dentistname,
    String? dentistemail,
    String? status,
    required String date,
    required String time,
    required String day,
    // String? docId,
  })
  {
    String id =  FirebaseFirestore.instance.collection('Appointments').doc().id;
    Appointment appmodel = Appointment(
      patientemail: '${FirebaseAuth.instance.currentUser?.email}',
      dentistname: dentistname,
      dentistemail: dentistemail,
      status: status,
      date: date,
      time: time,
      day: day,
      docId: id,
    );

    FirebaseFirestore.instance
        .collection('Appointments')
        .doc(id)
        .set(appmodel.toMap())
        .then((value) {
      emit(pickedAppointmentSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(pickedAppointmentErrorState(error.toString()));
    }
    );
  }

  void getUpcomingApps(){
    List<Map<String, dynamic>> UpcomingAppointments= [];
    final useremail = FirebaseAuth.instance.currentUser!.email;
    var collection = FirebaseFirestore.instance.collection('Appointments');
    collection.where('patientemail', isEqualTo:useremail ).snapshots().listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if(doc['status']=="Approved"){
          UpcomingAppointments.add(doc.data());
        }


      }

      emit(GetAppointmentsSuccessState(appointments: UpcomingAppointments));

    });

  }

}
