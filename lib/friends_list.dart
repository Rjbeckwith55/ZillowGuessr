import 'package:flutter/material.dart';

class FriendsList extends StatefulWidget {
  @override
  _SelectableListState createState() => _SelectableListState();
}

class _SelectableListState extends State<FriendsList> {
  // TODO: read from DB
  List<String> items = [
    'Friend 1',
    'Friend 2',
    'Friend 3',
    'Friend 4',
    'Friend 5',
    'Friend 6',
    'Friend 7',
    'Friend 8',
    'Friend 9',
    'Friend 10',
  ];
  List<bool?> checkedItems = List.filled(10, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invite Friends'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            title: Text(items[index]),
            value: checkedItems[index],
            onChanged: (bool? value) {
              setState(() {
                checkedItems[index] = value;
              });
            },
          );
        },
      ),
    );
  }
}
