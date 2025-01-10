## Getting Started

Flutter Version -  3.24.0
Dart Version - 3.5.0

## user_profile

This project serves as a starting point for building a Flutter application that integrates Firebase and Hive. It leverages a modular folder structure and key libraries to ensure scalability, maintainability, and efficient performance.

## Features

1> Firebase Integration: Includes Firebase Core for authentication, analytics, and other functionalities.

2> Firestore Database: Easily manage and sync data in real-time with Cloud Firestore.

3> Hive Database: Utilize a lightweight, fast, and secure key-value storage for local data persistence.

4> Responsive Design: Adapt to different screen sizes seamlessly using Flutter ScreenUtil.

5> Efficient Image Loading: Cache and display network images efficiently with Cached Network Image.

6> State Management: Manage app state effectively using the Provider package.

## Dependencies

◦ cupertino_icons: Provides iOS-styled icons for the app.

◦ firebase_core: Core Firebase functionalities.

◦ cloud_firestore: Enables Firestore database integration.

◦ hive_flutter: Flutter bindings for Hive database.

◦ hive: Lightweight and fast key-value database.

◦ flutter_screenutil: Makes the app responsive to different screen sizes.

◦ cached_network_image: Caches network images for efficient loading.

◦ provider: Simplifies state management in the app.

## Dev-Dependencies

◦ build_runner: A command-line tool used to generate files for code generation tasks.

◦ hive_generator: A code generator for Hive that simplifies the creation of type adapters.

## Folder Structure

◦ main.dart: Entry point of the application.

◦ core: Contains core utilities, constants, and configurations used across the app.

◦ models: Contains data models used in the app.

◦ repository: Manages the data layer, including API calls, Firebase queries, and database interactions.

◦ viewmodel: Contains the business logic and state management for the views.

◦ screens: UI screens for the application.

◦ widgets: Contains reusable widgets.

## Firebase Setup

1. Go to the Firebase Console.

2. Create a new project and register your app by providing the package name.

3. Download the google-services.json file (for Android) and place it in the android/app directory.

4. Add the Firebase SDK dependencies to your android/build.gradle and android/app/build.gradle files as per the Firebase Setup Guide.

5. For iOS, download the GoogleService-Info.plist file and place it in the ios/Runner directory. Update the ios/Runner/Info.plist file with the required configurations.

6. Initialize Firebase in your Flutter project by adding the following code in main.dart:
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();

## Hive Setup

1. Add the hive and hive_flutter dependencies to your pubspec.yaml file.

2. Initialize Hive in your main.dart file:
   await Hive.initFlutter();

3. Register Hive adapters for your data models by generating them using hive_generator and build_runner. Define your model classes as follows:
   part 'model.g.dart';

   @HiveType(typeId: 0)
   class MyModel {
   @HiveField(0)
   final String name;

   MyModel(this.name);
   }

4. Run the following command to generate the adapters:
   flutter packages pub run build_runner build --delete-conflicting-outputs

5. Open a Hive box to store and retrieve data:
   var box = await Hive.openBox('myBox');
   box.put('key', 'value');
   var value = box.get('key');
    
## Steps to Run the app

Step 1 : Download or clone this repo by using the link below:
         https://github.com/aartichorghe/firebaseWithHive.git

Step 2 : Go to project root and execute the following command in console to get the required dependencies:  
         flutter pub get

Step 3 : This project uses inject library that works with code generation, execute the following command to generate files:
         flutter packages pub run build_runner build --delete-conflicting-outputs

Step 4 : Run the app
         Flutter run


