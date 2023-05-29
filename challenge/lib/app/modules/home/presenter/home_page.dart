import 'package:challenge/app/core/di.dart';
import 'package:challenge/app/core/domain/models/car_information.dart';
import 'package:challenge/app/core/domain/validators/text_form_validator.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:challenge/app/modules/home/presenter/home_cubit.dart';
import 'package:challenge/app/modules/home/presenter/home_state.dart';
import 'package:challenge/app/modules/home/presenter/pages/show_car_page.dart';
import 'package:challenge/app/modules/home/presenter/widgets/cos_preview_car_suggestions/cos_preview_car_suggestions_widget.dart';
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
    final textTheme = Theme.of(context).textTheme;
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
                key: const Key('snack_bar_error'),
                content: Text(state.message),
                backgroundColor: CosTheme.redAlert,
              ),
            );
            isButtonValid.value = true;
          } else if (state is HomeErrorWithExtraState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: const Key('snack_bar_error'),
                content: Text(state.message),
                backgroundColor: CosTheme.redAlert,
              ),
            );

            if (state.apiError?.params.hasDelay ?? false) {
              _defineDelayIfExist(state.apiError?.params.delaySeconds ?? 0);
            }
          } else if (state is HomeSuccessState) {
            isButtonValid.value = true;
            if (state.foundCar() && state.suggestions.isEmpty) {
              _moveToShowPage(state.carInformation);
            } else if (state.suggestions.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => CosPreviewCarSuggestionsWidget(
                  suggestions: state.suggestions,
                ),
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    key: const Key("vinCode"),
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(
                        RegExp(r"\s\b|\b\s"),
                      ),
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
                  BlocBuilder<HomeCubit, HomeState>(
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is HomeSuccessState) {
                        final car = state.carInformation;
                        return Visibility(
                          visible: state.foundCar(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 24),
                              Text(
                                "Last aunction found",
                                style: textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _moveToShowPage(car);
                                },
                                child: ListTile(
                                  title: Text(
                                    "Model: ${car.model}\nAunction ID: ${car.fkUuidAuction}",
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: isButtonValid,
        builder: (context, isValid, _) {
          return FloatingActionButton(
            key: const Key('search'),
            backgroundColor: isValid
                ? CosTheme.grayDark
                : CosTheme.grayDark.withOpacity(0.5),
            elevation: isValid ? 6 : 0,
            onPressed: () async {
              isButtonValid.value = false;
              await cubit.searchByVin(code.text);
            },
            child: Builder(
              builder: (_) {
                if (delay != 0) {
                  return Text("$delay");
                }

                return const Icon(
                  Icons.search,
                );
              },
            ),
          );
        },
      ),
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

  Future<void> _moveToShowPage(CarInformation car) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShowCarPage(
          carInformation: car,
        ),
      ),
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
