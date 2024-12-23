# Smartwatch Companion App

The Smartwatch Companion App is a Flutter-based application designed to monitor health data from a smartwatch. It integrates with a mock Bluetooth SDK to fetch real-time health data and provides a user-friendly interface for managing connected devices and viewing historical health records.

## Features

- **Google Sign-In**: Users can sign in using their Google account.
- **Dashboard**: Displays real-time heart rate and step count.
- **History**: Shows past health records stored in SQLite.
- **Settings**: Manage connected devices and user preferences.
- **User Profile**: Displays user information stored in Firebase Firestore.

## Screenshots

![Login Screen](screenshots/login_screen.png)
![Dashboard Screen](screenshots/dashboard_screen.png)
![History Screen](screenshots/history_screen.png)
![Settings Screen](screenshots/settings_screen.png)
![User Profile Screen](screenshots/user_profile_screen.png)

## Screen Recording

[Watch the app in action](screen_recordings/app_demo.mp4)

## UI Design

- **Color Scheme**:
    - Primary Gradient: `#6A11CB` to `#2575FC`
    - Accent Color: `#6A11CB`
    - Background: `#FFFFFF`
    - Text: `#000000` (Primary), `#808080` (Secondary)

- **Fonts**:
    - Primary Font: Default Flutter font with bold and regular weights.

## Backend

### Firebase

- **Authentication**: Google Sign-In using Firebase Authentication.
- **Firestore**: Stores user profiles with fields for name, email, and photo URL.
- **Cloud Functions**: Handles saving and retrieving user data.

### SQLite

- **Local Storage**: Stores historical health data with fields for date, heart rate, and steps.
- **Data Management**: Deletes records older than seven days or when exceeding 100 entries.

## SDK Integration

- **Mock Bluetooth SDK**: Simulates real-time health data fetching.
- **Data Fetching**: Periodic updates every minute for heart rate and step count.

## State Management

- **GetX**: Used for state management across the app, including user data and history records.

## Setup and Installation

1. **Clone the Repository**: `git clone <repository-url>`
2. **Install Dependencies**: Run `flutter pub get`
3. **Firebase Setup**:
    - Add `google-services.json` to `android/app`.
    - Add `GoogleService-Info.plist` to `ios/Runner`.
4. **Run the App**: Use `flutter run` to start the application.

## Conclusion

The Smartwatch Companion App provides a comprehensive solution for monitoring health data with a seamless user experience. It leverages Firebase for authentication and user data management, while SQLite handles local storage of health records.

For further questions or support, please contact the development team.