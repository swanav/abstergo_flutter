import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';

import 'package:abstergo_flutter/res/keys.dart';
import 'package:abstergo_flutter/pages/profile/ProfileHeadIcon.dart';
import 'package:abstergo_flutter/pages/profile/ProfileHeadText.dart';
import 'package:abstergo_flutter/pages/profile/ProfileBodyItem.dart';

class ProfileContent extends StatelessWidget {
  final PersonalInfo personalInfo;

  ProfileContent(this.personalInfo);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: <Widget>[
              ProfileHeadIcon(personalInfo.name),
              ProfileHeadText(personalInfo.name, Keys.NAME),
              ProfileHeadText(
                  personalInfo.enrollmentNumber, Keys.ENROLLMENT_NUMBER),
              ProfileHeadText(personalInfo.getSemester(), Keys.SEMESTER),
              ProfileHeadText(personalInfo.getBranch(), Keys.BRANCH),
            ],
          ),
        ),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints vpConstraints) {
            return Container(
              width: vpConstraints.maxWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ProfileBodyItem(
                    header: "Father",
                    value: personalInfo.fatherName,
                    icon: Icons.face,
                  ),
                  Divider(color: Colors.grey, height: 2.0),
                  ProfileBodyItem(
                    header: "Mobile",
                    value: personalInfo.studentContact.mobile,
                    secValue: personalInfo.parentContact.mobile,
                    icon: Icons.phone,
                  ),
                  Divider(color: Colors.grey, height: 2.0),
                  ProfileBodyItem(
                    header: "Email",
                    value: personalInfo.studentContact.email,
                    secValue: personalInfo.parentContact.email,
                    icon: Icons.mail,
                  ),
                  Divider(color: Colors.grey, height: 2.0),
                  ProfileBodyItem(
                    header: "Correspondance Address",
                    address: personalInfo.correspondenceAddress,
                    icon: Icons.home,
                  ),
                  Divider(color: Colors.grey, height: 2.0),
                  ProfileBodyItem(
                    header: "Permanent Address",
                    address: personalInfo.permanentAddress,
                    icon: Icons.home,
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }
}
