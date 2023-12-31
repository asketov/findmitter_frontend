import 'package:findmitter_frontend/ui/widgets/roots/app.dart';
import 'package:findmitter_frontend/ui/widgets/tab_profile/profile/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dtf = DateFormat("dd.MM.yyyy HH:mm");
    var viewModel = context.watch<ProfileViewModel>();
    var appViewModel = context.read<AppViewModel>();
    var size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            appViewModel.msg = "hi";
          },
          child: const Icon(Icons.message),
        ),
        body: SafeArea(
          child: Center(
            child: viewModel.user == null
                ? const CircularProgressIndicator()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        viewModel.avatar == null
                            ? const CircularProgressIndicator()
                            : GestureDetector(
                                onTap: viewModel.changePhoto,
                                child: CircleAvatar(
                                  radius: size.width / 1.5 / 2,
                                  foregroundImage: viewModel.avatar?.image,
                                )),
                        Text(
                          viewModel.user!.name,
                          style: const TextStyle(fontSize: 40),
                        ),
                        Text(
                          viewModel.user!.email,
                          style: const TextStyle(fontSize: 20),
                        ),
                        Text(
                          dtf.format(viewModel.user!.birthDate),
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        TextButton(
                            onPressed: viewModel.logout,
                            child: const Text("exit"))
                      ]),
          ),
        ));
  }

  static create() {
    return ChangeNotifierProvider(
      create: (context) {
        return ProfileViewModel(context: context);
      },
      child: const ProfileWidget(),
    );
  }
}
