part of drawer_behavior;

typedef DrawerScaffoldBuilder = Widget Function(
  BuildContext context,
  MenuController? menuController,
);

/// a Scaffold wrapper
class DrawerScaffold extends StatefulWidget {
  DrawerScaffold({
    this.appBar,
    this.body,
    this.contentShadow = const [
      BoxShadow(
        color: Color(0x44000000),
        offset: Offset(0.0, 5.0),
        blurRadius: 20.0,
        spreadRadius: 10.0,
      ),
    ],
    this.drawers,
    this.cornerRadius = 16.0,
    this.controller,
    this.extendedBody = false,
    this.bottomNavigationBar,
    this.floatingActionButtonLocation,
    this.floatingActionButton,
    this.floatingActionButtonAnimator,
    this.builder,
    this.enableGestures = true,
    this.defaultDirection = DrawerDirection.left,
    this.bottomSheet,
    this.extendBodyBehindAppBar = false,
    this.persistentFooterButtons,
    this.primary = true,
    this.resizeToAvoidBottomInset,
    this.onSlide,
    this.onOpened,
    this.onClosed,
    this.backgroundColor,
    Key? key,
  })  : assert((drawers?.where((element) => element.peekMenu).length ?? 0) < 2,
            "\n\nOnly can have one SideDrawer with peek menu\n"),
        assert(body == null || builder == null, "Use either child or builder"),
        super(key: key);

  /// List of drawers
  final List<SideDrawer>? drawers;

  /// Screen Builder => Widget ScreenBuilder<T>(BuildContext context, T? id)
  final ScreenBuilder? builder;

  /// Screen child
  final Widget? body;

  /// Appbar for Scaffold
  final PreferredSizeWidget? appBar;

  /// set default drawer from which [DrawerDirection], default: [DrawerDirection.left]
  final DrawerDirection defaultDirection;

  /// set controller for [DrawerScaffold]
  final DrawerScaffoldController? controller;

  /// set corner radius, default: 16.0
  final double? cornerRadius;

  /// set background color for [DrawerScaffold], default: [Theme.of(context).scaffoldBackgroundColor]
  final Color? backgroundColor;

  final bool extendedBody;
  final bool? enableGestures;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final FloatingActionButtonAnimator? floatingActionButtonAnimator;
  final List<BoxShadow> contentShadow;
  final Widget? bottomSheet;
  final bool extendBodyBehindAppBar;
  final List<Widget>? persistentFooterButtons;
  final bool primary;
  final bool? resizeToAvoidBottomInset;

  /// Listen to offset value on slide event for which [SideDrawer]
  final Function(SideDrawer, double)? onSlide;

  /// Listen to which [SideDrawer] is opened (offset=1)
  final Function(SideDrawer)? onOpened;

  /// Listen to which [SideDrawer] is closed (offset=0)
  final Function(SideDrawer)? onClosed;

  @override
  _DrawerScaffoldState createState() => _DrawerScaffoldState();

  static MenuController currentController(
    BuildContext context, {
    bool nullOk = true,
  }) {
    final _DrawerScaffoldState? result =
        context.findAncestorStateOfType<_DrawerScaffoldState>();
    if (nullOk || result != null) return result!._controller;
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
          '_SideDrawerState.of() called with a context that does not contain a MenuController.'),
      context.describeElement('The context used was')
    ]);
  }

  static MenuController? getControllerFor(
      BuildContext context, SideDrawer drawer,
      {bool nullOk = true}) {
    final _DrawerScaffoldState? result =
        context.findAncestorStateOfType<_DrawerScaffoldState>();
    if (nullOk || result != null) return result!._getControllerFor(drawer);
    throw FlutterError.fromParts(<DiagnosticsNode>[
      ErrorSummary(
          '_SideDrawerState.of() called with a context that does not contain a MenuController.'),
      context.describeElement('The context used was')
    ]);
  }
}

