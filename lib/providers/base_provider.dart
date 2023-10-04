import 'package:flutter/material.dart';
import 'package:rpgtracker_app/data/rest_result.dart';

abstract class BaseProvider<T> extends ChangeNotifier {
  List<T> data = [];
  bool loading = true;
  int page = 0;
  bool canLoadMore = true;

  Future getData({bool loadMore = false});

  Future load(
      Future<RestResult<T>?> Function(int page) getData, bool loadMore) async {
    if (canLoadMore) {
      if (loadMore) {
        page = page + 1;
      }
      loading = true;
      notifyListeners();
      var content = await getData(page);
      if (content != null) {
        data.addAll(content.content);
      }
      loading = false;
      canLoadMore = content == null || !(content.last ?? true);
      notifyListeners();
    }
  }
}
