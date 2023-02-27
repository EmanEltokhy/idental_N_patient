import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment{
  final String? patientname;
  final String? dentistname;
  final String? datetime;
  final String? docId;

  Appointment({
    this.patientname,
    this.dentistname,
    this.datetime,
    this.docId,
});


  factory Appointment.fromdoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){

    final appointment = Appointment(
      patientname: doc.data()!['patientname'],
      dentistname: doc.data()!['dentistname'],
      datetime: doc.data()!['datetime'],
      docId: doc.data()!['docId'],
    );
    return appointment;
  }

  Map<String, dynamic> toMap(){
    return {

     'patientname':patientname,
      'dentistname':dentistname,
      'datetime':datetime,
      'docId':docId,

    };
  }


}