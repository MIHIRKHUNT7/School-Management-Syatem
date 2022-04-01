import 'package:flutter/material.dart';

class Tiles extends StatelessWidget {
  const Tiles({
    Key? key,
    required this.color,
  //  required this.imgAssets,
    required this.folderName,
    this.bgColor = Colors.red,
  }) : super(key: key);
  final String folderName;
  final Color color;
 // final String imgAssets;

  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Card(
        elevation: 5,
        color: bgColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
         /* crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,*/
          children: [
            Container(
             // margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
             /* child: Image.asset(
                imgAssets,
                width: 55,
              ),*/
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                folderName,
                style: TextStyle(
                  fontSize: 15,
                  color: color,
                  fontFamily: 'Gilroy-Light',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
