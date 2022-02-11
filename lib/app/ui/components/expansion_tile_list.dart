import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExpansionTileList extends StatelessWidget {
  final List<DocumentSnapshot> documents;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  ExpansionTileList({required this.documents});

  List<Widget> _getChildren() {
    List<Widget> children = [];
    documents.forEach((doc) {
      children.add(
        ProjectsExpansionTile(
          name: doc['Title'],
          projectKey: doc.id,
          firestore: firestore,
        ),
      );
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: _getChildren(),
    );
  }
}

class ProjectList extends StatelessWidget {
  ProjectList();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('projects').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Loading...');
        //final int projectsCount = snapshot.data.documents.length;
        List<DocumentSnapshot> documents = snapshot.data!.docs;
        return ExpansionTileList(
          documents: documents,
        );
      },
    );
  }
}

class ProjectsExpansionTile extends StatelessWidget {
  ProjectsExpansionTile(
      {required this.projectKey, required this.name, required this.firestore});

  final String projectKey;
  final String name;
  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    PageStorageKey _projectKey = PageStorageKey('$projectKey');

    return ExpansionTile(
      key: _projectKey,
      title: Text(
        name,
        style: TextStyle(fontSize: 28.0),
      ),
      children: <Widget>[
        StreamBuilder(
            stream: firestore
                .collection('projects')
                .doc(projectKey)
                .collection('items')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              //final int surveysCount = snapshot.data.documents.length;
              List<DocumentSnapshot> documents = snapshot.data!.docs;

              List<Widget> surveysList = [];
              documents.forEach((doc) {
                PageStorageKey _surveyKey = new PageStorageKey('${doc.id}');

                surveysList.add(ListTile(
                  key: _surveyKey,
                  title: Text(doc['ItemName']),
                ));
              });
              return Column(children: surveysList);
            })
      ],
    );
  }
}
