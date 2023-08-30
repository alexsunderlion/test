# ClubForce Test App

This is the project for club force's test assessment.

## Getting Started

Open the project directory 'packages/clubforce' in Android Studio.

Retrieve the packages for the project using 'Tools -> Flutter -> Flutter Pub Get' or the following command.
```
flutter pub get
```

Run build runner to generate output file using third party package builders (json_serializable,
freezed, etc).

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

During local development build runner should be running in watch mode, so that generated output
files are recreated when changes are made.

```
flutter packages pub run build_runner watch --delete-conflicting-outputs
```