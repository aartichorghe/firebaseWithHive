import 'package:flutter/material.dart';
import 'package:user_profile/core/app_constants.dart';
import 'package:user_profile/core/app_validators.dart';
import 'package:user_profile/model/user_model.dart';
import 'package:user_profile/view_model/user_profile_viewmodel.dart';

class UserInputDialog extends StatefulWidget {
  final UserViewModel viewModel;
  final UserModel? user;

  const UserInputDialog({Key? key, required this.viewModel, this.user})
      : super(key: key);

  @override
  _UserInputDialogState createState() => _UserInputDialogState();
}

class _UserInputDialogState extends State<UserInputDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  late TextEditingController mobileNoController;
  late TextEditingController profilePicController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user?.name ?? "");
    emailController = TextEditingController(text: widget.user?.email ?? "");
    addressController = TextEditingController(text: widget.user?.address ?? "");
    mobileNoController =
        TextEditingController(text: widget.user?.mobileNo ?? "");
    profilePicController =
        TextEditingController(text: widget.user?.profilePic ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    mobileNoController.dispose();
    profilePicController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.user == null
          ? AppConstants.addUserHeader
          : AppConstants.updateUserHeader),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) => AppValidators.validateName(value ?? ""),
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) => AppValidators.validateEmail(value ?? ""),
              ),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (value) =>
                    AppValidators.validateAddress(value ?? ""),
              ),
              TextFormField(
                controller: mobileNoController,
                decoration: const InputDecoration(labelText: "Mobile No"),
                validator: (value) =>
                    AppValidators.validateMobileNo(value ?? ""),
              ),
              TextFormField(
                controller: profilePicController,
                decoration: const InputDecoration(labelText: "Profile Pic"),
                validator: (value) =>
                    AppValidators.validateProfilePic(value ?? ""),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppConstants.btnCancel),
        ),
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newUser = UserModel(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                email: emailController.text,
                address: addressController.text,
                mobileNo: mobileNoController.text,
                profilePic: profilePicController.text,
              );

              if (widget.user == null) {
                widget.viewModel.addUser(newUser);
              } else {
                widget.viewModel.updateUser(newUser);
              }

              Navigator.pop(context);
            }
          },
          child: Text(widget.user == null
              ? AppConstants.btnAdd
              : AppConstants.btnUpdate),
        ),
      ],
    );
  }
}
