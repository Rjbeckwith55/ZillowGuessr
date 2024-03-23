import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zillow_guesser/House.dart';
import 'package:zillow_guesser/Network.dart';
import 'friends_list.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

// import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zillow Guesser',
      home: PlayPage(),
    );
  }
}

// Create a Form widget.
class PlayPage extends StatefulWidget {
  @override
  PlayPageState createState() {
    return PlayPageState();
  }
}

class PlayPageState extends State<PlayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zillow Guesser'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Play Game'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GameScreen()),
            );
          },
        ),
      ),
    );
  }
}
//
// class InvitePage extends StatelessWidget {
//   const InvitePage();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Invite Friends'),
//       ),
//       body: Column(
//           mainAxisAlignment: MainAxisAlignment.center, // centers vertically
//           crossAxisAlignment:
//               CrossAxisAlignment.stretch, // centers horizontally
//           children: [
//             ElevatedButton(
//               child: Text('Play!'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => GameScreen()),
//                 );
//               },
//             ),
//             ElevatedButton(
//               child: Text('Invite Friends'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => FriendsList()),
//                 );
//               },
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: const Text('Go back!'),
//             ),
//           ]),
//     );
//   }
// }

class Loading extends StatelessWidget {
  const Loading();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loading'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // centers vertically
        crossAxisAlignment: CrossAxisAlignment.stretch, // centers horizontally
        children: [Text('Waiting for Players!')],
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Guess the Price'),
        ),
        body: FutureBuilder<House>(
          future: getRandomHouse(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // centers vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // centers horizontally
                children: [
                  Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // centers vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // centers horizontally
                      children: [
                        ImageSlideshow(
                          width: 600,
                          height: 600,
                          initialPage: 0,
                          indicatorColor: Colors.blue,
                          indicatorBackgroundColor: Colors.grey,

                          children: snapshot.data!.images.map((url) {
                            return Image.network(
                              url,
                              fit: BoxFit.cover,
                            );
                          }).toList(),

                          /// Called whenever the page in the center of the viewport changes.
                          onPageChanged: (value) {
                            print('Page changed: $value');
                          },

                          isLoop: true,
                        ),
                      ]),
                  Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // centers vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // centers horizontally
                      children: [
                        Text("Baths: ${snapshot.data!.baths} | "),
                        Text("Beds: ${snapshot.data!.beds}")
                      ]),
                  Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // centers vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // centers horizontally
                      children: [
                        Text("Square Feet: ${snapshot.data!.squareFeet} "),
                        Text("Year Built: ${snapshot.data!.yearBuilt}")
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Guess the list price: "),
                      SizedBox(
                          width:
                              10), // Add some space between text and input field
                      NumberInputField(),
                    ],
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}, \n${snapshot.data}, \n${snapshot.connectionState}, \n${snapshot.stackTrace}');
            }

            // By default, show a loading spinner.
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
class NumberInputField extends StatefulWidget {
  @override
  _NumberInputFieldState createState() => _NumberInputFieldState();
}

class _NumberInputFieldState extends State<NumberInputField> {
  final TextEditingController _controller = TextEditingController();
  bool showPrefix = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        showPrefix = _controller.text.isNotEmpty;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150, // Adjust width according to your requirement
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          ThousandsFormatter(), // Custom formatter to insert commas and enforce maximum value
          FilteringTextInputFormatter.allow(RegExp(r'[0-9,\.]')),
        ],
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon:  Icon(Icons.attach_money),
        ),
        onSubmitted: (_) => postGuess("test"),
      ),
    );
  }
}

class ThousandsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If there's no change in the value, return the new value
    if (oldValue.text == newValue.text) {
      return newValue;
    }

    // Remove commas from the new value
    String newText = newValue.text.replaceAll(',', '');

    // Insert commas after every three digits from the right
    final regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    newText = newText.replaceAllMapped(regExp, (Match match) => '${match[1]},');

    // Remove leading zeros
    newText = newText.replaceFirst(RegExp(r'^0+(?!$)'), '');

    // Check if the value exceeds the maximum
    int parsedValue = int.tryParse(newText.replaceAll(',', '')) ?? 0;
    if (parsedValue > 999999999) {
      // Return the old value if the new value exceeds the maximum
      return oldValue;
    }

    // Return the new value with commas inserted
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}