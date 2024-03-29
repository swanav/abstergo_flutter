import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';

import 'package:abstergo_flutter/pages/profile/profile_head_icon.dart';
import 'package:abstergo_flutter/pages/profile/profile_head_text.dart';
import 'package:abstergo_flutter/pages/profile/profile_body_item.dart';
import 'package:abstergo_flutter/res/keys.dart';
import 'package:abstergo_flutter/res/icons.dart';

class ProfileContent extends StatelessWidget {
  final PersonalInfo personalInfo;

  ProfileContent(this.personalInfo);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 4.0,
          child: Container(
            color: Colors.orange,
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
        ),
        Expanded(
          child: Container(
            child: ListView(
              children: <Widget>[
                ProfileBodyItem(
                  header: "Father",
                  value: personalInfo.fatherName,
                  icon: AppIcons.PROFILE_FATHER,
                ),
                Divider(color: Colors.grey, height: 2.0),
                ProfileBodyItem(
                  header: "Mobile",
                  value: personalInfo.studentContact.mobile,
                  secValue: personalInfo.parentContact.mobile,
                  icon: AppIcons.PROFILE_MOBILE,
                ),
                Divider(color: Colors.grey, height: 2.0),
                ProfileBodyItem(
                  header: "Email",
                  value: personalInfo.studentContact.email,
                  secValue: personalInfo.parentContact.email,
                  icon: AppIcons.PROFILE_EMAIL,
                ),
                Divider(color: Colors.grey, height: 2.0),
                ProfileBodyItem(
                  header: "Correspondance Address",
                  address: personalInfo.correspondenceAddress,
                  icon: AppIcons.PROFILE_ADDRESS,
                ),
                Divider(color: Colors.grey, height: 2.0),
                ProfileBodyItem(
                  header: "Permanent Address",
                  address: personalInfo.permanentAddress,
                  icon: AppIcons.PROFILE_ADDRESS,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
