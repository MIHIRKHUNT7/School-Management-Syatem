import 'package:flutter/material.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:school_management_system/database/db_service.dart';
import 'package:school_management_system/model/userMeta.dart';

import '../main.dart';
import 'AddScreen.dart';

class SearchScreen  extends StatefulWidget {
  @override
  State<SearchScreen > createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen > {
  DbService dbService = DbService();
  String a = "";
  int? index;
  late List<User> nb = [];
  bool _folded = true;
  TextEditingController myController = TextEditingController();

  void cont() async {
    setState(() {
      a = myController.text.trim();
    });
    if (a.isNotEmpty) {
      nb = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < nb.length; i++) {
          nb[i].toJson()["UserName"];
        }
      });
    }
  }

  void all() async {
    setState(() { });
      nb = await dbService.getUser();
      setState(() {
        for (int i = 0; i < nb.length; i++) {
          nb[i].toJson()["UserName"];
        }
      });
  }

  void blank() async {
    setState(() {
      a = "1234";
    });
    if (a.isNotEmpty) {
      nb = await dbService.getSearch(a);
      setState(() {
        for (int i = 0; i < nb.length; i++) {
          nb[i].toJson()["UserName"];
        }
      });
    } else {
      return null;
    }
  }


  dynamic getSearch() async {
    nb = await dbService.getSearch(a);
    setState(() {
      for (int i = 0; i < nb.length; i++) {
        nb[i].toJson()["UserName"];
      }
    });
  }

  void get() async {
    nb = await dbService.getUser();
    setState(() {});
  }

  void initState() {
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(251, 250, 240, 0.3),
        title: Text(
          'Search Student',
          style: TextStyle(
            color: Color.fromRGBO(34, 33, 91, 1),
            fontSize: 16,
            fontFamily: 'Gilroy-Semibold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
         // color: Colors.white,
          child: Column(
            children: <Widget>[
             /* Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Color(0xff486579),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
              ),*/
              Container(
                margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      child: TextField(
                        onChanged: (b) {


                          a = myController.text;
                          if (a.isNotEmpty) {
                            cont();
                          } else if (a.isEmpty) {
                            blank();
                          } else {
                            all();
                          }
                        },
                        controller: myController,
                        onEditingComplete: cont,
                        decoration: InputDecoration(
                          /*suffixIcon: GestureDetector(
                              onTap: () {
                                blank();
                                myController.text = "";
                              },
                              child: Icon(
                                Icons.cancel_outlined,
                                color: Color.fromRGBO(34, 33, 91, 1),
                                size: 20,
                              ),
                          ),*/
                          labelText: 'Search  Student',
                          labelStyle: const TextStyle(
                            fontFamily: 'Gilroy-ExtraBold',
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Color.fromRGBO(34, 33, 91, 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromRGBO(34, 33, 91, 1),
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromRGBO(34, 33, 91, 1),
                              ),
                              borderRadius: BorderRadius.circular(10)),
                         /* prefixIcon: const Icon(
                            Icons.search,
                            color: Color.fromRGBO(34, 33, 91, 1),
                          ),*/
                        ),
                      ),
                    ),
                    _fetchUser()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  _buildDataTable(List<User> user) {
    return Container(
      height: (MediaQuery.of(context).size.height),
      child: ListView.builder(
          padding: EdgeInsets.only(bottom: 220),
          itemCount: nb.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(bottom: 10),
              child: SizedBox(
                width: double.infinity,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 5,
                    color: Colors.black,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      splashColor: Colors.black54,
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 10, top: 10),
                            child: Container(
                              alignment: Alignment.topRight,
                              child: FavoriteButton(
                                isFavorite:
                                nb[index].IsFavorite == 1 ? true : false,
                                valueChanged: (favbutton) {
                                  if (favbutton == true) {
                                    dbService.setFav(
                                        1, int.parse(nb[index].id.toString()));
                                  }
                                  if (favbutton == false) {
                                    dbService.setFav(
                                        0, int.parse(nb[index].id.toString()));
                                  }
                                },
                              ),
                            ),
                          ),
                          Container(
                            padding:
                            EdgeInsets.only(right: 30, top: 30, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  //  flex: 2,
                                  child: Container(
                                    height: 210,
                                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Student Name : \t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  nb[index]
                                                      .toJson()["UserName"],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 1.0),
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Date of birth : \t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  nb[index].toJson()["DOB"],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.6),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Gender :\t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                nb[index].toJson()["Gender"]
                                                as int ==
                                                    1
                                                    ? const Text(
                                                  " Male",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                      FontWeight
                                                          .w200),
                                                )
                                                    : nb[index].toJson()[
                                                "Gender"]
                                                as int ==
                                                    2
                                                    ? const Text(
                                                  " Female",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                    FontWeight
                                                        .w200,
                                                  ),
                                                )
                                                    : const Text(
                                                  " Other",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                    FontWeight
                                                        .w200,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Age : \t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                  ),
                                                ),
                                                Text(
                                                  (nb[index].toJson()["Age"])
                                                      .toString(),
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.6),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Mobile Number : \t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                    nb[index].toJson()[
                                                    'MobileNumber'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.6),
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Email : \t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                    nb[index].toJson()['Email'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.6),
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "City : \t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                    nb[index]
                                                        .toJson()['CityName'],
                                                    style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromRGBO(
                                                          255, 255, 255, 0.6),
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Country : \t",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text(
                                                  nb[index]
                                                      .toJson()['CountryName'],
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Color.fromRGBO(
                                                        255, 255, 255, 0.6),
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Container(
                                                  margin:
                                                  EdgeInsets.only(
                                                      top: 20),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => AddScreen(
                                                                    isEditMode: true,
                                                                    user: user[index],
                                                                  )));
                                                        },
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: Colors
                                                              .green,
                                                          size: 30,
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          showDialog(
                                                              context:
                                                              context,
                                                              builder:
                                                                  (BuildContext
                                                              contex) {
                                                                return AlertDialog(
                                                                  title:
                                                                  Text("Delete"),
                                                                  content:
                                                                  Text("Do you want to delete this record"),
                                                                  actions: [
                                                                    Row(
                                                                      children: [
                                                                        ElevatedButton(
                                                                          onPressed: () {
                                                                            dbService.deleteUser(nb[index]).then(
                                                                                  (value) {
                                                                                setState(()
                                                                                {
                                                                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                                                                                }
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                          child: Text("Delete"),
                                                                        ),
                                                                        SizedBox(
                                                                          width: 5,
                                                                        ),
                                                                        ElevatedButton(
                                                                          onPressed: () {
                                                                            Navigator.of(context).pop();
                                                                          },
                                                                          child: Text("No"),
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                );
                                                              });
                                                        },
                                                        child: Icon(
                                                          Icons
                                                              .delete_rounded,
                                                          color: Colors
                                                              .red,
                                                          size: 30,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            );
          }),
    );
  }


  _fetchUser() {
    return FutureBuilder<List<User>>(
        future: dbService.getSearch(a),
        builder: (BuildContext context, nb) {
          if (nb.hasData) {
            return _buildDataTable(nb.data!);
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
