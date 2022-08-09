import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/modules/events/screens/event_screen.dart';
import 'package:upm/modules/settings/setting_screen.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/molecules/upm_app_bar.dart';
import 'package:upm/presentation/components/organisms/drawer_behavior/drawer_behavior.dart';

List<DrawerMenuItem<int>> items = [
  DrawerMenuItem<int>(
    id: 0,
    title: 'Events',
    prefix: const Icon(CupertinoIcons.calendar),
    widgetContent: const EventScreen(),
  ),
  DrawerMenuItem<int>(
    id: 1,
    title: 'Music Player',
    prefix: const Icon(Icons.person),
    widgetContent: const Center(
      child: Text('Music Player'),
    ),
  ),
  DrawerMenuItem<int>(
    id: 2,
    title: 'Settings',
    prefix: const Icon(Icons.settings),
    widgetContent: const SettingScreen(),
  ),
];

final menu = DrawerMenu(
  items: items.map((e) => e.copyWith(prefix: null)).toList(),
);

final menuWithIcon = DrawerMenu<int>(
  items: items,
);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
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
        elevation: 0.0,
        title: items[selectedMenuItemId!].title,
        leading: GestureDetector(
          onTap: () => controller.toggle(),
          child: const Icon(Icons.menu),
        ),
      ),
      drawers: [
        SideDrawer(
          percentage: 1,
          elevation: 0.0,
          menu: menu,
          animation: true,
          alignment: Alignment.topLeft,
          color: Theme.of(context).scaffoldBackgroundColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
          selectorColor: AppColors.primaryColor,
          footerView: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Version 1.0.0'),
          ),
          itemBuilder: (
            context,
            menuItem,
            isSelected,
          ) {
            return Container(
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          AppColors.primaryColor.withOpacity(0.15),
                          AppColors.primaryColor.withOpacity(0.25),
                          AppColors.primaryColor.withOpacity(0.35),
                        ],
                      )
                    : null,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  bottomRight: Radius.circular(50.0),
                ),
              ),
              margin: const EdgeInsets.only(right: 5.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
              child: Text(
                menuItem.title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            );
          },
        ),
      ],
      builder: (context, id) => IndexedStack(
        index: id,
        children: menu.items.map((e) => e.widgetContent).toList(),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
