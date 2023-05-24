import 'package:challenge/app/core/di.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/domain/validators/text_form_validator.dart';
import 'package:challenge/app/core/widgets/cos_loading/cos_loading_widget.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:challenge/app/modules/auth/presenter/auth_cubit.dart';
import 'package:challenge/app/modules/auth/presenter/auth_state.dart';
import 'package:challenge/app/modules/home/presenter/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> isButtonValid = ValueNotifier(false);
  final AuthCubit cubit = locator.get<AuthCubit>();
  late final TextEditingController name;
  late final TextEditingController email;

  @override
  void initState() {
    super.initState();
    name = TextEditingController();
    email = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Form(
            onChanged: () {
              isButtonValid.value = _formKey.currentState?.validate() ?? false;
            },
            autovalidateMode: AutovalidateMode.always,
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  key: const Key("name"),
                  controller: name,
                  decoration: const InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      TextFormValidator.validateFieldEmpty(value),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  key: const Key("email"),
                  controller: email,
                  decoration: const InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) =>
                      TextFormValidator.validateFieldEmail(value),
                ),
                const SizedBox(height: 24),
                BlocListener<AuthCubit, AuthState>(
                  bloc: cubit,
                  listener: (context, state) {
                    if (state is AuthSuccessState) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    } else if (state is AuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Error!"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  child: BlocBuilder<AuthCubit, AuthState>(
                    bloc: cubit,
                    builder: (context, state) {
                      if (state is AuthLoadingState) {
                        return const Center(
                          child: CosLoadingWidget(),
                        );
                      }
                      return ValueListenableBuilder(
                          valueListenable: isButtonValid,
                          builder: (context, _isValid, _) {
                            return ElevatedButton(
                              key: const Key("enter"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    CosTheme.grayDark, // Background color
                              ),
                              onPressed: _isValid
                                  ? () async {
                                      await cubit.save(User(
                                        name: name.text,
                                        email: email.text,
                                      ));
                                    }
                                  : null,
                              child: const Text('Enter'),
                            );
                          });
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
