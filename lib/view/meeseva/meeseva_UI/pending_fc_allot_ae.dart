import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/meeseva/meeseva_UI/search_application.dart';

class IntimatedToConsumerList extends StatefulWidget {
  @override
  State<IntimatedToConsumerList> createState() =>
      _IntimatedToConsumerListState();

  final String title;

  const IntimatedToConsumerList({super.key, required this.title});
}

class _IntimatedToConsumerListState extends State<IntimatedToConsumerList> {
  // Sample list of consumers
  final List<Consumer> consumers = [
    Consumer(
      name: 'SANDEEP KUMAR',
      id: 'NC022502537026',
      dateTime: '28 Mar 2025 16:53:17',
      location: 'Hanumakonda',
    ),
    Consumer(
      name: 'JANE DOE',
      id: 'JD1234567890',
      dateTime: '28 Mar 2025 16:53:17',
      location: 'Hanumakonda',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Handle refresh button press
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search button press
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: consumers.length,
              itemBuilder: (context, index) {
                final consumer = consumers[index];
                return Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/profile_placeholder.png'),
                      ),
                      title: Text(consumer.name),
                      subtitle: Text(consumer.id),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 15),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchApplication(
                                      regNo: consumer.id,
                                    )));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(consumer.dateTime),
                          Text(consumer.location),
                        ],
                      ),
                    ),
                    const Divider(
                      color: Colors.grey,
                      thickness: 1,
                    )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Consumer model
class Consumer {
  final String name;
  final String id;
  final String dateTime;
  final String location;

  Consumer({
    required this.name,
    required this.id,
    required this.dateTime,
    required this.location,
  });
}
