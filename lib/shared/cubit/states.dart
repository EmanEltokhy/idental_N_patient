
import 'dart:async';
import 'dart:io';

import '../../models/patient.dart';
abstract class AppStates {}
class AppInitalState extends AppStates{}
class AppChangeBottomNavBar extends AppStates{}
class GetPatientDataLoadingState extends AppStates{}

class GetPatientDataSuccessState extends AppStates{
  final PatientModel patient;
  GetPatientDataSuccessState({required this.patient});
}

class GetPatientDataErrorState extends AppStates{
  final String error;
  GetPatientDataErrorState(this.error);
}

class ProfileImagePickedSuccessState extends AppStates{}

class ProfileImagePickedErrorState extends AppStates{}

// class UploadProfileImageSuccessState extends AppStates {}
// class UploadProfileImageErrorState extends AppStates {}

class UpdatePatientDataLoadingState extends AppStates{}

class UpdatePatientDataSuccessState extends AppStates{
  final PatientModel patient;
  UpdatePatientDataSuccessState({required this.patient});
}

class UpdatePatientDataErrorState extends AppStates {
  final String error;

  UpdatePatientDataErrorState(this.error);
}

