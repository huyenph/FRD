import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frd/blocs/app_bloc.dart';
import 'package:frd/core/styles/app_colors.dart';
import 'package:frd/core/styles/app_size.dart';
import 'package:frd/core/ui/base_widget_state.dart';
import 'package:frd/data/datasource/local/boxes.dart';
import 'package:frd/data/datasource/local/entities/language_entity.dart';
import 'package:frd/generated/l10n.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends BaseWidgetState<LanguageScreen> {
  List<dynamic> _languages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AppBloc>().add(OnGetLanguageRequested());
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is OnGetLanguageState) {
          _languages = state.languages;
        }
        return ListView.separated(
          itemCount: _languages.length,
          separatorBuilder:
              (BuildContext context, int index) => const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSize.fieldSpacingL,
                ),
                child: Divider(
                  height: 1.0,
                  thickness: 0.1,
                  color: AppColors.dividerColor,
                ),
              ),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: () {
                context.read<AppBloc>().add(
                  OnAppConfigChangeRequested(
                    AppConfigType.locale,
                    language: LanguageEntity.fromJson(_languages[index]),
                  ),
                );
                navService.goBack();
              },
              title: Text(_languages[index]['title']),
              subtitle: Text(_languages[index]['subTitle']),
              trailing:
                  Boxes.getAppConfig().values.last.language.locale ==
                          _languages[index]['locale']
                      ? const Icon(CupertinoIcons.checkmark_alt)
                      : const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }

  @override
  String get appBarTitle => S.of(context).language;
}
