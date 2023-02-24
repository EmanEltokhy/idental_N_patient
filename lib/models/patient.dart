import 'package:cloud_firestore/cloud_firestore.dart';

class PatientModel {
  final String? name;
  final String? email;
  final String? phone;

  final String? uId;
  final String? docid;
  final String? profileimage;


  PatientModel({

    this.name,
    this.email,
    this.phone,

    this.uId,
    this.docid,
    this.profileimage,


  });

  factory PatientModel.fromdoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){

    final patient = PatientModel(
      name :doc.data()!['name'],
      email :doc.data()!['email'],
      phone :doc.data()!['phone'],

      uId :doc.data()!['uId'],
      docid :doc.id,
      profileimage: doc.data()!['profileimage'],
    );
    return patient;
  }


PatientModel copyWith({String? name,
    String? email,
    String? phone,

    String? uId,
    String? docid,
    String? profileimage,
  })=>PatientModel(
      name: name??this.name,
      email: email??this.email,
      profileimage: profileimage??this.profileimage,
      uId: uId??this.uId,
      phone: phone??this.phone
  );
  Map<String, dynamic> toMap() {
    return {

      'name': name,
      'email': email,
      'phone': phone??'',

      'uId': uId,
      'docid':docid,
      'profileimage': profileimage??'https://www.gentledental.com/sites/default/files/2020-03/generic-doctor-profile.jpg'

    };
  }
}
