import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_profile/core/app_colors.dart';
import 'package:user_profile/core/app_constants.dart';
import 'package:user_profile/core/app_styles.dart';
import 'package:user_profile/view/widgets/user_input_dialogue.dart';
import 'package:user_profile/view/widgets/user_card.dart';
import 'package:user_profile/view_model/user_profile_viewmodel.dart';

class UserProfileScreen extends StatelessWidget {
  final UserViewModel viewModel;

  UserProfileScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserViewModel>(
      create: (_) => viewModel..fetchUsers(),
      child: Consumer<UserViewModel>(
        builder: (context, vm, _) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: const Text(AppConstants.appbarTitle),
                centerTitle: true,
                backgroundColor: AppColors.colTeal,
              ),
              body: Builder(
                builder: (context) {
                  if (vm.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  }

                  if (vm.error != null) {
                    return Center(child: Text("Error Occurred: ${vm.error}"));
                  }

                  if (vm.users.isEmpty) {
                    return Center(
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => UserInputDialog(viewModel: vm),
                        ),
                        child: Text(
                          AppConstants.emptyUserData,
                          style: AppStyles.style20Normal,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: vm.users.length,
                    itemBuilder: (context, index) {
                      final user = vm.users[index];
                      return GestureDetector(
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (context) => UserInputDialog(
                            viewModel: vm,
                            user: user,
                          ),
                        ),
                        child: UserCard(user: user, viewModel: vm),
                      );
                    },
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => UserInputDialog(viewModel: vm),
                  );
                },
                backgroundColor: AppColors.colTeal,
                child: const Icon(Icons.add),
              ),
            ),
          );
        },
      ),
    );
  }
}
