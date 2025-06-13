import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/model/offline_feeder.dart';
import 'package:tsnpdcl_employee/view/pole_tracker/viewmodel/view_offline_feeders_viewmodel.dart';

class ViewOfflineFeedersScreen extends StatelessWidget {
  static const id = Routes.viewOfflineFeedersScreen;
  const ViewOfflineFeedersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColors.colorPrimary,
        title: Text(
          "Offline feeder".toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: toolbarTitleSize,
              fontWeight: FontWeight.w700
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ViewOfflineFeedersViewmodel(context: context),
    child: Consumer<ViewOfflineFeedersViewmodel>(
    builder: (context, viewModel, child) {
    return FutureBuilder<List<OffLineFeeder>>(
    future: viewModel.fetchFeeders(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
    return const Center(child: Text('No Feeders Found'));
    }

    final feeders = snapshot.data!;
    return ListView.builder(
    itemCount: feeders.length,
    itemBuilder: (context, index) {
    return offlineFeederData( feeders[index]);
    },
    );
    },
    );
    }
    )
      )
    );
  }

  Widget offlineFeederData(OffLineFeeder feeder)  {
   return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('SS Code: ${feeder.ssCode}'.toUpperCase()),
            Text('SS Name: ${feeder.ssName}'. toUpperCase()),
            Text('Feeder Code: ${feeder.feederCode}'.toUpperCase()),
            Text('Feeder Name: ${feeder.feederName}'.toUpperCase()),
            const SizedBox(height: doubleTen,),
            const Text("Offline Pole: 0 No.s"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              ElevatedButton(onPressed: null, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.deepOrange)), child:  Text("Upload".toUpperCase(),style: const TextStyle(color:Colors.white),),),
              ElevatedButton(onPressed: null, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey[300])), child: Text("digitise offline".toUpperCase(),style: const TextStyle(color:Colors.black),)),
            ],
            ),
            // Text('Voltage Level: ${feeder.voltageLevel}'.toUpperCase()),
            // Text('Insert Date: ${DateTime.fromMillisecondsSinceEpoch(feeder.insertDate)}'),
          ],
        ),
      ),
    );
  }
}
