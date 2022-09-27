part of base_ui;

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FocusNode _focusNode = FocusNode();

  String appBarTitle = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          return Platform.isIOS;
        }
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(_focusNode),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: buildAppBar(),
          drawer: buildDrawer(),
          bottomNavigationBar: buildBottomNavigationBar(),
          floatingActionButton: buildFloatingActionButton(),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: buildBody(context),
        ),
      ),
    );
  }

  void showLoading() {}

  void dismissLoading() {}

  PreferredSizeWidget? buildAppBar() => FrdAppBar(
        elevation: 0.0,
        title: appBarTitle,
      );

  Drawer? buildDrawer() => null;

  BottomNavigationBar? buildBottomNavigationBar() => null;

  FloatingActionButton? buildFloatingActionButton() => null;

  Widget buildBody(BuildContext context);

  // void showAlertDialog({
  //   String message = '',
  //   String actionLabel = 'OK',
  //   bool isSuccess = true,
  //   VoidCallback? onPressed,
  // }) {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return ToDoAlertDialog(
  //         message: message,
  //         actionLabel: actionLabel,
  //         isSuccess: isSuccess,
  //         onPressed: onPressed,
  //       );
  //     },
  //   );
  // }
}
