import 'package:challenge/app/core/di.dart';
import 'package:challenge/app/core/widgets/cos_loading/cos_loading_widget.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:challenge/app/modules/auth/presenter/auth_page.dart';
import 'package:challenge/app/modules/home/presenter/home_page.dart';
import 'package:challenge/app/modules/splash/presenter/splash_cubit.dart';
import 'package:challenge/app/modules/splash/presenter/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashCubit cubit = locator.get<SplashCubit>();

  @override
  void initState() {
    super.initState();
    cubit.validateCache();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is SplashCacheEmptyState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const AuthPage()),
          );
        } else if (state is SplashCacheFilledState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        }
      },
      child: const Scaffold(
        backgroundColor: CosTheme.grayDark,
        body: Center(
          child: CosLoadingWidget(),
        ),
      ),
    );
  }
}
