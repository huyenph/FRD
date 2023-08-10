part of drawer_behavior;

class MenuListItem extends StatelessWidget {
  const MenuListItem({
    Key? key,
    required this.title,
    this.isSelected,
    this.menuView,
    required this.textStyle,
    required this.selectorColor,
    this.icon,
    this.drawBorder = false,
    this.direction = DrawerDirection.right,
    this.width,
    this.padding,
    this.suffix,
  }) : super(key: key);

  final String title;
  final bool? isSelected;
  final bool drawBorder;
  final Color? selectorColor;
  final TextStyle? textStyle;
  final SideDrawer? menuView;
  final Widget? icon;
  final Widget? suffix;
  final DrawerDirection direction;
  final double? width;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    TextStyle style = textStyle!
        .copyWith(color: isSelected! ? selectorColor : textStyle!.color);
    List<Widget> children = [];
    if (icon != null) {
      children.add(Padding(
        padding: const EdgeInsets.only(right: 16),
        child: IconTheme(
          data: IconThemeData(color: style.color),
          child: icon!,
        ),
      ));
    }
    children.add(
      Expanded(
        child: FrdText(
          title,
          color: style.color,
        ),
      ),
    );
    if (suffix != null) {
      children.add(
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: IconTheme(
            data: IconThemeData(color: style.color),
            child: suffix!,
          ),
        ),
      );
    }
    return Stack(
      children: [
        if (drawBorder) ...[
          Positioned(
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              color: isSelected == true ? selectorColor! : Colors.transparent,
            ),
          ),
        ],
        Container(
          width: width,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: children,
            ),
          ),
        ),
      ],
    );
  }
}
