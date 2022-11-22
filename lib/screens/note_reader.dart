import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColor[color_id],
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("Notes")
                    .doc('note_title,creation_date,note_content')
                    .delete()
                    .then((value) {
                  Navigator.pop(context);
                }).catchError((error) => print("failed"));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
          // IconButton(
          //     onPressed: () async {
          //       await FirebaseFirestore.instance
          //           .collection("Notes")
          //           .doc()
          //           .update();
          //     },
          //     icon: const Icon(
          //       Icons.edit,
          //       color: Colors.red,
          //     ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.doc["note_title"],
              style: AppStyle.mainTitle,
            ),
            const SizedBox(
              height: 4.0,
            ),
            Text(
              widget.doc["creation_date"],
              style: AppStyle.dateTitle,
            ),
            const SizedBox(
              height: 28.0,
            ),
            Text(
              widget.doc["note_content"],
              style: AppStyle.mainContent,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
