import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/modules/Appointment/cubit/states.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentCubit extends Cubit<AppointmentStates> {

  AppointmentCubit() :super(AppointmentInitalState());

  static AppointmentCubit get(context) => BlocProvider.of(context);

  CalendarFormat _format = CalendarFormat.month;
void Change_format(format) {
  _format = format;
  emit(ChangeClanderFormatState(format: _format));

  }

  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? _currentIndex = 0;
  bool _isWeekend = false;
  bool _dateSelected = false;
  bool _timeSelected = false;
 void Select_day(selectedDay, focusedDay)
{
  _currentDay = selectedDay;
  _focusDay = focusedDay;
  _dateSelected = true;

  //check if weekend is selected
  if (selectedDay.weekday == 5 || selectedDay.weekday == 6) {
    _isWeekend = true;
    _timeSelected = false;
    _currentIndex = null;
  } else {
    _isWeekend = false;
  }
}


void changeIndex(index) {
  _currentIndex = index;
  _timeSelected = true;
}
}