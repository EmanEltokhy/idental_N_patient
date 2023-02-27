import 'package:table_calendar/table_calendar.dart';

abstract class AppointmentStates{}
class AppointmentInitalState extends AppointmentStates{}
class ChangeClanderFormatState extends AppointmentStates{
  final CalendarFormat format;
  ChangeClanderFormatState({required this.format});
}