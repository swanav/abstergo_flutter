import 'package:flutter/material.dart';

class SGPA extends StatelessWidget {
  final num sgpa;

  SGPA(this.sgpa);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.grey.withAlpha(70),
          style: BorderStyle.solid,
          width: 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          child: sgpa.isNaN
              ? Text("Awaited")
              : Text(
                  sgpa.toStringAsPrecision(3),
                  style: TextStyle(
                    fontSize: 18.0, 
                    fontWeight: FontWeight.w300, 
                    color: Colors.black,
                    
                  ),
                ),
        ),
      ),
    );
  }
}
