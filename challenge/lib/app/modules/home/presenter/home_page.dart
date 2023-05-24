import 'package:challenge/app/core/di.dart';
import 'package:challenge/app/design/cos_theme.dart';
import 'package:challenge/app/modules/home/presenter/home_cubit.dart';
import 'package:challenge/app/modules/home/presenter/home_state.dart';
import 'package:challenge/app/modules/home/presenter/widgets/logout/logout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ValueNotifier showSearchButton = ValueNotifier(false);
  final HomeCubit cubit = locator.get<HomeCubit>();
  late final TextEditingController code;
  int vinLength = 17;

  @override
  void initState() {
    super.initState();
    code = TextEditingController();
  }

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
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  onChanged: (value) {
                    if (value.length == 17) {
                      showSearchButton.value = true;
                    } else {
                      showSearchButton.value = false;
                    }
                  },
                  maxLength: 17,
                  controller: code,
                  decoration: const InputDecoration(
                    hintText: "VIN Code",
                    border: OutlineInputBorder(),
                  ),
                ),
                // const Text(
                //   'You have pushed the button this many times:',
                // ),
                // Text(
                //   "Test",
                //   style: Theme.of(context).textTheme.headlineMedium,
                // ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ValueListenableBuilder(
        valueListenable: showSearchButton,
        builder: (context, showButton, _) {
          return Visibility(
            visible: showButton,
            child: FloatingActionButton(
              onPressed: () async {
                await cubit.searchByVin(code.text);
              },
              tooltip: 'Increment',
              child: const Icon(
                Icons.search,
              ),
            ),
          );
        },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
