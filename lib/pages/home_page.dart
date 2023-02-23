import 'package:idental_n_patient/cells/hd_cell.dart';
import 'package:idental_n_patient/models/doctor.dart';
import 'package:idental_n_patient/pages/detail_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Doctor> _hDoctors = <Doctor>[];

  _onCellTap(Doctor doctor) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(doctor: doctor, key: null,),
        ));
  }

  @override
  void initState() {
    super.initState();
    _hDoctors = _getHDoctors();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        // physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipPath(
              clipper: DrawClip(),
              child: Container(
                  color: Colors.teal[200],
                  height: 200),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                child: const TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    icon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
              ),
            ),
            
            // Container(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   color: Colors.teal[300],
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 64,
            //       ),
            //       Padding(
            //         padding: const EdgeInsets.all(15),
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.white,
            //             borderRadius: BorderRadius.circular(32),
            //           ),
            //           padding: EdgeInsets.symmetric(horizontal: 16),
            //           child: Center(
            //             child: const TextField(
            //               decoration: InputDecoration(
            //                 border: InputBorder.none,
            //                 hintText: "Search",
            //                 icon: Icon(
            //                   Icons.search,
            //                 ),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       // Expanded(flex: 3,child: Placeholder()),
            //     ],
            //   ),
            // ),
            SizedBox(height: 30,),
            _hDoctorsSection(),
            SizedBox(
              height: 32,
            ),

          ],
        ),
      ),
    );
  }

  /// Highlighted Doctors Section
  SizedBox _hDoctorsSection() {
    return SizedBox(
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemCount: _hDoctors.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(indent: 3),
        itemBuilder: (BuildContext context, int index) => HDCell(
          doctor: _hDoctors[index],
          onTap: () => _onCellTap(_hDoctors[index]),
        ),
      ),
    );
  }


  /// Get Highlighted Doctors List
  List<Doctor> _getHDoctors() {
    List<Doctor> hDoctors = <Doctor>[];
    hDoctors.add(Doctor(
      firstName: 'Albert',
      lastName: 'Alexander',
      image: 'albert.png',
      type: 'Kidney',
      rating: 4.5,
    ));
    hDoctors.add(Doctor(
      firstName: 'Elisa',
      lastName: 'Rose',
      image: 'albert.png',
      type: 'Kidney',
      rating: 4.5,
    ));
    hDoctors.add(Doctor(
      firstName: 'Elisa',
      lastName: 'Rose',
      image: 'albert.png',
      type: 'Kidney',
      rating: 4.5,
    ));
    hDoctors.add(Doctor(
      firstName: 'Elisa',
      lastName: 'Rose',
      image: 'albert.png',
      type: 'Kidney',
      rating: 4.5,
    ));
    return hDoctors;
  }
}
class DrawClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height/2);
    path.cubicTo(size.width/4, 3*(size.height/2), 3*(size.width/4), size.height/2, size.width, size.height*0.9);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}