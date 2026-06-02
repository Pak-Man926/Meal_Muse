import "package:pull_to_refresh/pull_to_refresh.dart";

class HomeScreenController {
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.refreshCompleted();
  }

  void onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.loadComplete();
  }

  void dispose() {
    refreshController.dispose();
  }
}
