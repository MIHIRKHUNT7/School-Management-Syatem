import 'package:flutter/material.dart';
import 'package:school_management_system/screens/AddScreen.dart';
import 'package:school_management_system/screens/FavoriteScreen.dart';
import 'package:school_management_system/screens/SearchScreen.dart';
import 'package:school_management_system/screens/ViewScreen.dart';
import 'package:school_management_system/screens/aboutUs.dart';


import 'customui/tiles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'School Management System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                          child: Row(
                           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Container(
                             // margin: const EdgeInsets.fromLTRB(0, 100, 0, 30),
                              child: Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      splashColor: Color.fromRGBO(65, 94, 182, 1),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AddScreen()),
                                        );
                                      },
                                      child: Tiles(
                                        /*imgAssets: 'assets/icon/blue_folder.png',*/
                                        color: Color.fromRGBO(65, 94, 182, 1),
                                        folderName: 'Add Student',
                                        bgColor: Color.fromRGBO(226, 240, 242, 1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 9.5,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      splashColor: Color.fromRGBO(255, 177, 16, 1),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ViewScreen()),
                                        );
                                      },
                                      child: Tiles(
                                        /*imgAssets: 'assets/icon/yellow_folder.png',*/
                                        color: Color.fromRGBO(65, 94, 182, 1),
                                        folderName: 'Student LIst',
                                        bgColor: Color.fromRGBO(226, 240, 242, 1),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Container(
                             // margin: const EdgeInsets.fromLTRB(0, 0, 0, 9.5),
                              child: Row(
                               // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(20),
                                      splashColor: Color.fromRGBO(172, 64, 64, 1),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SearchScreen()),
                                        );
                                      },
                                      child: Tiles(
                                        /*imgAssets: 'assets/icon/red_folder.png',*/
                                        color: Color.fromRGBO(65, 94, 182, 1),
                                        folderName: 'Search Student',
                                        bgColor: Color.fromRGBO(226, 240, 242, 1),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 9.5,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(20),
                                        splashColor:
                                        Color.fromRGBO(35, 176, 176, 1),
                                        onTap: () {Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => FavoriteScreen()),
                                        );},
                                        child: Tiles(
                                          /*imgAssets: 'assets/icon/cyan_folder.png',*/
                                          color: Color.fromRGBO(65, 94, 182, 1),
                                          folderName: 'Favourite',
                                          bgColor: Color.fromRGBO(226, 240, 242, 1),
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
