# Universal Yoga Customer App

Welcome to the **Universal Yoga Customer App**! This guide outlines the prerequisites and steps for setting up and running a Flutter application on your laptop.

---

## Prerequisites

Before you can run the Universal Yoga Customer App, ensure your development environment meets the following requirements:

### 1. **Flutter SDK**
- **Version:** Flutter 3.24.4 (stable channel)
- **Installation Path:** `/Users/your-username/development/flutter`
- **Upstream Repository:** [Flutter GitHub Repository](https://github.com/flutter/flutter.git)

**To install Flutter:**
- Follow the [official installation guide](https://docs.flutter.dev/get-started/install) for your operating system.

---

### 2. **Dart SDK**
- **Version:** Dart 3.5.4 (included with Flutter)

No separate installation is required; Dart is bundled with the Flutter SDK.

---

### 3. **Development Tools**

#### **Android Toolchain**
- **Android SDK Version:** 35.0.0  
- **Build Tools:** 35.0.0  
- **Installation Path:** `/Users/your-username/Library/Android/sdk`
- **Java Version:** OpenJDK 21.0.3+ (included with Android Studio)  

**Steps to set up:**
- Install Android Studio 2024.2 (recommended).
- Ensure all Android licenses are accepted:
  ```bash
  flutter doctor --android-licenses
  ```

#### **iOS Toolchain (Xcode)**
- **Xcode Version:** 16.0  
- **Installation Path:** `/Applications/Xcode.app/Contents/Developer`
- **CocoaPods Version:** 1.15.2  

**Steps to set up:**
- Install Xcode via the App Store.
- Ensure CocoaPods is installed or updated:
  ```bash
  sudo gem install cocoapods
  ```

#### **Web Development**
- Browser: Google Chrome  
- **Installation Path:** `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`

#### **Desktop Development**
- Supported Platforms:
  - macOS
  - Mac Designed for iPad  

---

### 4. **Development Environments**

- **Android Studio**
  - Version: 2024.2  
  - Install [Flutter Plugin](https://plugins.jetbrains.com/plugin/9212-flutter).  
  - Install [Dart Plugin](https://plugins.jetbrains.com/plugin/6351-dart).  

- **Visual Studio Code (VS Code)**
  - Version: 1.95.3  
  - Install [Flutter Extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter).  

---

### 5. **Connected Devices**
Ensure you have one of the following options for testing:
- **Android Emulator** (e.g., sdk gphone64 arm64 on API 35)  
- **macOS Desktop**  
- **Web Browser** (Google Chrome)  

---

### 6. **Network Resources**
Confirm that all required network resources are available.

---

## Project Setup

Clone the repository and navigate to the project directory:

```bash
git clone <repository-url>
cd universal_yoga_customer_app_new
```

Run `flutter doctor` to verify your environment:

```bash
flutter doctor -v
```

Install dependencies:

```bash
flutter pub get
```

---

## Running the Application

To launch the app, use the following commands:

- **Android:**
  ```bash
  flutter run -d android
  ```

- **iOS:**
  ```bash
  flutter run -d ios
  ```

- **Web:**
  ```bash
  flutter run -d chrome
  ```

- **Desktop (macOS):**
  ```bash
  flutter run -d macos
  ```

---

## Resources for Beginners

If you're new to Flutter, check out these resources:
- [Write Your First Flutter App](https://docs.flutter.dev/get-started/codelab)
- [Flutter Cookbook](https://docs.flutter.dev/cookbook)

For more details, refer to the [Flutter Online Documentation](https://docs.flutter.dev/).

--- 

Happy Coding! 🎉