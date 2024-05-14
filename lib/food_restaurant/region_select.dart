import 'package:flutter/material.dart';

import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import 'food_restaurant.dart';
import 'food_restaurant_db/region_db.dart';
import 'food_select.dart';
import 'service/restaurant_service.dart';

class RegionSelectScreen extends StatefulWidget {
  final int food_id;
  final String food_name;
  RegionSelectScreen({Key? key, required this.food_id, required this.food_name}) : super(key: key);

  @override
  _RegionSelectScreenState createState() => _RegionSelectScreenState();
}

class _RegionSelectScreenState extends State<RegionSelectScreen> {
  int _currentIndex = 0;
  int currentSelect = 0;
  int? selectedRegionIndex;
  String? selectRegion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoodSelectScreen()),
            );
          },
        ),
        title: Text('Select Region (2/2)'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () async {
              if (currentSelect == 0){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("지역 미선택"),
                      content: Text("지역을 선택해주세요"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Confirm"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              } else{
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("맛집 정보 찾기"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min, // Use min size for the content
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text("아래 정보를 이용하여 맛집 찾는 것이 맞습니까?"),
                          SizedBox(height: 10),
                          Text("음식 이름 : ${widget.food_name}"),
                          Text("지역 : ${selectRegion}"),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the dialog
                          },
                        ),
                        TextButton(
                          child: Text('Confirm'),
                          onPressed: () async {
                            var restaurantData = await fetchRestaurantsData(currentSelect, widget.food_id);
                            if (restaurantData != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RestaurantDetailsPage(restaurantData: restaurantData, food_id: widget.food_id, food_name: widget.food_name,),
                                ),
                              );
                            } else {
                              print('Failed to fetch restaurant data.');
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.asset(
              'assets/images/korea/$currentSelect.png', // Ensure that this asset path corresponds to valid images
              fit: BoxFit.cover,
            ),
          ),
          Divider(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 2,
              ),
              itemCount: KoreanRegion.regions.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      selectRegion = KoreanRegion.regions[index].name;
                      currentSelect = KoreanRegion.regions[index].id;
                      selectedRegionIndex = index;
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: selectedRegionIndex == index ? Colors.blue : Colors.white,  // Change color when selected
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      KoreanRegion.regions[index].name,
                      style: TextStyle(
                        fontSize: 10,
                        color: selectedRegionIndex == index ? Colors.white : Colors.black,  // Change text color for better visibility
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              },
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

  void _showConfirmationDialog(BuildContext context, int id, String name) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Selection'),
          content: Text('You have selected $name.'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog and navigate if needed
                // Add navigation logic here if needed
              },
            ),
          ],
        );
      },
    );
  }
}