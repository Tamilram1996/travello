import 'package:flutter/material.dart';

import '../Utils/base.dart';
import 'loginscreen.dart';

class Advertisementpage extends StatefulWidget {
  const Advertisementpage({Key? key}) : super(key: key);

  @override
  State<Advertisementpage> createState() => _AdvertisementpageState();
}

class _AdvertisementpageState extends State<Advertisementpage> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<String> images = [
    'assets/first.png',
    'assets/second.png',
    'assets/third.png',
  ];

  final List<String> titles = [
    "Explore the world easily",
    "Reach the unknown spot",
    "Make connects with Travello",
  ];

  final List<String> subtitles = [
    "To your desire",
    "To your destination",
    "To your dream trip",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: images.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 300,
                        child: Image.asset(images[index]),
                      ),
                      SizedBox(height: 40),
                      Row(
                        children: [
                          SizedBox(width: 20), // Add left gap of 20 pixels
                          Text(
                            titles[index],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),
                      Row(
                        children: [
                          SizedBox(width: 20), // Add left gap of 20 pixels
                          Text(
                            subtitles[index],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Row(
              children: [
                SizedBox(width: 20,),
                _buildDotIndicator(),
              ],
            ),

            // Next Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    if (_currentIndex < images.length - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginscreen()),
                      );
                    }
                  },
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.black,
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // floatingActionButton: Container(
        //   height: 60,
        //   width: 60,
        //   decoration: BoxDecoration(
        //     color: Colors.black, // Set the background color to black
        //     shape: BoxShape.circle, // Makes the container circular
        //   ),
        //   child: IconButton(
        //     onPressed: () {
        //       if (_currentIndex < images.length - 1) {
        //         _pageController.nextPage(
        //           duration: Duration(milliseconds: 300),
        //           curve: Curves.easeInOut,
        //         );
        //       } else {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(builder: (context) => Loginscreen()),
        //         );
        //       }
        //     },
        //     icon: Icon(
        //       Icons.arrow_forward_ios,
        //       color: Colors.white, // White icon color
        //     ),
        //   ),
        // ),

      ),

    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(images.length, (index) {
        bool isSelected = _currentIndex == index;
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: isSelected ? 20.0 : 12.0, // Wider when selected
          height: 8.0, // Keep a small height
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.red : Colors.red.withOpacity(0.3), // Red color indicator
            borderRadius: BorderRadius.horizontal(
              left: Radius.elliptical(10, 5), // Smooth horizontal edges
              right: Radius.elliptical(10, 5),
            ),
          ),
        );
      }),
    );
  }
}
