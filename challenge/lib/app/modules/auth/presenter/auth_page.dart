import 'package:challenge/app/core/di.dart';
import 'package:challenge/app/core/domain/models/user.dart';
import 'package:challenge/app/core/widgets/cos_loading/cos_loading_widget.dart';
import 'package:challenge/app/design/global_theme.dart';
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
        backgroundColor: GlobalTheme.grayDark,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: email,
              decoration: const InputDecoration(
                hintText: "Unique identifier",
                border: OutlineInputBorder(),
              ),
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
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalTheme.grayDark, // Background color
                    ),
                    onPressed: () async {
                      await cubit.save(User(
                        name: name.text,
                        uniqueId: email.text,
                      ));
                    },
                    child: const Text('Enter'),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
