import 'package:astup/app/models/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

final objectRef = FirebaseFirestore.instance
    .collection('objects')
    .withConverter<ObjectModel>(
      fromFirestore: (snapshots, _) => ObjectModel.fromJson(snapshots.data()!),
      toFirestore: (object, _) => object.toJson(),
    );

enum ObjectQuery {
  location,
  result,
}

//
extension on Query<ObjectModel> {
  /// Create a firebase query from a [MovieQuery]
  Query<ObjectModel> queryBy(ObjectQuery query) {
    switch (query) {
      case ObjectQuery.location:
        return where('genre', arrayContainsAny: ['Sci-Fi']);
      case ObjectQuery.result:
        return orderBy('id', descending: query == ObjectQuery.result);
      // return orderBy('id', descending: query == '3650000165');
    }
  }
}

class ObjectUi extends StatefulWidget {
  const ObjectUi({Key? key}) : super(key: key);

  @override
  _ObjectUiState createState() => _ObjectUiState();
}

class _ObjectUiState extends State<ObjectUi> {
  String result = "0000";

  @override
  void initState() {
    super.initState();
    String? _result = Get.parameters['result'];
    result = _result!;
  }

  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<ObjectModel>>(
      // stream: objectRef.snapshots(),
      stream: objectRef.queryBy(ObjectQuery.result).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.requireData;

        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            actionsIconTheme: const IconThemeData(
              color: Colors.white,
            ),
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () {
                  Get.back();
                }),
            title: Text('object.title'.tr + ' : ' + result),
          ),
          body: ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              return _ObjectItem(data.docs[index].data(),
                  data.docs[index].reference, context, result);
            },
          ),
        ));
      },
    );
  }
}

/// A single movie row.
class _ObjectItem extends StatelessWidget {
  _ObjectItem(this.movie, this.reference, this.context, this.result);

  final ObjectModel movie;
  final DocumentReference<ObjectModel> reference;
  final BuildContext context;
  final String result;

  /// Returns the movie poster.
  Widget get objectImage {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.zero,
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8))),
      child: Image.network(
        "https://eltex-co.ru/upload/resize_cache/iblock/3ea/250_250_0/MES2324.png",
        fit: BoxFit.contain,
        width: MediaQuery.of(context).size.width,
        height: 240,
      ),
    );
  }

  Widget get objectDescription {
    return Container(
        width: MediaQuery.of(this.context).size.width,
        height: 360,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero,
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8))),
        child: Padding(
          padding: EdgeInsets.only(left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    '${movie.id}',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.sn'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '${movie.serialID}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.comson'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '25.06.2019',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.liab'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'Rykov D. I.',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.model'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'MES2324',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.ip'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '${movie.ip}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.type'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '${movie.type}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.location'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'Buhtarma',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.sysName'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '${movie.sysName}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.role'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    'access',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'object.title.position'.tr,
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  Text(
                    '${movie.addressPos}',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 72,
              ),
              Container(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffC4C4C4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(children: [
                        Icon(Icons.wb_iridescent_outlined),
                        Text("object.title.vlan".tr)
                      ]),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffC4C4C4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {},
                      child: Row(children: [
                        Icon(Icons.settings_input_hdmi_outlined),
                        Text("object.title.port".tr)
                      ]),
                    ),
                    OutlinedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xffC4C4C4)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        var data = {"result": '${result}'};
                        Get.offNamed('/timeline', parameters: data);
                      },
                      child: Row(children: [
                        Icon(Icons.history_edu_outlined),
                        Text("object.title.timeline".tr)
                      ]),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: <Widget>[
      Positioned(top: 0, left: 6, right: 6, child: objectImage),
      Positioned(bottom: 0, left: 6, right: 6, child: objectDescription)
    ]);
  }
}
