import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_profile/core/app_constants.dart';
import 'package:user_profile/model/user_model.dart';
import 'package:user_profile/view_model/user_profile_viewmodel.dart';

/*
class UserInputDialog extends StatelessWidget {
  final UserModel? user;
  final String? userId;
  final FirebaseService firebaseService;

  UserInputDialog(
      {this.user, this.userId, required this.firebaseService, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: user?.name ?? "");
    TextEditingController emailController =
        TextEditingController(text: user?.email ?? "");
    TextEditingController addressController =
        TextEditingController(text: user?.address ?? "");
    TextEditingController mobileNoController =
        TextEditingController(text: user?.mobileNo ?? "");
    TextEditingController profilePicController =
        TextEditingController(text: user?.profilePic ?? "");

    return AlertDialog(
      title: Text(user == null
          ? AppConstants.addUserHeader
          : AppConstants.updateUserHeader),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: "Name"),
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: "Email"),
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: addressController,
            decoration: const InputDecoration(labelText: "Address"),
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: mobileNoController,
            decoration: const InputDecoration(labelText: "MobileNo"),
          ),
          SizedBox(height: 2.h),
          TextField(
            controller: profilePicController,
            decoration: const InputDecoration(labelText: "ProfilePic"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(AppConstants.btnCancel),
        ),
        TextButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                emailController.text.isNotEmpty &&
                addressController.text.isNotEmpty &&
                mobileNoController.text.isNotEmpty &&
                profilePicController.text.isNotEmpty) {
              UserModel newUser = UserModel(
                id: user?.id ?? 0,
                name: nameController.text,
                email: emailController.text,
                address: addressController.text.isEmpty
                    ? ""
                    : addressController.text,
                mobileNo: mobileNoController.text.isEmpty
                    ? ""
                    : mobileNoController.text,
                profilePic: user?.profilePic ??
                    "", // Set to empty if profilePic is not present
              );

              if (userId == null) {
                // Add user
                firebaseService.addUser(newUser, context);
              } else {
                // Update user
                firebaseService.updateUser(userId!, newUser, context);
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(AppConstants.validateAllFields),
                  backgroundColor: Colors.red,
                ),
              );
            }
            Navigator.of(context).pop();
          },
          child:
              Text(user == null ? AppConstants.btnAdd : AppConstants.btnUpdate),
        ),
      ],
    );
  }
}
*/

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
