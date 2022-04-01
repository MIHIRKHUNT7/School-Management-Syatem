import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/database/db_service.dart';
import 'package:school_management_system/model/userMeta.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../main.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({Key? key, this.user, this.isEditMode = false})
      : super(key: key);
  final User? user;
  final bool isEditMode;

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  late DateTime initialDate;

  late User user;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController _DateOfBirthController = TextEditingController();
  DateTime? _dateOfBirth;

//  bool isDisableButton = true;
  late int a;
  late DbService dbService;

  List<dynamic> gen = [
    {"id": "1", "name": "Male"},
    {"id": "2", "name": "Female"},
    {"id": "3", "name": "Others"}
  ];

  String countryValue = '';
  String stateValue = '';
  String cityValue = '';
  String address = "";

  late String value;

  @override
  void initState() {
    dbService = DbService();

    super.initState();
    user = User(
        UserName: "",
        DOB: "",
        Age: 0,
        Gender: 0,
        IsFavorite: 0,
        CityName: '',
        CountryName: '',
        StateName: '');

    if (user.MobileNumber == null) {
      user.MobileNumber = "";
    }
    if (user.Email == null) {
      user.Email = "";
    }

    if (widget.isEditMode) {
      _DateOfBirthController.text = user.DOB;
      user = widget.user!;
      List<String> n = user.DOB.split("/");
      initialDate = DateTime.parse(n[2] + '-' + n[1] + '-' + n[0]);
    } else {
      initialDate = DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    _formUI() {
      return SingleChildScrollView(
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "UserName",
              "Name",
              "",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }

                return null;
              },
              (onSaved) {
                user.UserName = onSaved.toString().trim();
              },
              focusedBorderWidth: 1,
              borderWidth: 1,
              borderColor: Color.fromRGBO(34, 33, 91, 1),
              labelFontSize: 15,
              labelBold: true,
              paddingLeft: 0,
              borderRadius: 10,
              /* prefixIcon: Icon(Icons.text_fields),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: Color.fromRGBO(34, 33, 91, .5),*/
              textColor: Color.fromRGBO(34, 33, 91, 1),
              borderFocusColor: Color.fromRGBO(34, 33, 91, 1),
              contentPadding: 15,
              fontSize: 15,
              paddingRight: 0,
              initialValue: user.UserName,
            ),
            FormHelper.dropDownWidgetWithLabel(
              context,
              "Gender",
              "--Select--",
              user.Gender,
              gen,
              (onChanged) {
                user.Gender = int.parse(onChanged);
              },
              (onValidate) {
                if (onValidate == null) {
                  return "* Required";
                }
                return null;
              },
              borderRadius: 10,
              paddingRight: 0,
              paddingLeft: 0,
              labelFontSize: 15,
              borderFocusColor: Color.fromRGBO(34, 33, 91, 1),
              borderColor: Color.fromRGBO(34, 33, 91, 1),
              /* prefixIcon: Icon(Icons.male),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: Color.fromRGBO(34, 33, 91, .5),*/
              contentPadding: 15,
              focusedBorderWidth: 1,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Date of Birth",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: TextFormField(
                    onSaved: (d) async {
                      user.DOB = d.toString();
                      user.Age = await a;
                    },
                    decoration: InputDecoration(
                      labelStyle: const TextStyle(
                        fontFamily: 'Gilroy-ExtraBold',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Color.fromRGBO(34, 33, 91, 1),
                      ),
                      contentPadding: EdgeInsets.all(15),
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
                      prefixIcon: const Icon(
                        Icons.date_range_rounded,
                        color: Color.fromRGBO(34, 33, 91, .5),
                      ),
                    ),
                    controller: _DateOfBirthController,
                    keyboardType: TextInputType.name,
                    onTap: () {
                      pickDateOfBirth(context);
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        this.value = value!;
                        return 'Please Select Date';
                      }

                      return null;
                    },
                  ),
                ),
              ],
            ),
            FormHelper.inputFieldWidgetWithLabel(
                context, "MobileNumber", "Mobile Number", "", (onValidate) {
              /*if (onValidate == null || value == null || value.isEmpty) {
                this.value = value!;
                return 'Please Select Date';
              }
              return null;*/
            }, (onSaved) {
              user.MobileNumber = onSaved;
            },
                focusedBorderWidth: 1,
                borderWidth: 1,
                borderColor: Color.fromRGBO(34, 33, 91, 1),
                labelFontSize: 15,
                labelBold: true,
                paddingLeft: 0,
                borderRadius: 10,
                /*prefixIcon: Icon(Icons.add_alert_sharp),
                showPrefixIcon: true,
                prefixIconPaddingLeft: 10,
                prefixIconColor: Color.fromRGBO(34, 33, 91, .5),*/
                textColor: Color.fromRGBO(34, 33, 91, 1),
                borderFocusColor: Color.fromRGBO(34, 33, 91, 1),
                contentPadding: 10,
                fontSize: 15,
                paddingRight: 0,
                isNumeric: true,
                initialValue: user.MobileNumber.toString()),
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "Email",
              "Email",
              "",
              (onValidate) {
                if (onValidate == null) {
                  return "* Required";
                }
                return null;
              },
              (onSaved) {
                user.Email = onSaved.toString().trim();
              },
              initialValue: user.Email.toString(),
              focusedBorderWidth: 1,
              borderWidth: 1,
              borderColor: Color.fromRGBO(34, 33, 91, 1),
              labelFontSize: 15,
              labelBold: true,
              paddingLeft: 0,
              borderRadius: 10,
              /* prefixIcon: Icon(Icons.email),
              showPrefixIcon: true,
              prefixIconPaddingLeft: 10,
              prefixIconColor: Color.fromRGBO(34, 33, 91, .5),*/
              textColor: Color.fromRGBO(34, 33, 91, 1),
              borderFocusColor: Color.fromRGBO(34, 33, 91, 1),
              contentPadding: 15,
              fontSize: 15,
              paddingRight: 0,
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(top: 15),
                  child: Text(
                    "Location",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: CSCPicker(
                    currentCountry: user.CountryName.isNotEmpty
                        ? user.CountryName
                        : '--Country--',
                    currentState: user.StateName.isNotEmpty
                        ? user.StateName
                        : '--State--',
                    currentCity:
                        user.CityName.isNotEmpty ? user.CityName : '--City--',
                    showStates: true,
                    showCities: true,
                    flagState: CountryFlag.ENABLE,
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.white,
                      border: Border.all(
                          color: Color.fromRGBO(34, 33, 91, 1), width: 1),
                    ),
                    disabledDropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.grey.shade200,
                      border: Border.all(
                          color: Color.fromRGBO(34, 33, 91, .5), width: 1),
                    ),
                    countrySearchPlaceholder: "Country",
                    stateSearchPlaceholder: "State",
                    citySearchPlaceholder: "City",
                    countryDropdownLabel: "--Country--",
                    stateDropdownLabel: "--State--",
                    cityDropdownLabel: "--City--",
                    selectedItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    dropdownHeadingStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    dropdownItemStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    dropdownDialogRadius: 10.0,
                    searchBarRadius: 10.0,
                    onCountryChanged: (value) {
                      setState(() {
                        countryValue = value;
                        user.CountryName = countryValue;
                      });
                    },
                    onStateChanged: (value) {
                      setState(() {
                        stateValue = value.toString();
                        user.StateName = stateValue;
                      });
                    },
                    onCityChanged: (value) {
                      setState(
                        () {
                          cityValue = value.toString();
                          user.CityName = cityValue;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: /* isDisableButton
                        ? null
                        :*/
                        () {
                      if (validateAndSave()) {
                        if (widget.isEditMode) {
                          dbService.updateUser(user).then((value) {
                            FormHelper.showSimpleAlertDialog(context, "SQFlite",
                                "Data Modified Successfully ", "Ok", () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            });
                          });
                          globalKey.currentState!.save();
                        } else {
                          dbService.addUser(user).then((value) {
                            FormHelper.showSimpleAlertDialog(context, "SQFlite",
                                "Data added successfully ", "Ok", () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            });
                          });
                          globalKey.currentState!.save();
                        }
                      }
                    },
                    child: const Text(
                      'Submit',
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(106, 140, 142, 1),
                      /* padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),*/
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      //shadowColor: Color.fromRGBO(34, 33, 91, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    _customButton() {}

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(251, 250, 240, 0.3),
        title: Text(
          widget.isEditMode ? 'Edit Details' : "Add Details",
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
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  /*  child: Row(
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
                        widget.isEditMode ? 'Edit Details' : "Add Details",
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
                  ),*/
                ),
                Form(
                  key: globalKey,
                  child: _formUI(),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final newDate = await showDatePicker(
        context: context,
        initialDate: _dateOfBirth ?? initialDate,
        firstDate: DateTime(DateTime.now().year - 100),
        lastDate: DateTime(DateTime.now().year + 1),
        builder: (context, child) => Theme(
              data: ThemeData().copyWith(
                  colorScheme: ColorScheme.light(
                primary: Colors.black,
              )),
              child: child ?? const Text(''),
            ));
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOfBirth = newDate;
      String dob = DateFormat('dd/MM/yyyy').format(newDate);
      _DateOfBirthController.text = dob;
      a = calculateAge(newDate);
    });
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    /*if (user.Gender == 1 && age >= 21) {
      isDisableButton = false;
    } else if (user.Gender == 2 && age >= 18) {
      isDisableButton = false;
    } else if (user.Gender == 3 && age >= 18) {
      isDisableButton = false;
    } else {
      isDisableButton = true;
    }*/

    return age;
  }
}
