import 'package:flutter/material.dart';
import 'package:user_profile/core/app_constants.dart';
import 'package:user_profile/model/user_model.dart';
import 'package:user_profile/view_model/user_profile_viewmodel.dart';

class UserInputDialog extends StatelessWidget {
  final UserViewModel viewModel;
  final UserModel? user;

  UserInputDialog({Key? key, required this.viewModel, this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: user?.name ?? "");
    final emailController = TextEditingController(text: user?.email ?? "");
    final addressController = TextEditingController(text: user?.address ?? "");
    final mobileNoController =
        TextEditingController(text: user?.mobileNo ?? "");
    final profilePicController =
        TextEditingController(text: user?.profilePic ?? "");

    return AlertDialog(
      title: Text(user == null
          ? AppConstants.addUserHeader
          : AppConstants.updateUserHeader),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name")),
            TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email")),
            TextField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address")),
            TextField(
                controller: mobileNoController,
                decoration: const InputDecoration(labelText: "MobileNo")),
            TextField(
                controller: profilePicController,
                decoration: const InputDecoration(labelText: "ProfilePic")),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppConstants.btnCancel),
        ),
        TextButton(
          onPressed: () {
            if (nameController.text.isEmpty ||
                emailController.text.isEmpty ||
                addressController.text.isEmpty ||
                mobileNoController.text.isEmpty ||
                profilePicController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppConstants.validateAllFields),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            final newUser = UserModel(
              id: user?.id ?? DateTime.now().millisecondsSinceEpoch,
              name: nameController.text,
              email: emailController.text,
              address: addressController.text,
              mobileNo: mobileNoController.text,
              profilePic: profilePicController.text,
            );

            if (user == null) {
              viewModel.addUser(newUser);
            } else {
              viewModel.updateUser(user!.id.toString(), newUser);
            }

            Navigator.pop(context);
          },
          child:
              Text(user == null ? AppConstants.btnAdd : AppConstants.btnUpdate),
        ),
      ],
    );
  }
}
