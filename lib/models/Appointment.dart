import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment{
  final String? patientemail;
  final String? dentistname;
  final String? date;
  final String? time;
  final String? day;
  final String? docId;

  Appointment({
    this.patientemail,
    this.dentistname,
    this.date,
    this.time,
    this.day,
    this.docId,
  });


  factory Appointment.fromdoc(QueryDocumentSnapshot<Map<String, dynamic>> doc){

    final appointment = Appointment(
      patientemail: doc.data()!['patientemail'],
      dentistname: doc.data()!['dentistname'],
      date: doc.data()!['date'],
      time: doc.data()!['time'],
      day: doc.data()!['day'],
      docId: doc.id
    );
    return appointment;
  }

  Map<String, dynamic> toMap(){
    return {

    'patientemail':patientemail,
    'dentistname':dentistname,
    'date':date,
      'time':time,
      'day':day,
    'docId':docId,

  };
   }


}