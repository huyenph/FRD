part of drawer_behavior;

class DrawerMenu<T> {
  const DrawerMenu({required this.items});

  final List<DrawerMenuItem<T>> items;
}

class DrawerMenuItem<T> {
  DrawerMenuItem({
    this.id,
    required this.title,
    this.icon,
    this.prefix,
    this.suffix,
    this.textStyle,
    this.data,
    required this.widgetContent,
  }) : assert(prefix == null || icon == null);

  final T? id;
  final String title;

  /// set icon from [MenuItem], if the icon is not null, the prefix must be null
  final IconData? icon;

  /// set prefix widget from [MenuItem], if the prefix is not null, the icon must be null
  final Widget? prefix;

  /// set suffix widget from [MenuItem]
  final Widget? suffix;

  /// set independent text style for title
  final TextStyle? textStyle;

  /// append data with [MenuItem], then can be use on itemBuilder
  final dynamic data;

  /// set widget content for item
  final Widget widgetContent;

  DrawerMenuItem<T> copyWith({
    T? id,
    String? title,
    IconData? icon,
    Widget? prefix,
    Widget? suffix,
    TextStyle? textStyle,
    dynamic data,
    Widget? widgetContent,
  }) {
    return DrawerMenuItem<T>(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon,
      prefix: prefix,
      suffix: suffix,
      textStyle: textStyle ?? this.textStyle,
      data: data ?? this.data,
      widgetContent: widgetContent ?? this.widgetContent,
    );
  }
}
