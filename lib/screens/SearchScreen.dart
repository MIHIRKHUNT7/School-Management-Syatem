import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../database/db_service.dart';
import '../main.dart';
import '../model/userMeta.dart';
import 'AddScreen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

TextEditingController myController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  String a = "";
  late List<User> nb = [];

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

  DbService dbService = DbService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(251, 250, 240, 0.3),
        title: Text(
          'Search Deatils',
          style: TextStyle(
            color: Color.fromRGBO(34, 33, 91, 1),
            fontSize: 16,
            fontFamily: 'Gilroy-Semibold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Column(
              children: [
               /* Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          size: 20,
                          color: Color.fromRGBO(34, 33, 91, 1),
                        ),
                      ),
                      Text(
                        'Search Detail',
                        style: TextStyle(
                          color: Color.fromRGBO(34, 33, 91, 1),
                          fontSize: 16,
                          fontFamily: 'Gilroy-Semibold',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),*/
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextField(
                    onChanged: (b) {
                      a = myController.text;
                      if (a.isNotEmpty) {
                        cont();
                      } else {
                        blank();
                      }
                    },
                    controller: myController,
                    onEditingComplete: cont,
                    decoration: InputDecoration(
                     /* suffixIcon: GestureDetector(
                          onTap: () {
                            blank();
                            myController.text = "";
                          },
                          child: Icon(
                            Icons.cancel_outlined,
                            color: Color.fromRGBO(34, 33, 91, 1),
                            size: 20,
                          )),*/
                      labelText: 'Search  Folder',
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
                _fetchData(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //
  _fetchData() {
    return FutureBuilder<List<User>>(
        future: dbService.getSearch(a),
        builder: (BuildContext context, nb) {
          if (nb.hasData) {
            return _buildDataTable(nb.data!);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    return Container(
      height: (MediaQuery.of(context).size.height),
      child: ListView.builder(
         // padding: EdgeInsets.only(bottom: 220),
          itemCount: nb.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 20),
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
                      child: Container(
                        padding:
                            EdgeInsets.only(right: 20, top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child:    Container(
                                padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      //  flex: 2,
                                      child: Container(
                                        width: double.infinity,
                                        height: 210,
                                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: ListView(
                                          // scrollDirection: Axis.horizontal,
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
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          /*Image.asset(
                                                    nb[index].toJson()["Gender"] as int == 1
                                                        ? "assets/image/Male.png"
                                                        : nb[index].toJson()["Gender"]
                                                    as int ==
                                                        2
                                                        ? "assets/image/Female.png"
                                                        : "assets/image/Transgender.png",
                                                    height: 60,
                                                    width: 60,
                                                  ),*/
                                                          Container(
                                                            child: Container(
                                                              margin:
                                                              EdgeInsets.only(
                                                                  top: 20),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
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
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    ElevatedButton(
                                                                                      onPressed: () {
                                                                                        dbService.deleteUser(nb[index]).then(
                                                                                              (value) {
                                                                                            setState(() {
                                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
                                                                                            });
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
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )),
              ),
            );
          }),
    );
  }
}
