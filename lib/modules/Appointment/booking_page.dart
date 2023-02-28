import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/success.dart';
import 'package:table_calendar/table_calendar.dart';
import 'booking_datetime_converted.dart';
import '../../button.dart';
import 'cubit/cubits.dart';
import 'cubit/states.dart';

class BookingPage extends StatelessWidget {
  // const BookingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // declaration

    List<int> time = [08,08,09,09,10,10,11,11];
    // String token; //get token for insert booking date and time into database

    //table calendar


    return BlocProvider(
        create: (BuildContext context) => AppointmentCubit(),
        child: BlocConsumer<AppointmentCubit,AppointmentStates>(
            listener: (context,state){

            },
            builder: (context,state){
              Widget _tableCalendar() {
                return TableCalendar(
                  focusedDay: AppointmentCubit.get(context).focusDay,
                  firstDay: DateTime.now(),
                  lastDay: DateTime(2023, 12, 31),
                  calendarFormat: AppointmentCubit.get(context).format,
                  currentDay: AppointmentCubit.get(context).currentDay,
                  rowHeight: 48,
                  calendarStyle: const CalendarStyle(
                    todayDecoration:
                    BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
                  ),
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },
                  onFormatChanged:
                      (format) {
                    AppointmentCubit.get(context).Change_format(format);
                    //*********
                    // setState(() {
                    //   _format = format;
                    // });
                  },
                  onDaySelected: ((selectedDay, focusedDay) {
                    //*********
                    AppointmentCubit.get(context).Select_day(selectedDay, focusedDay);

                  }),
                );
              }
              return Scaffold(

                appBar: AppBar(
                  leading: const Icon(Icons.arrow_back_ios,color: Colors.black),
                  backgroundColor: Colors.white,
                  elevation: 1,
                ),
                body: CustomScrollView(
                  slivers: <Widget>[
                    SliverToBoxAdapter(
                      child: Column(
                        children: <Widget>[
                          _tableCalendar(),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
                            child: Center(
                              child: Text(
                                'Select Consultation Time',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    AppointmentCubit.get(context).isWeekend ?
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 30),
                        alignment: Alignment.center,
                        child: const Text(
                          'Weekend is not available, please select another date',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                        : SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              //****
                              // setState(
                              // () {
                              //   _currentIndex = index;
                              //   _timeSelected = true;
                              // }
                              // );
                              AppointmentCubit.get(context).changeIndex(index);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppointmentCubit.get(context).currentIndex == index
                                      ? Colors.grey
                                      : Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(15),
                                color: AppointmentCubit.get(context).currentIndex== index
                                    ? Colors.teal
                                    : Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${time[index]}:${index%2==0? "00":"30"} PM',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color:
                                  AppointmentCubit.get(context).currentIndex == index ? Colors.white : null,
                                ),
                              ),
                            ),
                          );
                        },
                        childCount: 8,
                      ),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4, childAspectRatio: 1.5),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 80),
                        child: Button(
                          width: double.infinity,
                          title: 'Make Appointment',
                          colors_one : [Colors.grey,Colors.grey],
                          colors_two : [Colors.teal, Color(0xFF80CBC4)],
                          onPressed: () async {
                            //convert date/day/time into string first
                            final getDate = DateConverted.getDate(AppointmentCubit.get(context).currentDay);
                            final getDay = DateConverted.getDay(AppointmentCubit.get(context).currentDay.weekday);
                            final getTime = DateConverted.getTime(AppointmentCubit.get(context).currentIndex!);


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Success(),
                              ),
                            );
                            // }
                          },
                          // disable: _timeSelected && _dateSelected ? false : true,
                          disable: AppointmentCubit.get(context).timeSelected && AppointmentCubit.get(context).dateSelected ? false : true,
                        ),
                      ),
                    ),
                  ],

                ),
              );
            },
         )
);

}
}