class _DrawerScaffoldState<T> extends State<DrawerScaffold>
    with TickerProviderStateMixin {
  List<MenuController>? menuControllers;
  // Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  // Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  // Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  // Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  Curve get scaleDownCurve => widget.drawers![focusDrawerIndex].scaleDownCurve;
  Curve get scaleUpCurve => widget.drawers![focusDrawerIndex].scaleUpCurve;
  Curve get slideOutCurve => widget.drawers![focusDrawerIndex].slideOutCurve;
  Curve get slideInCurve => widget.drawers![focusDrawerIndex].slideInCurve;

  int listenDrawerIndex = 0;
  int focusDrawerIndex = 0;

  int get mainDrawerIndex => max(
        0,
        widget.drawers?.indexWhere(
                (element) => element.direction == widget.defaultDirection) ??
            0,
      );

  @override
  void initState() {
    super.initState();
    selectedItemId = widget.drawers![listenDrawerIndex].selectedItemId;
    assignController();
    updateDrawerState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    assignController();
    super.didUpdateWidget(oldWidget as DrawerScaffold);
  }

  @override
  Widget build(BuildContext context) {
    // if (menuControllers?[focusDrawerIndex].state == MenuState.closed) {
    //   focusDrawerIndex = drawerFrom(widget.defaultDirection);
    // }
    focusDrawerIndex = min((widget.drawers?.length ?? 1) - 1, focusDrawerIndex);

    return Stack(
      children: [
        // widget.drawers![i],
        focusDrawerIndex >= 0 ? widget.drawers![focusDrawerIndex] : Container(),

        for (var i = 0; i < (widget.drawers?.length ?? 0); i++)
          if (widget.drawers![i].peekMenu && i != focusDrawerIndex)
            zoomAndSlideContent(widget.drawers![i], true),

        createContentDisplay(),
      ],
    );
  }

  MenuController createController<T>(SideDrawer<T> d) {
    MenuController controller = dcreateController(
      context,
      d,
      this,
      (value) {
        widget.onSlide?.call(d, value);
        if (value == 0) widget.onClosed?.call(d);
        if (value == 1) widget.onOpened?.call(d);
      },
    )..addListener(() => setState(() {}));
    return controller;
  }

  double get totalPeekSize =>
      _getPeekSize(DrawerDirection.left) + _getPeekSize(DrawerDirection.right);
  double _getPeekSize(DrawerDirection direction) {
    try {
      return widget.drawers
              ?.firstWhere((element) =>
                  element.peekMenu && direction == element.direction)
              .peekSize ??
          0;
    } catch (e) {
      return 0;
    }
  }

  double? _getDefaultElevation() {
    try {
      return widget.drawers
          ?.firstWhere((element) => element.peekMenu)
          .elevation;
    } catch (e) {
      return null;
    }
  }

  MenuController dcreateController<T>(BuildContext context, SideDrawer<T> d,
      TickerProvider vsync, Function(double) onAnimated) {
    MenuController controller = MenuController(
      d,
      onAnimated,
      context: context,
      vsync: vsync,
    );

    return controller;
  }

  void assignController() {
    if (menuControllers == null) {
      menuControllers ??= widget.drawers?.map(createController).toList();
    } else {
      for (var i = 0;
          i < (widget.drawers?.length ?? 0) &&
              i < (menuControllers?.length ?? 0);
          i++) {
        menuControllers![i]._drawer = widget.drawers![i];
      }
    }
    for (var i = menuControllers?.length ?? 0;
        i < (widget.drawers?.length ?? 0);
        i++) {
      menuControllers!.add(createController(widget.drawers![i]));
    }
    if (widget.controller != null) {
      widget.controller?._menuControllers = menuControllers;
      widget.controller?._setFocus = (index) {
        focusDrawerIndex = index;
      };
    }
  }

  void updateDrawerState() {
    if (widget.controller != null) {
      if (widget.controller?._open != null) {
        menuControllers
            ?.firstWhere((element) =>
                element._drawer.direction == widget.controller!._open)
            .open();
      } else {
        menuControllers?.forEach((element) {
          element.close();
        });
      }
    }
  }

  PreferredSizeWidget? createAppBar() {
    if (widget.appBar != null) {
      return widget.appBar;
      // if (widget.appBar is AppBar) {
      //   final appBar = widget.appBar as AppBar;
      //   return AppBar(
      //       actionsIconTheme: appBar.actionsIconTheme,
      //       excludeHeaderSemantics: appBar.excludeHeaderSemantics,
      //       shape: appBar.shape,
      //       key: appBar.key,
      //       backgroundColor: appBar.backgroundColor,
      //       leading: appBar.leading ??
      //           IconButton(
      //             icon: const Icon(Icons.menu),
      //             onPressed: () {
      //               focusDrawerIndex = mainDrawerIndex;
      //               menuControllers![mainDrawerIndex].toggle();
      //             },
      //           ),
      //       title: appBar.title,
      //       automaticallyImplyLeading: appBar.automaticallyImplyLeading,
      //       actions: appBar.actions,
      //       flexibleSpace: appBar.flexibleSpace,
      //       bottom: appBar.bottom,
      //       elevation: appBar.elevation,
      //       // brightness: appBar.brightness,
      //       iconTheme: appBar.iconTheme,
      //       // textTheme: appBar.textTheme,
      //       primary: appBar.primary,
      //       centerTitle: appBar.centerTitle,
      //       titleSpacing: appBar.titleSpacing,
      //       toolbarHeight: appBar.toolbarHeight,
      //       // backwardsCompatibility: appBar.backwardsCompatibility,
      //       foregroundColor: appBar.foregroundColor,
      //       leadingWidth: appBar.leadingWidth,
      //       shadowColor: appBar.shadowColor,
      //       systemOverlayStyle: appBar.systemOverlayStyle,
      //       titleTextStyle: appBar.titleTextStyle,
      //       toolbarTextStyle: appBar.toolbarTextStyle,
      //       toolbarOpacity: appBar.toolbarOpacity,
      //       bottomOpacity: appBar.bottomOpacity);
      // } else {
      //   return widget.appBar;
      // }
    }
    return null;
  }

  double startDx = 0.0;
  double percentage = 0.0;
  bool isOpening = false;

  Widget? body;

  T? selectedItemId;
  bool isDrawerOpen() {
    return menuControllers?.where((element) => element.isOpen()).isNotEmpty ==
        true;
  }

  int drawerFrom(DrawerDirection direction) {
    return menuControllers?.indexWhere((element) {
          return element._drawer.direction == direction;
        }) ??
        -1;
  }

  Widget createContentDisplay() {
    if (selectedItemId != widget.drawers![listenDrawerIndex].selectedItemId ||
        body == null) {
      selectedItemId = widget.drawers![listenDrawerIndex].selectedItemId;
      body = widget.body ?? widget.builder?.call(context, selectedItemId);
    }
    Widget scaffoldWidget = SizedBox(
      width: MediaQuery.sizeOf(context).width - totalPeekSize,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: createAppBar(),
        body: body,
        extendBody: widget.extendedBody,
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        bottomNavigationBar: widget.bottomNavigationBar,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        bottomSheet: widget.bottomSheet,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
        persistentFooterButtons: widget.persistentFooterButtons,
        primary: widget.primary,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      ),
    );

    double maxSlideAmount =
        widget.drawers![focusDrawerIndex].maxSlideAmount(context);

    Widget content = !widget.enableGestures!
        ? scaffoldWidget
        : GestureDetector(
            child: AbsorbPointer(
                absorbing: isDrawerOpen() && widget.appBar != null,
                child: scaffoldWidget),
            onTap: () {
              menuControllers?.forEach((element) {
                if (element.isOpen()) element.close();
              });
            },
            onHorizontalDragStart: (details) {
              isOpening = !isDrawerOpen();
              double width = MediaQuery.sizeOf(context).width;
              startDx = -1;

              if (details.globalPosition.dx < maxSlideAmount + 60) {
                int focusDrawer = drawerFrom(DrawerDirection.left);

                if (focusDrawer < 0) {
                } else {
                  focusDrawerIndex = focusDrawer;
                  if (isDrawerOpen()) {
                    startDx = details.globalPosition.dx;
                  } else if (details.globalPosition.dx < 60) {
                    startDx = details.globalPosition.dx;
                  }
                }
              }
              if (startDx < 0 &&
                  details.globalPosition.dx > width - maxSlideAmount - 60) {
                int focusDrawer = drawerFrom(DrawerDirection.right);

                if (focusDrawer < 0) {
                  return;
                } else {
                  focusDrawerIndex = focusDrawer;

                  if (isDrawerOpen()) {
                    startDx = details.globalPosition.dx;
                  } else if (details.globalPosition.dx > width - 60) {
                    startDx = details.globalPosition.dx;
                  }
                }
              }
            },
            onHorizontalDragUpdate: (details) {
              if (startDx == -1) return;

              double dx = (details.globalPosition.dx - startDx);
              MenuController menuController =
                  menuControllers![focusDrawerIndex];
              if (menuController._drawer.direction == DrawerDirection.right) {
                dx = -dx;
              }
              if (isOpening && dx > 0 && dx <= maxSlideAmount) {
                percentage = fixed(dx / maxSlideAmount, 3);

                menuController._animationController.animateTo(percentage,
                    duration: const Duration(microseconds: 0));
                menuController._animationController
                    .notifyStatusListeners(AnimationStatus.forward);
              } else if (!isOpening && dx <= 0 && dx >= -maxSlideAmount) {
                percentage = fixed(1.0 + dx / maxSlideAmount, 3);

                menuController._animationController.animateTo(percentage,
                    duration: const Duration(microseconds: 0));
                menuController._animationController
                    .notifyStatusListeners(AnimationStatus.reverse);
              }
            },
            onHorizontalDragEnd: (details) {
              if (startDx == -1) return;
              menuControllers?.forEach((menuController) {
                if (percentage < 0.5) {
                  menuController.close();
                } else {
                  menuController.open();
                }
              });
            },
          );

    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

    return zoomAndSlideContent(
      Container(
        decoration: BoxDecoration(
          color: widget.backgroundColor ??
              Theme.of(context).scaffoldBackgroundColor,
        ),
        child: isIOS
            ? content
            : WillPopScope(
                child: content,
                onWillPop: () {
                  return Future(() {
                    if (isDrawerOpen()) {
                      menuControllers?.forEach((element) {
                        element.close();
                      });
                      return false;
                    }
                    return true;
                  });
                }),
      ),
    );
  }

  Widget zoomAndSlideContent(Widget content, [bool isDrawer = false]) {
    MenuController menuController = menuControllers![focusDrawerIndex];

    SideDrawer drawer = widget.drawers![focusDrawerIndex];

    double slidePercent = menuController._slidePercent;
    double contentScale = menuController.contentScale;
    double slideAmount = menuController.slideAmount;
    final cornerRadius = (drawer.cornerRadius ?? widget.cornerRadius)! *
        menuController.percentOpen;

    double degreeAmount = (drawer.degree ?? 0) * slidePercent;
    degreeAmount = degreeAmount * pi / 180;

    Matrix4 perspective;
    if (drawer.degree == null) {
      perspective = Matrix4.translationValues(slideAmount, 0.0, 0)
        ..scale(contentScale, contentScale);
    } else {
      // perspective = _pmat(0, 1).scaled(1.0, 1.0, 1.0)
      perspective = Matrix4.identity()
        ..translate(slideAmount, 0.0, 0)
        ..scale(contentScale, contentScale)
        ..setEntry(
            3, 2, drawer.direction == DrawerDirection.left ? 0.001 : -0.001)
        ..rotateY(degreeAmount)
        ..rotateX(0.0)
        ..rotateZ(0.0);

      // if (drawer.direction == DrawerDirection.left) {
      //   perspective.translate(slideAmount, 0.0, 0);
      //   perspective.scale(contentScale, contentScale);
      // }
    }

    final defaultElavation = _getDefaultElevation();
    double elevation = defaultElavation ?? drawer.elevation * slidePercent;
    return Transform(
      transform: perspective,
      origin: drawer.degree != null
          ? Offset(MediaQuery.sizeOf(context).width / 2, 0.0)
          : drawer.direction == DrawerDirection.right
              ? Offset(
                  MediaQuery.sizeOf(context).width -
                      drawer.elevation -
                      totalPeekSize,
                  0.0)
              : null,
      alignment: Alignment.centerLeft,
      child: Card(
        margin: isDrawer
            ? EdgeInsets.zero
            : defaultElavation == null
                ? EdgeInsets.symmetric(horizontal: elevation)
                : EdgeInsets.fromLTRB(
                    _getPeekSize(DrawerDirection.left),
                    0,
                    _getPeekSize(DrawerDirection.right),
                    0,
                  ),
        elevation: elevation,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: content,
      ),
    );
  }

  MenuController get _controller => menuControllers![focusDrawerIndex];
  MenuController? _getControllerFor(SideDrawer drawer) {
    final index = widget.drawers?.indexOf(drawer);
    if (index != null && index >= 0) return menuControllers?[index];
    return null;
  }
}

