import 'dart:io';

import 'package:clean_art/core/exports.dart';

import '../models/blog_model.dart';

abstract class BlogFirebaseDataSource {
  Future<void> uploadBlog({required BlogModel blogModel});

  Future<String> uploadImage(
      {required BlogModel blogModel, required File file});

  Future<List<BlogModel>> getBlogs();
}

class BlogFirebaseDataSourceImpl implements BlogFirebaseDataSource {
  final FirebaseFirestore _fireStore;
  final FirebaseStorage _storage;
  final _uuid = const Uuid();
  BlogFirebaseDataSourceImpl({
    required FirebaseFirestore fireStore,
    required FirebaseStorage storage,
  })  : _fireStore = fireStore,
        _storage = storage;

  @override
  Future<void> uploadBlog({required BlogModel blogModel}) async {
    try {
      final response = await _fireStore
          .collection("Blogs")
          .doc(blogModel.id)
          .set(blogModel.toMap());
    } on FirebaseException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
  }

  @override
  Future<String> uploadImage(
      {required BlogModel blogModel, required File file}) async {
    try {
      final ref = _storage
          .ref()
          .child("PostImages")
          .child(blogModel.id)
          .child(_uuid.v1().toString());
      await ref.putFile(file);
      final url = await ref.getDownloadURL();
      return url;
    } on FirebaseException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final resp = await _fireStore
          .collection("Blogs")
          .withConverter<BlogModel>(
            fromFirestore: (snapshot, _) => BlogModel.fromMap(snapshot.data()!),
            toFirestore: (movie, _) => movie.toMap(),
          )
          .get()
          .then((value) => value.docs);
      return resp.map((e) => e.data()).toList();
    } on FirebaseException catch (e, s) {
      throw ServerError(message: e.message!);
    } catch (e, s) {
      throw ServerError(message: e.toString());
    }
  }
}
