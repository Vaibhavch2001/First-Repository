//BTC ETH LTC
import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

  String selectedItem = 'USD';

  int rate1,rate2,rate3;

  List<DropdownMenuItem> getItems()
  {

    List<DropdownMenuItem<String>> dropDownItems= [];
    for(int i=0;i<currenciesList.length;i++)
      {
        String currency = currenciesList[i];
       var newItem = DropdownMenuItem(child: Text(currency),value: currency,);
       dropDownItems.add(newItem);
      }
    return dropDownItems;
  }

  Future getValues(String currency) async
  {
    String url = 'https://rest.coinapi.io/v1/exchangerate';
    List<String> coins = ['BTC','ETH','LTC'];
    List rateDATAS = [];
      for(int j=0;j<3;j++) {
        String coin = coins[j];
        http.Response response1 = await http.get(
            '$url/$coin/$currency?apikey=B8EB3713-DB3C-41A2-A62F-72AC0F18231C');


        String data1 = response1.body;
        var rateData = jsonDecode(data1);
        rateDATAS.add(rateData);
      }
        return rateDATAS;


  }
  void updateUI(dynamic rateDatas)
  {
    setState(() {

      double rate11 = rateDatas[0]['rate'];
       rate1 = rate11.toInt();
      double rate22 = rateDatas[1]['rate'];
      rate2 = rate22.toInt();
      double rate33 = rateDatas[2]['rate'];
      rate3 = rate33.toInt();
    });

    }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      
                      '1 BTC = $rate1 $selectedItem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $rate2 $selectedItem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $rate3 $selectedItem',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ), ],
          ),


          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              elevation: 15,
              underline: Container(
                height: 2,
                color: Colors.black,
              ),
              items: getItems(),
              value: selectedItem,
              onChanged: (String newValue) async {
                setState(() {
                  selectedItem = newValue;});
                      rate1=null;
                      rate2=null;
                      rate3=null;
                      var data = await getValues(selectedItem);
                        updateUI(data);


              },
            ),
          ),
        ],
      ),
    );
  }
}
