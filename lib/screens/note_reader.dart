import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../styles/app_style.dart';

class NoteReaderScreen extends StatefulWidget {
  NoteReaderScreen(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}
DocumentReference ref = FirebaseFirestore.instance.collection("Notes").doc();
  String myId = ref.id;

class _NoteReaderScreenState extends State<NoteReaderScreen> {

  @override
  Widget build(BuildContext context) {
    int color_id = widget.doc['color_id'];
    String note_title = widget.doc['note_title'];
    String note_content = widget.doc['note_content'];
    String creation_date = widget.doc['creation_date'];
      void delete()
                  // {
                  //   print([note_title,color_id,note_content,creation_date]);
                  // };
                  async {
                await FirebaseFirestore.instance
                    .collection("Notes")
                    .doc()
                    .delete()
                    .then((value) => print("deleted"));
                    
              };
    return Scaffold(
      backgroundColor: AppStyle.cardColor[color_id],
      appBar: AppBar(
        backgroundColor: AppStyle.cardColor[color_id],
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed:delete,

              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
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
