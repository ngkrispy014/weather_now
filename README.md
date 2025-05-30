# Weather Now

A Flutter-based weather application that fetches and displays weather data in both JSON and XML formats, following clean architecture principles using BLoC.

---

## Flutter Environment

- Flutter version: 3.24.0 (stable)
- Dart version: 3.5.0
- Framework revision: 80c2e84975
- Engine revision: b8800d88be
- DevTools: 2.37.2

---

## Dependencies

| Package                 | Version    | Purpose                                     |
|-------------------------|------------|---------------------------------------------|
| flutter_bloc            | ^9.1.1     | BLoC state management                       |
| dio                    | ^5.8.0+1   | HTTP client for REST API calls              |
| intl                   | ^0.20.2    | Internationalization and date formatting    |
| get_it                 | ^8.0.3     | Dependency injection                        |
| cached_network_image   | ^3.4.1     | Efficient image loading and caching         |
| cupertino_icons        | ^1.0.8     | iOS-style icons (default dependency)        |
| xml                    | ^6.5.0     | XML parsing support                         |
| equatable              | ^2.0.7     | Simplified value equality for BLoC models   |
| flutter_lints          | ^4.0.0     | Recommended lint rules (dev dependency)     |
| flutter_test           | SDK        | Unit and widget testing (dev dependency)    |

---

## Setup Instructions

1. **Install Flutter**

   Ensure Flutter 3.24.0 is installed by running:

   ```bash
   flutter --version

2. **Clone the Repository**

   Ensure Flutter 3.24.0 is installed by running:

   ```bash
   git clone https://github.com/your-username/weather_now.git
cd weather_now


3. **Install Dependencies**

    Run the following command to install all required packages:


   ```bash
    flutter pub get

4. **Run the App**

    Make sure a device or emulator is running, then execute:


   ```bash
    flutter run

4. **Build Apk**

    To build a release APK for Android:


   ```bash
    flutter build apk


