 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ViewSchedule extends StatelessWidget {
  const ViewSchedule({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Schedule'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 11,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE ID',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('181641',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE BY EMP ID',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('70000000',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE BY EMP NAME',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('TEST USER',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE BY EMP DES',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('AAE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('DATE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('05/Apr/2025 10:31',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE TYPE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('LINE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('CODE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('0003-07-11KV NAKKALAGUTTA',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('VOLTAGE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('11KV',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE DATE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('05/04/2025',style: TextStyle(fontWeight: FontWeight.bold,),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE ID',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('181641',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Padding(padding: EdgeInsets.all(11),
              child: Container(
                width: double.infinity,
                height: 40,
                color: Colors.blue,
                child: Center(child: Text('ATTEND',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE ID',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('181641',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE BY EMP ID',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('70000000',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE BY EMP NAME',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('TEST USER',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE BY EMP DES',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('AAE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('DATE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('05/Apr/2025 10:31',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE TYPE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('LINE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('CODE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('0003-07-11KV NAKKALAGUTTA',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('VOLTAGE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('11KV',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE DATE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('05/04/2025',style: TextStyle(fontWeight: FontWeight.bold,),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE ID',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('181641',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('CODE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('0003-07-11KV NAKKALAGUTTA',style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold,),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('VOLTAGE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('11KV',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE DATE',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('05/04/2025',style: TextStyle(fontWeight: FontWeight.bold,),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('SCHEDULE ID',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                ),
                Container(width: 1,height: 30,color: Colors.grey.shade400,),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10.0),
                    child: Text('181641',style: TextStyle(fontWeight: FontWeight.bold),),
                  ),
                )
              ],
            ),
            Divider(color: Colors.grey.shade400,thickness: 1,),
          ],
        ),
      ),
    );
  }
}