import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotScheduledScreen extends StatelessWidget {
  String title;
  NotScheduledScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$title MAINTENANCE'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all( 0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  labelText: 'Search..',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}