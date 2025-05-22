import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:taskhub_app/models/note.dart';

class NoteService {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Note>> fetchNote() async {
    CollectionReference notes = firestore.collection("note");
    final snapshot = await notes.get();
    return snapshot.docs.map((doc) => Note.fromFirestore(doc)).toList();
  }

  Future<DocumentSnapshot<Object?>> fetchNoteById(String id) async {
    DocumentReference docData = firestore.collection("note").doc(id);
    return docData.get();
  }

  Future<String?> createNote(Note req) async {
    CollectionReference note = firestore.collection("note");

    try {
      DocumentReference docRef = await note.add({
        "title": req.title,
        "description": req.description,
        "date": req.date,
        "priority": req.priority,
        "section": req.section,
        "created_at": DateTime.now(),
        "updated_at": DateTime.now(),
      });
      return docRef.id;
    } catch (e) {
      return null;
    }
  }

  Future<bool> editNote(Note req) async {
    DocumentReference note = firestore.collection("note").doc(req.id);

    try {
      await note.update({
        "title": req.title,
        "description": req.description,
        "date": req.date,
        "priority": req.priority,
        "section": req.section,
        "updated_at": DateTime.now()
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteNote(String id) async {
    DocumentReference docRef = firestore.collection("note").doc(id);
    try {
      await docRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }
}
