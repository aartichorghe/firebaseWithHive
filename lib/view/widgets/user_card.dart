import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_profile/core/app_colors.dart';
import 'package:user_profile/core/app_styles.dart';
import 'package:user_profile/model/user_model.dart';
import 'package:user_profile/view/widgets/user_input_dialogue.dart';
import 'package:user_profile/view_model/user_profile_viewmodel.dart';

class UserCard extends StatelessWidget {
  final UserModel user;
  final UserViewModel viewModel;

  UserCard({Key? key, required this.user, required this.viewModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      elevation: 5,
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.sp),
        child: Row(
          children: [
            CachedNetworkImage(
              height: 90.h,
              width: 90.w,
              fit: BoxFit.cover,
              imageUrl: user.profilePic,
              errorWidget: (context, url, error) => CircleAvatar(
                radius: 20.sp, // smaller circle
                backgroundColor: Colors.grey.shade300,
                child: Icon(Icons.person,
                    size: 35.sp, color: Colors.grey.shade700),
              ),
              placeholder: (context, url) =>
                  const CircularProgressIndicator.adaptive(),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${user.name}', style: AppStyles.style16Normal),
                  SizedBox(height: 2.h),
                  Text('Email: ${user.email}', style: AppStyles.style16Normal),
                  SizedBox(height: 2.h),
                  Text('Address: ${user.address}',
                      style: AppStyles.style16Normal),
                  SizedBox(height: 2.h),
                  Text('MobileNo: ${user.mobileNo}',
                      style: AppStyles.style16Normal),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
            // Edit button
            IconButton(
              icon: Icon(
                Icons.edit_outlined,
                size: 36.sp,
                color: AppColors.colWhite,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (context) =>
                    UserInputDialog(viewModel: viewModel, user: user),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
