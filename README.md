# nittiv_new_version

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials, samples, guidance on
mobile development, and a full API reference.

rules_version = '2'; service firebase.storage { match /b/{bucket}/o { match /{allPaths=**} { allow
read, write: if false; } match /users/{userId}/{allPaths=**} { allow read: if true; allow write: if
request.auth.uid == userId; } } }

# Use this command to be able to display image for web

flutter run -d chrome --web-renderer html