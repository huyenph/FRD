import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:frd/core/bloc/base_bloc.dart';
import 'package:frd/core/exceptions.dart';
import 'package:frd/core/extensions.dart';
import 'package:frd/core/navigation/navigation_service.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';
import 'package:frd/di/injector_setup.dart';

abstract class BaseWidgetState<T extends StatefulWidget> extends State<T>
    implements RestApiListener {
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FocusNode _focusNode = FocusNode();
  final NavigationService navService = injector<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Platform.isIOS
          ? null
          : () async {
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
          body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: buildBody(context),
          ),
        ),
      ),
    );
  }

  @override
  void onSuccess(SuccessType type) {}

  @override
  void onError(Exception e) async {
    String? message;
    if (e is DioException) {
      final dioError = e.error;
      if (dioError is ConnectionException) {
        message = dioError.message.capitalize();
      } else if (dioError is UnauthorizedException) {
        // showSnackbarAlert(
        //   S.of(context).sessionExpired,
        //   callBack: () async {
        //     await Boxes.logout();
        //     navService.removeAllUntil(loginRoute);
        //   },
        // );
      } else if (dioError is ForbiddenException) {
        message = dioError.message.capitalize();
      } else if (dioError is ManuallyException) {
        if (dioError.data != null) {
          message = dioError.data!.errorMessage.capitalize();
        }
      }
    } else if (e is ManuallyException) {
      message = e.message;
    } else if (e is ConnectionException) {
      message = e.message;
    }
    if (message != null) {
      showSnackbarAlert(message);
    }
  }

  PreferredSizeWidget? buildAppBar() => null;

  String appBarTitle = '';

  Color? backgroundColor;

  Drawer? buildDrawer() => null;

  Widget? buildBottomNavigationBar() => null;

  FloatingActionButton? buildFloatingActionButton() => null;

  Widget buildBody(BuildContext context);

  void showSnackbarAlert(
    String message, {
    Function? callBack,
  }) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
          SnackBar(
            content: Text(message),
            margin: const EdgeInsets.all(AppSize.fieldSpacingL),
            padding: const EdgeInsets.all(AppSize.fieldSpacingL),
            behavior: SnackBarBehavior.floating,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.borderRadiusField),
              ),
            ),
            showCloseIcon: true,
            closeIconColor: AppColors.bgLightColor,
          ),
        )
        .closed
        .then((value) {
      if (callBack != null) {
        callBack();
      }
    });
  }
}
