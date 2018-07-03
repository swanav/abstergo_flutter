import 'package:flutter/material.dart';
import 'package:tkiosk/tkiosk.dart';
import 'package:abstergo_flutter/res/styles.dart';

class ProfileBodyItem extends StatelessWidget {
  final String header;
  final String value;
  final String secValue;
  final IconData icon;
  final Address address;

  ProfileBodyItem({this.header, this.value, this.secValue, this.icon, this.address});

  @override
  Widget build(BuildContext context) {
    List<Widget> children;
    if (address != null) {
      children = <Widget>[
        _ProfileBodyHead(this.header),
        _ProfileBodyAddress(this.address),
      ];
    } else if(secValue != null) {
      children = <Widget>[
        _ProfileBodyHead(this.header),
        _ProfileBodyText(this.value),
        _ProfileBodyText(this.secValue),
      ];
    } else {
      children = <Widget>[
        _ProfileBodyHead(this.header),
        _ProfileBodyText(this.value),
      ];
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          _ProfileBodyIcon(this.icon),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ],
      ),
    );
  }
}

class _ProfileBodyIcon extends StatelessWidget {
  final IconData icon;

  _ProfileBodyIcon(this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 8.0,
      ),
      child: Icon(icon),
    );
  }
}

class _ProfileBodyHead extends StatelessWidget {
  final String text;

  _ProfileBodyHead(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: Styles.Profile['body-head'],
      ),
    );
  }
}

class _ProfileBodyText extends StatelessWidget {
  final String text;

  _ProfileBodyText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        text,
        style: Styles.Profile['body'],
      ),
    );
  }
}

class _ProfileBodyAddress extends StatelessWidget {
  final Address add;

  _ProfileBodyAddress(this.add);

  @override
  Widget build(BuildContext context) {

      String address = add.address;
      address = address.split("\t").map((f) => f.trimLeft()).join("");

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              address,
              style: Styles.Profile['body'],
            ),
            Text(add.district.isNotEmpty?
              "${add.district} ${add.city}":"${add.city}",
              style: Styles.Profile['body'],
            ),
            Text(
              "${add.state}-${add.pin}",
              style: Styles.Profile['body'],
            ),
          ],
        ));
  }
}
