import 'package:challenge/app/core/di.dart';
import 'package:challenge/app/core/widgets/cos_loading/cos_loading_widget.dart';
import 'package:challenge/app/modules/auth/presenter/auth_page.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_cubit.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogoutWidget extends StatefulWidget {
  const LogoutWidget({super.key});

  @override
  State<LogoutWidget> createState() => _LogoutWidgetState();
}

class _LogoutWidgetState extends State<LogoutWidget> {
  final LogoutCubit cubit = locator.get<LogoutCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AuthPage(),
            ),
          );
        } else if (state is LogoutErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Unable to Logout. Try again."),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: IconButton(
        onPressed: () async {
          await cubit.logout();
        },
        icon: BlocBuilder<LogoutCubit, LogoutState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is LogoutLoadingState) {
              return Transform.scale(
                scale: 0.5,
                child: const CosLoadingWidget(),
              );
            }
            return const Icon(
              Icons.logout,
            );
          },
        ),
      ),
    );
  }
}
