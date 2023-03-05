import 'package:flutter/material.dart';

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
              itemCount: 1,
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
                            children: const [
                              Text(
                                'mohamed',
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
                      const ScheduleCard(
                        date: '16/2/2023',
                        day: 'Monday',
                        time: '08:30 PM',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      // doctor part
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Expanded(
                      //       child: OutlinedButton(
                      //         onPressed: () {},
                      //         child: const Text(
                      //           'Cancel',
                      //           style: TextStyle(color: Colors.black),
                      //         ),
                      //       ),
                      //     ),
                      //     const SizedBox(
                      //       width: 20,
                      //     ),
                      //     Expanded(
                      //       child: OutlinedButton(
                      //         style: OutlinedButton.styleFrom(
                      //           // backgroundColor: Config.primaryColor,
                      //         ),
                      //         onPressed: () {},
                      //         child: const Text(
                      //           'Reschedule',
                      //           style: TextStyle(color: Colors.black),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
}
