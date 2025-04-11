import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/view/schedules/non_0_view_schedule.dart';

class ScheduledScreen extends StatelessWidget {
  String title;
  ScheduledScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${title} MAINTENANCE'),
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
            InkWell(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                        children: [
                          Text('#181641',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                          Text('05/04/2025',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 18),),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('0003-07-11KV NAKKALAGUTTA'),
                    ),
                    Divider(color: Colors.grey.shade300,),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('SEC:NAKKALAGUTTA',),
                          Icon(Icons.arrow_right)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('STATUS: SCHEDULED',),
                          Text('Modify',style: TextStyle(fontSize: 18,color: Colors.red),),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewSchedule()));
              },
            )
          ],
        ),
      ),
    );
  }
}