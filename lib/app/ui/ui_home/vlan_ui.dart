import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';


class VlanUI extends StatefulWidget {
  const VlanUI({Key? key}) : super(key: key);

  @override
  _VlanUIState createState() => _VlanUIState();
}

class _VlanUIState extends State<VlanUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          BreadCrumb(
            items: <BreadCrumbItem>[
              BreadCrumbItem(content: Text('Item1')),
              BreadCrumbItem(content: Text('Item2')),
              //add your BreadCrumbItem here
            ],
            divider: Icon(Icons.chevron_right),
            overflow: ScrollableOverflow(
              keepLastDivider: false,
              reverse: false,
              direction: Axis.horizontal,
            ),
          ),
          Center(child: CircularProgressIndicator()),
        ],

    )

    );
  }
}
