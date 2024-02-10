import 'package:flutter/material.dart';
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
                          /// Width of the [ImageSlideshow].
                          width: 600,

                          /// Height of the [ImageSlideshow].
                          height: 600,

                          /// The page to show when first creating the [ImageSlideshow].
                          initialPage: 0,

                          /// The color to paint the indicator.
                          indicatorColor: Colors.blue,

                          /// The color to paint behind th indicator.
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
                        Text("Baths: ${snapshot.data!.baths} "),
                        Text("Beds: ${snapshot.data!.beds}")
                      ]),
                  Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center, // centers vertically
                      crossAxisAlignment:
                          CrossAxisAlignment.center, // centers horizontally
                      children: [
                        Text("Square Feet: ${snapshot.data!.squareFeet} "),
                        Text("Year Built: ${snapshot.data!.year}")
                      ]),
                  Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center, // centers vertically
                      crossAxisAlignment:
                      CrossAxisAlignment.center, // centers horizontally
                      children: [
                        Text("Guess the price:"),
                      ]),
                ],
              );
            } else if (snapshot.hasError) {
              return Text(
                  'Error: ${snapshot.error}, \n${snapshot.data}, \n${snapshot.connectionState}, \n${snapshot.stackTrace}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ));
  }
}
