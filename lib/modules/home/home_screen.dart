import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/molecules/upm_app_bar.dart';
import 'package:upm/presentation/components/organisms/drawer_behavior/drawer_behavior.dart';

List<DrawerMenuItem<int>> items = [
  DrawerMenuItem<int>(
    id: 0,
    title: 'THE PADDOCK',
    prefix: const Icon(Icons.fastfood),
  ),
  DrawerMenuItem<int>(
    id: 1,
    title: 'THE HERO',
    prefix: const Icon(Icons.person),
  ),
  DrawerMenuItem<int>(
    id: 2,
    title: 'HELP US GROW',
    prefix: const Icon(Icons.terrain),
  ),
  DrawerMenuItem<int>(
    id: 3,
    title: 'SETTINGS',
    prefix: const Icon(Icons.settings),
  ),
];

final menu = DrawerMenu(
  items: items.map((e) => e.copyWith(prefix: null)).toList(),
);

final menuWithIcon = DrawerMenu<int>(
  items: items,
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen> {
  late RemoteNotification? notification;
  int? selectedMenuItemId;
  DrawerScaffoldController controller = DrawerScaffoldController();

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
    selectedMenuItemId = menu.items[0].id;
  }

  @override
  Widget buildBody(BuildContext context) {
    return DrawerScaffold(
      controller: controller,
      appBar: UpmAppBar(
        title: 'UPM Home',
        leading: GestureDetector(
          onTap: () => controller.toggle(),
          child: const Icon(Icons.menu),
        ),
      ),
      drawers: [
        SideDrawer(
          percentage: 1,
          textStyle: const TextStyle(color: Colors.white, fontSize: 24.0),
          menu: menu,
          animation: false,
          alignment: Alignment.topLeft,
          color: Theme.of(context).primaryColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
        ),
      ],
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
