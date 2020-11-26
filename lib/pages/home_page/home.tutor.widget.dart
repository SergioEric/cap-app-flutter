import 'package:cap_sahagun/helpers/helpers.dart';
import 'package:cap_sahagun/pages/home_page/const.tables.dart';
import 'package:cap_sahagun/pages/home_page/section.widget.dart';
import 'package:cap_sahagun/pages/meeting_page/meeting.page.students.dart';
import 'package:cap_sahagun/pages/meeting_page/meeting.page.tutors.dart';
import 'package:cap_sahagun/pages/subject_page/subject.page.dart';
import 'package:flutter/material.dart';

class HomeTutors extends StatelessWidget {
  const HomeTutors();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      crossAxisSpacing: 10,
      padding: EdgeInsets.all(10),
      // mainAxisSpacing: 15,
      childAspectRatio: 6 / 3,
      // childAspectRatio: 9.1 / 7, //-> ~1.3
      children: [
        Section(
          title: "Encuentros - Materiales",
          imagePath: "assets/icons/materiales.png",
          description: removeChar(descriptionMeetings),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => MeetingPageTutors()),
            );
          },
        ),
        Section(
          title: "Materias",
          imagePath: "assets/icons/materiales.png",
          description: removeChar(descriptionSubjects),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => SubjectPage()),
            );
          },
        ),
        // Section(
        //   title: "Matricula",
        //   imagePath: "assets/icons/materiales.png",
        //   description: removeChar(descriptionEnrollment),
        // ),
        Section(
          title: "Pagos",
          imagePath: "assets/icons/materiales.png",
          description: removeChar(fakeDescription),
        ),
      ],
    );
  }
}
