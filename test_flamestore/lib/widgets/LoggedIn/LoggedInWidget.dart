import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_flamestore/utils/CurrentUser.dart';
import 'package:test_flamestore/utils/NgrokLink.dart';

import '../StoreCard/StoreCard.dart';

class LoggedInWidget extends StatefulWidget {
  @override
  _LoggedInWidgetState createState() => _LoggedInWidgetState();
}

class _LoggedInWidgetState extends State<LoggedInWidget> {
  bool isAdmin = false;
  String companyName = "";
  String companyAbout = "";
  var _myColor = Colors.blue;
  List<StoreCard> myStoreProduct =  []; //List<StoreCard>(); la creo vuota.

  _LoggedInWidgetState() {
    getCompanyAbout().then((value) {
      setState(() {
        companyAbout = "Azienda " +
            companyName +
            " con Capitale Sociale: " +
            value['Capitale'] +
            "\$ " +
            " con sede in " +
            value['Paese_di_origine'] +
            ", Partita Iva: " +
            value['P_IVA'] +
            ".";
      });
    });
    getCompanyName().then((value) {
      setState(() {
        companyName = value;
      });
    });
    getProductList().then((value) {
      var tmp = jsonDecode(value);
      for (var val in tmp) {
        getProductInfo(val['Codice'], val['Identificativo']).then((value) {
          var cost = Random().nextInt(120).toString();
          print(val['Identificativo']);
          setState(() {
            myStoreProduct.add(StoreCard(
              productName: val['Nome'],
              price: cost,
              rating: double.parse(val['Rating']),
              imageName: value,
              callback: () => postOrder(cost, CurrentUser.userId),
            ));
          });
        });
      }
    });
  }

  Future<String> getCompanyName() async {
    String uri = NgrokLink.link + "/theFlameStore/getCompanyName.php";
    final response = await http.get(Uri.parse(uri), headers:{},);
    return response.body;
  }

  Future<String> getCurrentUser() async {
    String uri = NgrokLink.link + "/theFlameStore/getCompanyName.php";
    final response = await http.get(Uri.parse(uri), headers:{},);
    return response.body;
  }

  Future<Map> getCompanyAbout() async {
    String uri= NgrokLink.link + "/theFlameStore/getCompanyAbout.php";
    final response = await http.get(Uri.parse(uri), headers:{},);
    return json.decode(response.body);
  }

  Future<dynamic> getProductList() async {
    String uri= NgrokLink.link + "/theFlameStore/getProducts.php";
    final response = await http.get(Uri.parse(uri), headers:{},);
    return response.body;
  }

  Future<dynamic> getProductInfo(String codice, String id) async {
    String uri =NgrokLink.link + "/theFlameStore/getProductsInfo.php";
    final response = await http.post(Uri.parse(uri),
      body:{
      "codice": codice,
      "id": id,
      },
    );

    print(response.body);
    return response.body;
  }

  Future<dynamic> postOrder(String cost, String id) async {
    String uri =NgrokLink.link + "/theFlameStore/postOrder.php";
    final response = await http.post(Uri.parse(uri),
      body:{
        "cost": cost,
        "id": id,
      },
    );

    print(response.body);
    return response.body;
  }

  void _changeColor() {
    setState(() {
      _myColor == Theme.of(context).primaryColor
          ? _myColor = Colors.red
          : _myColor = Theme.of(context).primaryColor
              as MaterialColor; //modificato con cas in materialColor
    });
  }

  @override
  Widget build(BuildContext context) {
    print(myStoreProduct.length);
    var mainProductWidget = Column(
      children: [
        Container(
          child: Text(
            'Main Products',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          margin: EdgeInsets.all(15),
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              child: myStoreProduct.length > 0
                  ? Row(
                      children: [...myStoreProduct],
                    )
                  : Container(),
              margin: EdgeInsets.only(
                left: 10,
              ),
            ),
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );

    /* var randomProductSelect = Random().nextInt(myStoreProduct.length);

   var offersOfToday = Column(
      children: [
        Container(
          child: Text(
            'Special Offer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          margin: EdgeInsets.all(15),
        ),
        Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: myStoreProduct.length > 0
                ? Row(
                    children: [
                      myStoreProduct.length > 0
                          ? StoreCard(
                              price: (int.parse(
                                          myStoreProduct[randomProductSelect]
                                              .price) -
                                      (int.parse(myStoreProduct[
                                                  randomProductSelect]
                                              .price) /
                                          2))
                                  .toString(),
                              productName: myStoreProduct[randomProductSelect]
                                  .productName,
                              rating:
                                  myStoreProduct[randomProductSelect].rating,
                              imageName:
                                  myStoreProduct[randomProductSelect].imageName,
                              callback: () {},
                            )
                          : Container(),
                    ],
                  )
                : Container(),
          ),
          margin: EdgeInsets.only(
            left: 10,
          ),
        ),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    );*/

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: isAdmin
            ? AppBar(
                title: Text(companyName),
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => {},
                    color: Colors.white,
                  ),
                ],
              )
            : AppBar(
                title: Text(companyName),
              ),
        drawer: Drawer(
            child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 50,
              ),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.account_circle),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Container(
                    child: Text(
                      "Welcome " + CurrentUser.userLoggedIn + "!",
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: TextButton(
                onPressed: () {
                  _changeColor();
                  CurrentUser.userLoggedIn = "";
                  CurrentUser.userId = "";
                  Navigator.of(context).pushNamed('logInScreen');
                },
                child: Text(
                  "Logout",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _myColor,
                  ),
                ),
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
        )),
        body: ListView(
          children: [
            mainProductWidget,
           // offersOfToday,
            Container(
              child: Text(
                companyAbout,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromRGBO(170, 170, 170, 1),
                  fontStyle: FontStyle.italic,
                ),
              ),
              margin: EdgeInsets.only(
                top: 30,
                bottom: 20,
                left: 15,
                right: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
