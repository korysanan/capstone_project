import 'package:flutter/material.dart';

import '../home/bottom.dart';
import '../home/on_item_tap.dart';
import '../translate/language_detect.dart';
import 'food_restaurant.dart';
import 'food_restaurant_db/region_db.dart';
import 'food_select.dart';
import 'service/restaurant_service.dart';
import '../globals.dart' as globals;

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
            Navigator.pop(context);
          },
        ),
        title: Text(globals.getText('Select Region (2/2)')),
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
                      title: Text(globals.getText('No region selection')),
                      content: Text(globals.getText('Please select a region')),
                      actions: <Widget>[
                        TextButton(
                          child: Text(globals.getText('Confirm')),
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
                      title: Text(globals.getText('Finding good restaurant information')),
                      content: Column(
                        mainAxisSize: MainAxisSize.min, // Use min size for the content
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Text(globals.getText('Is it correct to use the information below to find a good restaurant?')),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(globals.getText('Food Name :')),
                              Flexible(
                                child: Text(widget.food_name),
                              ),
                            ],
                          ),
                          SizedBox(height: 8), // Add some spacing between the texts
                          Row(
                            children: [
                              Text(globals.getText('Area :')),
                              Flexible(
                                child: Text(selectRegion ?? 'Unknown'),
                              ),
                            ],
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text(globals.getText('Cancel')),
                          onPressed: () {
                            Navigator.of(context).pop(); // Dismiss the dialog
                          },
                        ),
                        TextButton(
                          child: Text(globals.getText('Confirm')),
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
                return FutureBuilder<String>(
                  future: () async {
                    if (globals.selectedLanguageCode == 'en') {
                      return KoreanRegion.regions[index].englishName;
                    } else if (globals.selectedLanguageCode == 'ko') {
                      return KoreanRegion.regions[index].name;
                    } else {
                      return await translateText(KoreanRegion.regions[index].englishName);
                    }
                  }(),
                  builder: (context, snapshot) {
                    String regionName = snapshot.data ?? '...';

                    return InkWell(
                      onTap: snapshot.connectionState == ConnectionState.done
                          ? () {
                              setState(() {
                                selectRegion = regionName;
                                currentSelect = KoreanRegion.regions[index].id;
                                selectedRegionIndex = index;
                              });
                            }
                          : null,
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
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            regionName,
                            style: TextStyle(
                              fontSize: 10,
                              color: selectedRegionIndex == index ? Colors.white : Colors.black,  // Change text color for better visibility
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
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
}
