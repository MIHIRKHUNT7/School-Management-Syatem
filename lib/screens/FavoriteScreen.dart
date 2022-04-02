import 'dart:ui';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import '../database/db_service.dart';
import '../main.dart';
import '../model/userMeta.dart';
import 'AddScreen.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<User> nb = [];
  late int index;
  DbService dbService = DbService();
  void get() async {
    nb = await dbService.getfav();
    setState(() {});
  }

  void initState() {
    get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(251, 250, 240, 0.3),
        title: Text(
          'Favorite',
          style: TextStyle(
            color: Color.fromRGBO(34, 33, 91, 1),
            fontSize: 16,
            fontFamily: 'Gilroy-Semibold',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 30, right: 30),
        child: ListView(
          children: [
            Column(
              children: [
               /* Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
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
                        "Favorite",
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
      padding: EdgeInsets.only(bottom: 30),
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
                            alignment: Alignment.topRight,
                             padding: EdgeInsets.only(right: 10, top: 20),
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
                                    height: 170,
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