class DrawerScaffoldMenuController extends StatefulWidget {
  final DrawerScaffoldBuilder? builder;
  final DrawerDirection? direction;

  const DrawerScaffoldMenuController({
    Key? key,
    this.builder,
    this.direction,
  }) : super(key: key);

  @override
  DrawerScaffoldMenuControllerState createState() {
    return DrawerScaffoldMenuControllerState();
  }
}

class DrawerScaffoldMenuControllerState
    extends State<DrawerScaffoldMenuController> {
  MenuController? menuController;

  @override
  void initState() {
    super.initState();
    menuController = getMenuController(context, widget.direction);
    menuController?.addListener(_onMenuControllerChange);
  }

  @override
  void didUpdateWidget(Widget oldWidget) {
    super.didUpdateWidget(oldWidget as DrawerScaffoldMenuController);
    if (menuController != null) {
      menuController?.removeListener(_onMenuControllerChange);
    }
    menuController = getMenuController(context, widget.direction);
    menuController?.addListener(_onMenuControllerChange);
  }

  @override
  void dispose() {
    menuController?.removeListener(_onMenuControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder
            ?.call(context, getMenuController(context, widget.direction)) ??
        const SizedBox();
  }

  MenuController? getMenuController(BuildContext context,
      [DrawerDirection? direction = DrawerDirection.left]) {
    final scaffoldState =
        context.findAncestorStateOfType<_DrawerScaffoldState>()!;
    try {
      return scaffoldState.menuControllers?.firstWhere(
        (element) => element._drawer.direction == direction,
      );
    } catch (e) {
      return null;
    }
  }

  _onMenuControllerChange() {
    setState(() {});
  }
}

typedef ScreenBuilder<T> = Widget Function(BuildContext context, T? id);

class Screen {
  final String? title;
  final DecorationImage? background;
  final WidgetBuilder? contentBuilder;

  final Color? color;

  final Color? appBarColor;

  final bool enableGestures;

  Screen({
    this.title,
    this.background,
    this.contentBuilder,
    this.color,
    this.appBarColor,
    this.enableGestures = true,
  });
}

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;
  final Function(double) onAnimated;
  dynamic _value;
  dynamic get value => _value;
  set value(dynamic value) {
    _value = value;
  }

  updateValue(dynamic value) {
    _value = value;
    notifyListeners();
  }

  Duration duration;
  MenuState state = MenuState.closed;
  double _slidePercent = 0, _scalePercent = 0;
  double slideAmount = 0, contentScale = 0;

  SideDrawer _drawer;

  double get slidePercent => _slidePercent;
  double get scalePercent => _scalePercent;
  MenuController(this._drawer, this.onAnimated,
      {required this.vsync, BuildContext? context})
      : duration = _drawer.duration ?? const Duration(milliseconds: 250),
        _animationController = AnimationController(vsync: vsync) {
    _animationController
      ..duration = duration
      ..addListener(() {
        calculate(context);

        onAnimated(_animationController.value);

        notifyListeners();
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            state = MenuState.opening;
            break;
          case AnimationStatus.reverse:
            state = MenuState.closing;
            break;
          case AnimationStatus.completed:
            state = MenuState.open;
            break;
          case AnimationStatus.dismissed:
            state = MenuState.closed;
            break;
        }

        notifyListeners();
      });
    calculate(context);
  }

  calculate(BuildContext? context) {
    switch (state) {
      case MenuState.closed:
        _slidePercent = 0.0;
        _scalePercent = 0.0;
        break;
      case MenuState.open:
        _slidePercent = 1.0;
        _scalePercent = 1.0;
        break;
      case MenuState.opening:
        _slidePercent = _drawer.slideOutCurve.transform(percentOpen);
        _scalePercent = _drawer.scaleDownCurve.transform(percentOpen);
        break;
      case MenuState.closing:
        _slidePercent = _drawer.slideInCurve.transform(percentOpen);
        _scalePercent = _drawer.scaleUpCurve.transform(percentOpen);
        break;
    }
    contentScale = 1.0 - ((1.0 - _drawer.percentage) * scalePercent);
    slideAmount = (_drawer.maxSlideAmount(context) - _drawer.elevation - 2) *
        slidePercent;
    if (_drawer.degree != null) {
      slideAmount = slideAmount * (1 - (1 - contentScale) / 2);
      if (_drawer.direction == DrawerDirection.right) {
        slideAmount = -slideAmount;
      }
    } else if (_drawer.direction == DrawerDirection.right) {
      slideAmount = -slideAmount;
    }
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  isOpen() {
    return state == MenuState.open;
  }

  toggle() {
    if (state == MenuState.open) {
      close();
    } else if (state == MenuState.closed) {
      open();
    }
  }
}

class DrawerScaffoldController {
  List<MenuController>? _menuControllers;

  late ValueChanged<int> _setFocus;

  DrawerScaffoldController({DrawerDirection? open}) : _open = open;

  final DrawerDirection? _open;
  toggle([DrawerDirection direction = DrawerDirection.left]) {
    if (isOpen()) {
      closeDrawer(direction);
    } else {
      openDrawer(direction);
    }
  }

  openDrawer([DrawerDirection direction = DrawerDirection.left]) {
    int index = _menuControllers!
        .indexWhere((element) => element._drawer.direction == direction);
    if (index >= 0) {
      _setFocus(index);
      _menuControllers![index].open();
    }
  }

  closeDrawer([DrawerDirection direction = DrawerDirection.left]) {
    _menuControllers!
        .firstWhere((element) => element._drawer.direction == direction)
        .close();
  }

  ValueChanged<bool>? onToggle;

  bool isOpen([DrawerDirection direction = DrawerDirection.left]) =>
      _menuControllers
          ?.where((element) =>
              element._drawer.direction == direction && element.isOpen())
          .isNotEmpty ==
      true;
}

enum MenuState {
  closed,
  opening,
  open,
  closing,
}
