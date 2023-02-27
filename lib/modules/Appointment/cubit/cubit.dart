// ignore_for_file: unused_field

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/modules/Appointment/cubit/states.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentCubit extends Cubit<AppointmentStates> {

  AppointmentCubit() :super(AppointmentInitalState());

  static AppointmentCubit get(context) => BlocProvider.of(context);

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



  void Select_day(selectedDay, focusedDay)
  {emit(SelectdayloadingState());
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


}