import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:user_profile/model/user_model.dart';
import 'package:user_profile/repository/user_profile_repository.dart';
import 'package:user_profile/view/user_profile_screen.dart';
import 'package:user_profile/view_model/user_profile_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  runApp(
    const UserProfileApp(),
  );
}

class UserProfileApp extends StatelessWidget {
  const UserProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    final userViewModel = UserViewModel(userRepository: userRepository);

    return ScreenUtilInit(
      // Use base screen size for reference
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          home: UserProfileScreen(viewModel: userViewModel),
        );
      },
    );
  }
}
