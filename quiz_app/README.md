# Project 05 — Quiz App

## Features
- 10 multiple-choice questions
- One answer selection per question
- Immediate correct/incorrect feedback and explanations
- Progress bar and live score
- Final score and percentage
- Restart quiz
- Responsive Flutter web layout

## Run on Windows using Chrome

1. Extract `quiz_app.zip`.
2. Open the extracted `quiz_app` folder in VS Code using **File → Open Folder**.
3. Select **Terminal → New Terminal**. Make sure the terminal is inside the folder containing `pubspec.yaml` and `lib`.
4. Generate Flutter platform files:
   ```cmd
   "C:\Users\praga\Downloads\flutter_windows_3.47.7-stable\flutter\bin\flutter.bat" create .
   ```
   Preserve `lib/main.dart` and `pubspec.yaml` if asked about overwriting.
5. Install dependencies:
   ```cmd
   "C:\Users\praga\Downloads\flutter_windows_3.47.7-stable\flutter\bin\flutter.bat" pub get
   ```
6. Run in Chrome:
   ```cmd
   "C:\Users\praga\Downloads\flutter_windows_3.47.7-stable\flutter\bin\flutter.bat" run -d chrome
   ```

If Flutter is installed in a different location, replace the path with your actual Flutter SDK `bin\flutter.bat` path.

## Important
- Main app code is in `lib/main.dart`.
- Run commands in the extracted `quiz_app` folder, not another project folder.
- Paste only Dart source code into `main.dart`, without Markdown code fences.
- This beginner project keeps quiz progress in memory; it does not save results after the app closes.
