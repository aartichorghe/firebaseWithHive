# user_profile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

//================================================================================================

Below are the main dependencies which are used:

cupertino_icons         ===>        Provides iOS-styled icons for the app.
firebase_core           ===>        Core Firebase functionalities.
cloud_firestore	        ===>        Enables Firestore database integration.
hive_flutter	        ===>       	Flutter bindings for Hive database.
hive		            ===>        Lightweight and fast key-value database.
flutter_screenutil		===>        Makes the app responsive to different screen sizes.
cached_network_image	===>	    Caches network images for efficient loading.
provider		        ===>        Simplifies state management in the app.

//================================================================================================

Folder Structure

The given project follows a modular approach for better scalability and maintenance:

lib/
├── main.dart             # Entry point of the application
├── models/               # Data models used in the app
├── services/             # Firebase and local storage services
├── providers/            # State management using Provider
├── screens/              # UI screens for the application
├── widgets/              # Reusable widgets
└── utils/ 

//================================================================================================

Steps to Run the app

Step 1:

Download or clone this repo by using the link below:

https://github.com/aartichorghe/firebaseWithHive.git

Step 2:

Go to project root and execute the following command in console to get the required dependencies:

flutter pub get

Step 3:

This project uses inject library that works with code generation, execute the following command to generate files:

flutter packages pub run build_runner build --delete-conflicting-outputs

Step 4:

Run the App

Flutter run


