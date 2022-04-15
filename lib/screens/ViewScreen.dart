import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:school_management_system/database/db_service.dart';
import '../main.dart';
import '../model/userMeta.dart';
import 'AddScreen.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  late List<User> nb = [];
  late int index;

  void get() async {
    nb = await dbService.getUser();
    setState(() {});
  }

  @override
  void initState() {
    get();
  }

  DbService dbService = DbService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(251, 250, 240, 0.3),
        title: Text(
         'Viwe Details',
          style: TextStyle(
            color: Color.fromRGBO(34, 33, 91, 1),
            fontSize: 16,
            fontFamily: 'Gilroy-Semibold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
        child: ListView(
          children: [
            Column(
              children: [
                _fetchData(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<User>>(
        future: dbService.getUser(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> user) {
          if (user.hasData) {
            return _buildDataTable(user.data!);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<User> user) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: (MediaQuery.of(context).size.height),
      child: ListView.builder(
          itemCount: nb.length,
          padding: EdgeInsets.only(bottom: 100),
          itemBuilder: (
            BuildContext context,
            int index,
          ) {
            this.index = index;

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
}
