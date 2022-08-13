import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upm/blocs/app_bloc.dart';
import 'package:upm/common/app_colors.dart';
import 'package:upm/common/app_size.dart';
import 'package:upm/core/navigation/navigation_service.dart';
import 'package:upm/data/datasource/local/boxes.dart';
import 'package:upm/di/injector_setup.dart';
import 'package:upm/domain/models/language_model.dart';
import 'package:upm/generated/l10n.dart';
import 'package:upm/presentation/base/base_ui.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends BaseState<LanguageScreen> {
  List<dynamic> _languages = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AppBloc>().add(OnGetLanguageEvent());
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
          separatorBuilder: (BuildContext context, int index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.fieldSpacingL),
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
                      OnAppConfigEvent(
                        AppConfigType.locale,
                        language: LanguageModel.fromJson(_languages[index]),
                      ),
                    );
                injector<NavigationService>().goBack();
              },
              title: Text(_languages[index]['name']),
              subtitle: Text(_languages[index]['subName']),
              trailing: Boxes.getConfig().values.last.language.locale ==
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
