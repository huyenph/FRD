part of 'drawer_behavior.dart';

typedef SideDrawerItemBuilder =
    Function(BuildContext context, DrawerMenuItem menuItem, bool selected);

typedef SideDrawerIndexBuilder =
    Function(BuildContext context, int index, bool selected);

abstract class SideDrawerBuilder<ItemType, IdType> {
  MenuController? _menuController;
  SideDrawer<IdType>? _drawer;

  MenuController? get menuController => _menuController;

  SideDrawer<IdType>? get drawer => _drawer;

  onSelected(IdType id) {
    menuController?.updateValue(id);
    drawer?.onMenuItemSelected?.call(id);
    if (drawer?.hideOnItemPressed == true) menuController?.close();
  }

  IdType? get selectedId => menuController?.value;

  set(SideDrawer<IdType> drawer, MenuController? menuController) {
    _menuController = menuController;
    _drawer = drawer;
  }

  Widget build(BuildContext context);
  Widget buildItem(BuildContext context, ItemType t, bool selected);
}

class MenuSideDrawerBuilder<IdType>
    extends SideDrawerBuilder<DrawerMenuItem, IdType> {
  final SideDrawerItemBuilder? builder;
  final DrawerMenu<IdType> menu;

  MenuSideDrawerBuilder(this.menu, this.builder);

  @override
  Widget build(BuildContext context) {
    const animationIntervalDuration = 0.5;
    final perListItemDelay =
        menuController?.state != MenuState.closing ? 0.15 : 0.0;
    final millis =
        menuController?.state != MenuState.closing
            ? 150 * menu.items.length
            : 600;

    final maxDuration =
        (menu.items.length - 1) * perListItemDelay + animationIntervalDuration;

    int i = 0;
    final items =
        menu.items.map((e) {
          final animationIntervalStart = i * perListItemDelay;
          final animationIntervalEnd =
              animationIntervalStart + animationIntervalDuration;
          DrawerMenuItem item = menu.items[i];
          i++;
          return buildListItem(
            context,
            item,
            animationIntervalStart,
            animationIntervalEnd,
            millis,
            maxDuration,
          );
        }).toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }

  @override
  Widget buildItem(BuildContext context, DrawerMenuItem t, bool selected) {
    return builder?.call(context, t, selected);
  }

  bool get useAnimation =>
      drawer?.animation == true && drawer?.peekMenu != true;

  Widget buildListItem(
    BuildContext context,
    DrawerMenuItem item,
    double animationIntervalStart,
    double animationIntervalEnd,
    int millis,
    double maxDuration,
  ) {
    final isSelected = item.id == selectedId;
    Color selectorColor =
        drawer?.selectorColor ?? Theme.of(context).indicatorColor;

    TextStyle? textStyle =
        drawer?.textStyle ??
        Theme.of(context).textTheme.titleMedium?.copyWith(
          color:
              (drawer?.color.computeLuminance() ?? 0) < 0.5
                  ? Colors.white
                  : Colors.black,
        );

    Widget listItem = InkWell(
      child:
          builder == null
              ? MenuListItem(
                padding:
                    drawer?.peekMenu == true
                        ? EdgeInsets.zero
                        : const EdgeInsets.only(left: 32.0),
                direction: drawer?.direction ?? DrawerDirection.left,
                title: item.title,
                isSelected: isSelected,
                selectorColor: selectorColor,
                textStyle: item.textStyle ?? textStyle,
                menuView: drawer,
                width: drawer?.maxSlideAmount(context),
                icon: item.icon == null ? item.prefix : Icon(item.icon),
                suffix: item.suffix,
                drawBorder: !useAnimation,
              )
              : Container(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: drawer?.maxSlideAmount(context),
                  child: buildItem(context, item, isSelected),
                ),
              ),
      onTap: () => onSelected(item.id),
    );

    if (useAnimation) {
      return AnimatedMenuListItem(
        menuState: menuController?.state,
        isSelected: isSelected,
        duration: Duration(milliseconds: millis),
        curve: Interval(
          animationIntervalStart / maxDuration,
          animationIntervalEnd / maxDuration,
          curve: Curves.easeOut,
        ),
        menuListItem: listItem,
      );
    } else {
      return listItem;
    }
  }
}

class CountSideDrawerBuilder extends SideDrawerBuilder<int, int> {
  final SideDrawerIndexBuilder builder;
  final int itemCount;

  CountSideDrawerBuilder(this.itemCount, this.builder);

  @override
  Widget buildItem(BuildContext context, int t, bool selected) {
    return builder(context, t, selected);
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(itemCount, (e) {
      return InkWell(
        child: Container(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: drawer?.maxSlideAmount(context),
            child: buildItem(context, e, selectedId == e),
          ),
        ),
        onTap: () => onSelected(e),
      );
    });

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items,
    );
  }
}

class WidgetSideDrawerBuilder<T> extends SideDrawerBuilder<void, T> {
  final Widget child;

  WidgetSideDrawerBuilder(this.child);

  @override
  Widget buildItem(BuildContext context, dynamic t, bool selected) {
    return child;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      width: drawer?.maxSlideAmount(context),
      child: buildItem(context, null, false),
    );
  }
}
