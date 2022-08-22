import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/blocs/app_bloc.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/modules/events/screens/event_screen.dart';
import 'package:upm/modules/settings/setting_screen.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/bottom_menu_bar/bottom_menu_bar.dart';
import 'package:upm/presentation/components/bottom_menu_bar/bottom_menu_item.dart';
import 'package:upm/presentation/components/upm_app_bar.dart';
import 'package:upm/presentation/components/drawer_behavior/drawer_behavior.dart';
import 'package:upm/presentation/components/upm_text_field.dart';

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
  TextEditingController searchController = TextEditingController();
  int _selectedScreenIndex = 0;
  List<BottomMenuItem> _menuItems = [];

  @override
  void initState() {
    super.initState();
    notification = widget.message?.notification;
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   print('addPostFrameCallback');
    // });
    // WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    //   print('addPersistentFrameCallback');
    // });
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      print('schedulerPostFrameCallback');
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isMenuInitialized) {
      _initMenuItems(context);
      _menu = DrawerMenu(items: _items);
      selectedMenuItemId = _menu.items[0].id;
      _isMenuInitialized = true;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocConsumer<AppBloc, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is OnAppConfigChangeState) {
          switch (state.type) {
            case AppConfigType.all:
              break;
            case AppConfigType.theme:
              break;
            case AppConfigType.locale:
              _initMenuItems(context);
              _menu = DrawerMenu(items: _items);
              break;
          }
        }
        return DrawerScaffold(
          controller: controller,
          appBar: _buildAppBar(context),
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
          bottomNavigationBar: _buildBottomNavigationBar(context),
          builder: (context, id) => IndexedStack(
            index: id,
            children: _menu.items.map((e) => e.widgetContent).toList(),
          ),
        );
      },
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;

  void _initMenuItems(BuildContext context) {
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

    _menuItems = [
      BottomMenuItem(
        icon: const Icon(CupertinoIcons.calendar),
        title: Text(
          S.of(context).events,
        ),
      ),
      BottomMenuItem(
        icon: const Icon(Icons.person),
        title: const Text('Music Player'),
      ),
      BottomMenuItem(
        icon: const Icon(Icons.settings),
        title: Text(
          S.of(context).events,
        ),
      ),
    ];
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () => controller.toggle(),
        child: const SizedBox(
          height: 30.0,
          width: 30.0,
          child: CircleAvatar(),
        ),
      ),
      title: TextFormField(
        controller: searchController,
        maxLines: 1,
        keyboardType: TextInputType.text,
        // style: const TextStyle(color: AppColors.textColor),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(AppSize.borderRadiusField),
          // filled: true,
          // fillColor: Colors.transparent,
          hintText: 'Search...',
          hintStyle: TextStyle(color: AppColors.dividerColor),
          // alignLabelWithHint: true,
          border: OutlineInputBorder(),
          prefix: Icon(
            CupertinoIcons.search,
            color: Colors.grey,
            size: 20.0,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BottomMenuBar(
      items: _menuItems,
      onItemSelected: (int index) {
        setState(() {
          _selectedScreenIndex = index;
        });
      },
      selectedIndex: _selectedScreenIndex,
      backgroundColor: Theme.of(context).canvasColor,
      bottomBarRadius: const BorderRadius.only(
        topLeft: Radius.circular(20.0),
        topRight: Radius.circular(20.0),
      ),
    );
  }
}
