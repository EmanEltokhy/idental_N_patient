import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/shared/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../models/patient.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() :super(AppInitalState());

  static AppCubit get(context) => BlocProvider.of(context);



  PatientModel model = PatientModel();

  // uId: value.user!.uid;
  void getUserData() {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    List<QueryDocumentSnapshot<Map<String, dynamic>>> data = [];
    emit(GetPatientDataLoadingState());

    FirebaseFirestore.instance.collection('Patients')
        .where('uId', isEqualTo: userid).
    get()
        .then((value) {
      print(value.docs.first.data());
      data = value.docs;
      if (data.isEmpty ) {
        emit(GetPatientDataErrorState('User Not Found'));
      }
      else {
        model = PatientModel.fromdoc(data.first);
        if(model !=null){
          emit(GetPatientDataSuccessState(patient: model));
        }else{
          emit(GetPatientDataErrorState('User Not Found'));
        }


      }
    })

        .catchError((error) {
      emit(GetPatientDataErrorState(error.toString()));
    }
    );
  }

  late File profileimage;
  var picker = ImagePicker();
  Future<void> getProfileImage()async{
    emit(GetPatientDataLoadingState());
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null){
      profileimage = File(pickedFile.path);

      print(profileimage.path);
      model=model.copyWith(profileimage: profileimage.path);
      print(model.profileimage);
      emit(ProfileImagePickedSuccessState());
      emit(GetPatientDataSuccessState(patient: model));

    }
    else{

      emit(GetPatientDataSuccessState(patient: model));

    }

  }

  Future<void> uploadProfileImage({
    required String name,
    required String phone,

  }) async {
    if(profileimage!=null){
      // upload image only if there is file
      emit(UpdatePatientDataLoadingState());

      // FirebaseStorage.instance
      //     .ref().child('Dentists/${Uri.file(profileimage.path).pathSegments.last}')
      //     .putFile(profileimage!).then((value){
      //       print('upload result ${value.ref.fullPath}');
      String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('patient_profileimages');
      Reference referenceImageToUpload =referenceDirImages.child(uniqueFileName);
      try{
        await referenceImageToUpload.putFile(File(profileimage.path));
        String url = await referenceImageToUpload.getDownloadURL();
        editData(
          name: name,
          phone: phone,
          profile_image: url,
        );

      }
      catch (error){

      }
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
    }else{
      emit(UpdatePatientDataLoadingState());
      editData(
        name: name,
        phone: phone,

      );

    }

  }


  void editData({
    required String name,
    required String phone,
    String? profile_image,

  }){

    PatientModel patient= PatientModel(
      name: name,
      phone: phone,
      profileimage: profile_image??model.profileimage,
      email: model.email,
      uId: model.uId,
      docid: model.docid,
    );
    FirebaseFirestore.instance.collection('Patients')
        .doc(model.uId).update(patient.toMap()).then((value) {
      getUserData();
    }).catchError((error){
      emit(UpdatePatientDataErrorState(error.toString()));
    });
  }

  void getAllDentists(){
    List<Map<String, dynamic>> Alldentists= [];
    // final userid = FirebaseAuth.instance.currentUser!.uid;
    var collection = FirebaseFirestore.instance.collection('Dentists');
    collection.snapshots().listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Alldentists.add(doc.data());
      }

      emit(GetDentistDataSuccessState(dentists:Alldentists));

    });
  }


}
