import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/presentation/base/base_ui.dart';
import 'package:upm/presentation/components/atoms/upm_text.dart';
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
        title: 'Dashboard',
        titleColor: AppColors.textLightColor,
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
          color: AppColors.backgroundLightColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (itemId) {
            setState(() {
              selectedMenuItemId = itemId;
            });
          },
          selectorColor: AppColors.primaryColor,
          footerView: const Padding(
            padding: EdgeInsets.all(8.0),
            child: UpmText(text: 'Version 1.0.0'),
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
              child: UpmText(
                text: menuItem.title,
                textColor:
                    isSelected ? AppColors.cardDarkColor : AppColors.textColor,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            );
          },
        ),
      ],
      // builder: (context, id) => IndexedStack(
      //   index: id,
      //   children: menu.items
      //       .map((e) => Center(
      //             child: Text("Page~${e.title}"),
      //           ))
      //       .toList(),
      // ),
    );
  }

  @override
  PreferredSizeWidget? buildAppBar() => null;
}
