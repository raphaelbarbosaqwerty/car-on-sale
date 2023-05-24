import 'package:challenge/app/core/di.dart';
import 'package:challenge/app/core/domain/validators/text_form_validator.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:challenge/app/modules/home/presenter/home_cubit.dart';
import 'package:challenge/app/modules/home/presenter/home_state.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_widget.dart';
import 'package:challenge/app/utils/delayed_action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ValueNotifier isButtonValid = ValueNotifier(false);
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final HomeCubit cubit = locator.get<HomeCubit>();
  late final TextEditingController code;
  int vinLength = 17;

  @override
  void initState() {
    super.initState();
    code = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _form.currentState?.validate();
    });
  }

  int delay = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: const [
          LogoutWidget(),
        ],
      ),
      body: BlocListener<HomeCubit, HomeState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is HomeErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: CosTheme.redAlert,
              ),
            );
          } else if (state is HomeErrorWithExtraState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: CosTheme.redAlert,
              ),
            );

            if (state.apiError?.params.hasDelay ?? false) {
              _defineDelayIfExist(state.apiError?.params.delaySeconds ?? 0);
            }
          } else if (state is HomeSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Success!"),
                backgroundColor: CosTheme.greenAlert,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
                      UpperCaseFormatter(),
                    ],
                    textCapitalization: TextCapitalization.characters,
                    validator: (value) =>
                        TextFormValidator.validateVinCode(value),
                    onChanged: (value) {
                      if (value.length == 17 && delay == 0) {
                        isButtonValid.value = true;
                      } else {
                        isButtonValid.value = false;
                      }
                    },
                    maxLength: 17,
                    controller: code,
                    decoration: const InputDecoration(
                      hintText: "VIN Code",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: isButtonValid,
        builder: (context, showButton, _) {
          return FloatingActionButton(
            backgroundColor: showButton
                ? CosTheme.grayDark
                : CosTheme.grayDark.withOpacity(0.5),
            elevation: showButton ? 6 : 0,
            onPressed: () async {
              isButtonValid.value = false;
              await cubit.searchByVin(code.text);
              isButtonValid.value = true;
            },
            child: delay != 0
                ? Text("$delay")
                : const Icon(
                    Icons.search,
                  ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _defineDelayIfExist(int delaySeconds) {
    isButtonValid.value = false;
    delay = delaySeconds;
    DelayedAction.periodic(
      (timer) {
        if (delay == 0) {
          DelayedAction.forceCancel();
          isButtonValid.value = true;
        } else {
          setState(() {
            delay--;
          });
        }
      },
    );
  }
}

class UpperCaseFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
