import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/modules/events/screens/event_screen.dart';
import 'package:upm/modules/settings/setting_screen.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/upm_app_bar.dart';
import 'package:upm/presentation/components/drawer_behavior/drawer_behavior.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.message}) : super(key: key);

  final RemoteMessage? message;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends BaseState<MainScreen> {
  late List<DrawerMenuItem<int>> _items;
  late DrawerMenu _menu;
  bool _isMenuInitialized = false;

  // DrawerMenu menuWithIcon = DrawerMenu<int>(
  //   items: items,
  // );

  late RemoteNotification? notification;
  int? selectedMenuItemId;
  DrawerScaffoldController controller = DrawerScaffoldController();

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isMenuInitialized) {
      _items = [
        DrawerMenuItem<int>(
          id: 0,
          title: S.of(context).events,
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
          title: S.of(context).settings,
          prefix: const Icon(Icons.settings),
          widgetContent: const SettingScreen(),
        ),
      ];
      _menu = DrawerMenu(items: _items);
      selectedMenuItemId = _menu.items[0].id;
      _isMenuInitialized = true;
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    return DrawerScaffold(
      controller: controller,
      appBar: UpmAppBar(
        elevation: 0.0,
        title: _items[selectedMenuItemId!].title,
        leading: GestureDetector(
          onTap: () => controller.toggle(),
          child: const Icon(Icons.menu),
        ),
      ),
      drawers: [
        SideDrawer(
          percentage: 1,
          elevation: 0.0,
          menu: _menu,
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
          footerView: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${S.of(context).version} 1.0.0'),
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
                horizontal: 16,
                // vertical: 16,
              ),
              child: ListTile(
                leading: menuItem.prefix,
                minLeadingWidth: 10,
                contentPadding: const EdgeInsets.all(0),
                title: Text(
                  menuItem.title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          },
        ),
      ],
      builder: (context, id) => IndexedStack(
        index: id,
        children: _menu.items.map((e) => e.widgetContent).toList(),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
