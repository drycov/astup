import 'package:astup/app/res/index.dart';
import 'package:flutter/material.dart';

class DataCard extends StatelessWidget {
  const DataCard(
      {Key? key,
      // required this.data,
      // required this.edit,
      // required this.delete,
      required this.index})
      : super(key: key);

  // final DataModel data;

  // final Function edit;
  // final Function delete;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppThemesColors.error,
          child: IconButton(
            onPressed: () {
              // edit(index);
            },
            icon: const Icon(Icons.edit),
            color: AppThemesColors.white,
          ),
        ),
        title: Text("test"),
        subtitle: Text("test"),
        trailing: CircleAvatar(
          backgroundColor: AppThemesColors.error,
          child: IconButton(
            icon: const Icon(Icons.delete),
            color: AppThemesColors.white,
            onPressed: () {
              // delete(index);
            },
          ),
        ),
      ),
    );
  }
}
