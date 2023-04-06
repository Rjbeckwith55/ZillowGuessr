import 'package:flutter/material.dart';
import 'friends_list.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


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
              MaterialPageRoute(builder: (context) => const InvitePage()),
            );
          },
        ),
      ),
    );
  }
}

class InvitePage extends StatelessWidget {
  const InvitePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invite Friends'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center, // centers vertically
          crossAxisAlignment:
              CrossAxisAlignment.stretch, // centers horizontally
          children: [
            ElevatedButton(
              child: Text('Play!'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GameScreen()),
                );
              },
            ),
            ElevatedButton(
              child: Text('Invite Friends'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FriendsList()),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ]),
    );
  }
}

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
    var lat = "lat";
    var long = "long";
    var baths = "1";
    var beds = "3";
    var squareFeet = 1500;
    var year = "1955";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the price'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // centers vertically
        crossAxisAlignment: CrossAxisAlignment.center, // centers horizontally
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.center, // centers vertically
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

                  children: [
                    Image.network(
                      'https://photos.zillowstatic.com/fp/e664f0c3c87d4a2d344146d5c1adf8fc-p_e.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://photos.zillowstatic.com/fp/b6daf9d5b6d48101bc27719b07b66c6d-p_e.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://photos.zillowstatic.com/fp/00669b1b504cd204b56873444ffe8255-p_e.jpg',
                      fit: BoxFit.cover,
                    ),
                  ],

                  /// Called whenever the page in the center of the viewport changes.
                  onPageChanged: (value) {
                    print('Page changed: $value');
                  },

                  isLoop: true,
                ),
              ]),
          Row(
              mainAxisAlignment: MainAxisAlignment.center, // centers vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // centers horizontally
              children: [Text("Baths: $baths "), Text("Beds: $beds")]),
          Row(
              mainAxisAlignment: MainAxisAlignment.center, // centers vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // centers horizontally
              children: [
                Text("Square Ft: $squareFeet "),
                Text("Year Built: $year")
              ]),
        ],
      ),
    );
  }
}
