import 'package:flutter/material.dart';

import '../../home/bottom.dart';
import '../../home/on_item_tap.dart';
import '../../translate/language_detect.dart';
import 'service/fetch.dart';
import 'trans_search1/test.dart';
import 'trans_0/transit_0.dart';
import '../../globals.dart' as globals;

import 'private_car/service/naver_map_api_service.dart';
import 'private_car/car_directions.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String? _selectedVehicle;
  String _carImage = 'assets/images/car.png';
  String _transitImage = 'assets/images/transit.png';

  double? _selectedPrice;
  TimeOfDay? _selectedTime;

  int _selectedHours = 0;
  int _selectedMinutes = 0;
  int? _totalMinutes; // 총 시간을 분 단위로 저장하는 변수

  late double sx;
  late double sy;
  late double ex;
  late double ey;

  @override
  void initState() {
    super.initState();
    // 초기화 과정에서 globals 파일의 값을 sx와 sy에 할당
    sx = globals.my_longitude;
    sy = globals.my_latitude;
    // 위젯에서 전달받은 latitude와 longitude 값을 ex와 ey에 할당
    ex = globals.arr_longitude;
    ey = globals.arr_latitude;
  }

  final List<int> hours = List.generate(24, (index) => index);
  final List<int> minutes = List.generate(60, (index) => index);
  
  final _naverMapAPIService = NaverMapAPIService('0zwgla6npt', 'i89JWsdVDpyzGEcPBGSmTl774rt0nj9Mj0n19lkD');

  void updateTotalMinutes() {
    setState(() {
      _totalMinutes = _selectedHours * 60 + _selectedMinutes; // 시간을 분으로 변환하여 더하기
    });
  }

  void _navigateToTransitScreen(BuildContext context, Map<String, dynamic> jsonMap) async {
    if (jsonMap['result']['searchType'] == 0){
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      if (globals.selectedLanguageCode == 'ko') {
        globals.arr_restaurantName = globals.arr_restaurantName ?? 'Default Name';
      } else {
        globals.arr_restaurantName = await _getTranslatedText(globals.arr_restaurantName ?? 'Default Name');
      }
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransitScreen0(jsonMap: jsonMap),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestScreen(jsonMap: jsonMap),
        ),
      );
    }
  }

  void _getDirections(BuildContext context) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );
      if (globals.selectedLanguageCode == 'ko') {
        globals.arr_restaurantName = globals.arr_restaurantName ?? 'Default Name';
      } else {
        globals.arr_restaurantName = await _getTranslatedText(globals.arr_restaurantName ?? 'Default Name');
      }
      var directions = await _naverMapAPIService.getDrivingDirections(
        '${globals.my_longitude},${globals.my_latitude}',
        '${globals.arr_longitude},${globals.arr_latitude}'
      );
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DirectionsResultScreen(directions: directions),
        ),
      );
    } catch (e) {
      print('Error getting directions: $e');
    }
  }

  void printFilters(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(globals.getText('Filter Check')),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                  children: [
                    Text(globals.getText('Vehicle')),
                    Text(' : '),
                    Text(
                      _selectedVehicle == 'Private car'
                          ? globals.getText('Private car')
                          : _selectedVehicle == 'Transit'
                              ? globals.getText('Transit')
                              : globals.getText("It doesn't matter"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(globals.getText('Expenses (₩)')),
                    Text(' : '),
                    Text('${_selectedPrice?.round() ?? globals.getText("It doesn't matter")}'),
                  ],
                ),
                Row(
                  children: [
                    Text(globals.getText('Time required')),
                    Text(' : '),
                    Text('${_totalMinutes ?? globals.getText("It doesn't matter")}'),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(globals.getText('Cancel')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(globals.getText('Confirm')),
              onPressed: () {
                if (_selectedVehicle == 'Private car') {
                  _getDirections(context);
                } else if (_selectedVehicle == 'Transit') {
                  fetchData(
                    sx, sy, ex, ey,
                    paymentThreshold: _selectedPrice?.round(),
                    timeThreshold: _totalMinutes,
                    onComplete: (jsonMap) {
                      _navigateToTransitScreen(context, jsonMap); // 수정된 부분
                    },
                  );
                } else {
                  fetchData(
                    sx, sy, ex, ey,
                    paymentThreshold: _selectedPrice?.round(),
                    timeThreshold: _totalMinutes,
                    onComplete: (jsonMap) {
                      // 선택된 차량이 없을 때 기본 처리 로직
                      _navigateToTransitScreen(context, jsonMap); // 수정된 부분
                    },
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<String> _getTranslatedText(String text) async {
    if (globals.selectedLanguageCode == 'ko') {
      return text;
    } else {
      return await translateText(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(globals.getText('Filtering')),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Image.asset('assets/images/kfood_logo.png'), // Your image asset here
          ),
        ],
      ),
      body: Column(
        children: [
          Flexible(
            child: ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                ExpansionTile(
                  title: Text(globals.getText('Vehicle')),
                  leading: Icon(Icons.directions_car),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() {
                            _selectedVehicle = 'Private car';
                            _carImage = 'assets/images/car_selected.png'; // 선택될 때의 이미지 경로
                            _transitImage = 'assets/images/transit.png';
                          }),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(_carImage, width: 180, height: 180),
                                Text(globals.getText('Private car')),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() {
                            _selectedVehicle = 'Transit';
                            _transitImage = 'assets/images/transit_selected.png'; // 선택될 때의 이미지 경로
                            _carImage = 'assets/images/car.png';
                          }),
                          child: Container(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Image.asset(_transitImage, width: 180, height: 180),
                                Text(globals.getText('Transit')),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _selectedVehicle = null;
                        _carImage = 'assets/images/car.png';
                        _transitImage = 'assets/images/transit.png';
                      }),
                      child: Text(globals.getText("It doesn't matter")),
                    ),
                    if (_selectedVehicle != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Selected Vehicle: $_selectedVehicle'),
                      ),
                  ],
                ),
                ExpansionTile(
                  title: Text(globals.getText('Expenses (₩)')),
                  leading: Icon(Icons.monetization_on),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: globals.getText('Enter price in KRW'),
                          prefixText: '₩',
                        ),
                        onChanged: (value) {
                          setState(() {
                            _selectedPrice = double.tryParse(value);
                          });
                        },
                      ),
                    ),
                    CheckboxListTile(
                      title: Text(globals.getText('Show Entered Amount')),
                      value: _selectedPrice != null,
                      onChanged: (bool? value) {
                        setState(() {
                          // This simply refreshes the widget to show changes if _selectedPrice is not null
                        });
                      },
                    ),
                    if (_selectedPrice != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(globals.getText('Expenses (₩)')),
                            Text(' : '),
                            Text('${_selectedPrice!.round()}'),
                          ],
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedPrice = null; // Reset the price to null
                          });
                        },
                        child: Text(globals.getText("It doesn't matter")),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text(globals.getText('Time required')),
                  leading: Icon(Icons.timer),
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton<int>(
                          value: _selectedHours,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedHours = value;
                                updateTotalMinutes(); // Update total minutes when hours change
                              });
                            }
                          },
                          items: hours.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value hours'),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 20),
                        DropdownButton<int>(
                          value: _selectedMinutes,
                          onChanged: (value) {
                            if (value != null) {
                              setState(() {
                                _selectedMinutes = value;
                                updateTotalMinutes(); // Update total minutes when minutes change
                              });
                            }
                          },
                          items: minutes.map<DropdownMenuItem<int>>((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text('$value minutes'),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(globals.getText('Time required')),
                          Text(' : '),
                          Text('$_totalMinutes minutes'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedHours = 0; // Reset hours to 0
                          _selectedMinutes = 0; // Reset minutes to 0
                          updateTotalMinutes(); // Recalculate total minutes
                        });
                      },
                      child: Text(globals.getText("It doesn't matter")),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: ElevatedButton(
              onPressed: () => printFilters(context), // 익명 함수를 사용하여 context 전달
              child: Text(globals.getText('Filters select')),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Makes button full-width
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: (index) => onItemTapped(context, index),
      ),
    );
  }
}