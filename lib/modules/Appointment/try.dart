import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idental_n_patient/shared/cubit/cubit.dart';
import 'package:idental_n_patient/shared/cubit/states.dart';

class ScheduleCard extends StatelessWidget {
  const ScheduleCard(
      {super.key, required this.date, required this.day, required this.time});

  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            // color: Config.primaryColor,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$day, $date',
            style: const TextStyle(
                // color: Config.primaryColor,
                ),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            // color: Config.primaryColor,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            time,
            style: const TextStyle(
                // color: Config.primaryColor,
                ),
          ))
        ],
      ),
    );
  }
}

class try2 extends StatelessWidget {
  const try2({super.key});

  // const try2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) => AppCubit()..getUpcomingApps() ,
    child: BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,State){
        if(State is GetAppointmentsSuccessState){
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Upcoming Appointments',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: State.appointments.length,
                    separatorBuilder: (BuildContext context, int index) =>
                    const Divider(indent: 3),
                    itemBuilder: (BuildContext context, int index) => Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin:
                      true ? const EdgeInsets.only(bottom: 20) : EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://th.bing.com/th/id/OIP.i2z-rKyDkWNqHIDo_-PJ8AHaEr?pid=ImgDet&rs=1'),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children:  [
                                    Text(
                                      '${State.appointments[index]['dentistname']}',
                                      style: TextStyle(
                                        color: Colors.teal,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'dentist',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                             ScheduleCard(
                              date:'${State.appointments[index]['date']}',
                              day:  '${State.appointments[index]['day']}',
                              time:  '${State.appointments[index]['time']}',
                            ),
                            const SizedBox(
                              height: 15,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }

      },
    ),);

  }
}
