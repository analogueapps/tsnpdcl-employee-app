import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/view/schedules/viewmodel/ss_inspetion_viewmodel.dart';


class SsInspection extends StatelessWidget {
  static const id = Routes.ssInspect;
  const SsInspection({super.key, required this.args});
  final Map<String, dynamic> args;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SsInspetionViewmodel(context:context, data:args),
      child: Consumer<SsInspetionViewmodel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.grey.shade200,
            appBar: AppBar(
              title:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '33KV SS INSPECTION',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(args['ssCode'], style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w200,
                  ),),
                ],
              ),
              backgroundColor:CommonColors.colorPrimary,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(11),
                                topLeft: Radius.circular(11),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 51,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: Center(
                                    child: Text(
                                      '33KV SIDE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 11),
                            Text(
                              '33KV AB SWITCH',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: viewModel.abSwitchItems.length * 48.0,
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: viewModel.abSwitchItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.abSwitchItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleAbSwitchCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text(
                              '33KV BUS BAR CONNECTOR',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: viewModel.busBarConnectorItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.busBarConnectorItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.busBarConnectorItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleBusBarConnectorCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text(
                              '33KV BUS COUPLER',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: viewModel.busCouplerItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.busCouplerItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.busCouplerItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleBusCouplerCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('33KV LA(S)', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.laItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.laItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.laItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleLaCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('33KV VCB', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.vcbItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.vcbItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.vcbItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleVcbCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('33KV CT(S)', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.ctsItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.ctsItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.ctsItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleCtsCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('33KV POST TYPE INSULATOR', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.postTypeItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.postTypeItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.postTypeItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handlePoseTypeCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('33KV HG FUSE SETS', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.hgFuseItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.hgFuseItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.hgFuseItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleHgFuseCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('33KV FUSE WIRE', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.fuseWireItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.fuseWireItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.fuseWireItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleFuseWireCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('33KV PT(S)', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.ptsItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.ptsItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.ptsItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handlePtsCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(11),
                                topLeft: Radius.circular(11),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 51,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: Center(
                                    child: Text(
                                      'PTR SIDE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 11),
                            Text('PTR', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.ptrItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.ptrItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.ptrItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handlePtrCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('GROUP VCB(S)', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.groupVcbItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.groupVcbItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.groupVcbItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleGroupVcbCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('11KV GROUP AB SWITCH', style: TextStyle(fontWeight: FontWeight.bold),),
                            Column(
                              children: [
                                SizedBox(
                                  height: viewModel.groupABSwitchItems.length * 48.0,
                                  child: ListView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: viewModel.groupABSwitchItems.length,
                                    itemBuilder: (context, index) {
                                      final item = viewModel.groupABSwitchItems[index];
                                      return Row(
                                        children: [
                                          Checkbox(
                                            value: item.isChecked,
                                            onChanged: (bool? value) {
                                              viewModel.handleGroupABSwitchCheck(
                                                index,
                                                value,
                                              );
                                            },
                                          ),
                                          Text(item.name),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Divider(color: Colors.grey, thickness: 1),
                                SizedBox(height: 11),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text('BODY CURRENT', style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 11),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      label: Text('NEUTRAL GROUP CURRENT'),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 11),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      label: Text('BODY GROUND CURRENT'),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(11),
                                topLeft: Radius.circular(11),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 51,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: Center(
                                    child: Text(
                                      '11KV SIDE',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 11),
                            Text('11KV BUS COUPLER', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.KV11busCouplerItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.KV11busCouplerItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.KV11busCouplerItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleKV11BusCouplerCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('11KV BUS BAR CONNECTORS TO FDR VCB', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.busBarConnectorsItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.busBarConnectorsItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.busBarConnectorsItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleBusConnectorsCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('11KV CT(S)', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.KV11ctsItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.KV11ctsItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.KV11ctsItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleKV11CtsCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('11KV VCB', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.KV11vcbItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.KV11vcbItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.KV11vcbItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleKV11VcbCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('11KV FDR AB SWITCH',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.fdrABSwitchItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.fdrABSwitchItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.fdrABSwitchItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleFdrABSwitchCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('11KV PT(S)', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.KV11ptsItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.KV11ptsItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.KV11ptsItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleKV11PtsCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(11),
                                topLeft: Radius.circular(11),
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 51,
                                child: Container(
                                  color: Colors.grey.shade300,
                                  child: Center(
                                    child: Text(
                                      'OTHERS',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 11),
                            Text('CAPACITOR BANK', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.capacitorBankItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.capacitorBankItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.capacitorBankItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleCapacitorCheckCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('STATION DTR', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.stationDtrItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.stationDtrItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.stationDtrItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleStationDtrCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('SS EARTHING', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.ssEarthingItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.ssEarthingItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.ssEarthingItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleSsEarthingCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('YARD LIGHTS', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.yardLightingItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.yardLightingItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.yardLightingItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleYardLightingCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: 11),
                            Divider(color: Colors.grey, thickness: 1),
                            SizedBox(height: 11),
                            Text('RED HOTS', style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(
                              height: viewModel.redHotsItems.length * 48.0,
                              // Approximate height per item
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                // Disable inner scrolling
                                itemCount: viewModel.redHotsItems.length,
                                itemBuilder: (context, index) {
                                  final item = viewModel.redHotsItems[index];
                                  return Row(
                                    children: [
                                      Checkbox(
                                        value: item.isChecked,
                                        onChanged: (bool? value) {
                                          viewModel.handleRedHotsCheck(
                                            index,
                                            value,
                                          );
                                        },
                                      ),
                                      Text(item.name),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          if (!viewModel.validateSection(viewModel.abSwitchItems, "33KV AB Switch",context)) return;
                          if (!viewModel.validateSection(viewModel.busBarConnectorItems, "33KV Bus Bar Connector",context)) return;
                          if (!viewModel.validateSection(viewModel.busCouplerItems, "33KV Bus Coupler",context)) return;
                          if (!viewModel.validateSection(viewModel.laItems, "33KV LA(S)",context)) return;
                          if (!viewModel.validateSection(viewModel.vcbItems, "33KV VCB",context)) return;
                          if (!viewModel.validateSection(viewModel.ctsItems, "33KV CT(S)",context)) return;
                          if (!viewModel.validateSection(viewModel.postTypeItems, "33KV Post Type Insulator",context)) return;
                          if (!viewModel.validateSection(viewModel.hgFuseItems, "33KV HG Fuse Sets",context)) return;
                          if (!viewModel.validateSection(viewModel.fuseWireItems, "33KV Fuse Wire",context)) return;
                          if (!viewModel.validateSection(viewModel.ptsItems, "33KV PT(S)",context)) return;
                          if (!viewModel.validateSection(viewModel.ptrItems, "PTR",context)) return;
                          if (!viewModel.validateSection(viewModel.groupVcbItems, "Group VCB(S)",context)) return;
                          if (!viewModel.validateSection(viewModel.groupABSwitchItems, "11KV Group AB Switch",context)) return;
                          if (!viewModel.validateSection(viewModel.KV11busCouplerItems, "11KV Bus Coupler",context)) return;
                          if (!viewModel.validateSection(viewModel.busBarConnectorsItems, "11KV Bus Bar Connectors",context)) return;
                          if (!viewModel.validateSection(viewModel.KV11ctsItems, "11KV CT(S)",context)) return;
                          if (!viewModel.validateSection(viewModel.KV11vcbItems, "11KV VCB",context)) return;
                          if (!viewModel.validateSection(viewModel.fdrABSwitchItems, "11KV FDR AB Switch",context)) return;
                          if (!viewModel.validateSection(viewModel.KV11ptsItems, "11KV PT(S)",context)) return;
                          if (!viewModel.validateSection(viewModel.capacitorBankItems, "Capacitor Bank",context)) return;
                          if (!viewModel.validateSection(viewModel.stationDtrItems, "Station DTR",context)) return;
                          if (!viewModel.validateSection(viewModel.ssEarthingItems, "SS Earthing",context)) return;
                          if (!viewModel.validateSection(viewModel.yardLightingItems, "Yard Lights",context)) return;
                          if (!viewModel.validateSection(viewModel.redHotsItems, "Red Hots",context)) return;

                          // If all validations pass, proceed with submission
                          viewModel.submit(context);
                        },
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}