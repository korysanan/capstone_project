import 'package:flutter/material.dart';

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

  final List<int> hours = List.generate(24, (index) => index);
  final List<int> minutes = List.generate(60, (index) => index);

  void updateTotalMinutes() {
    setState(() {
      _totalMinutes = _selectedHours * 60 + _selectedMinutes; // 시간을 분으로 변환하여 더하기
    });
  }

  void printFilters(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Filter Check'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Vehicle: ${_selectedVehicle ?? "It doesn't matter"}'),
                Text('Expenses: ${_selectedPrice?.round() ?? "It doesn't matter"}'),
                Text('Time required(minutes): ${_totalMinutes ?? "It doesn't matter"}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // 여기에 'Confirm' 버튼을 눌렀을 때 실행될 로직을 추가하세요.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filtering'),
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
                  title: Text('Vehicle'),
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
                                Text('Private car'),
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
                                Text('Transit'),
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
                      child: Text("It doesn't matter"),
                    ),
                    if (_selectedVehicle != null)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Selected Vehicle: $_selectedVehicle'),
                      ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Expenses (₩)'),
                  leading: Icon(Icons.monetization_on),
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter price in KRW',
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
                      title: Text('Show Entered Amount'),
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
                        child: Text('Entered Amount: ₩${_selectedPrice!.round()}'),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedPrice = null; // Reset the price to null
                          });
                        },
                        child: Text("It doesn't matter"),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Text('Time required'),
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
                      child: Text('Time required: $_totalMinutes minutes'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedHours = 0; // Reset hours to 0
                          _selectedMinutes = 0; // Reset minutes to 0
                          updateTotalMinutes(); // Recalculate total minutes
                        });
                      },
                      child: Text("It doesn't matter"),
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
              child: const Text('Print Filters'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), // Makes button full-width
              ),
            ),
          ),
        ],
      ),
    );
  }
}
