# 💬 Scholar Chat - Real-Time Messaging App

"Scholar Chat" is a modern, real-time messaging application built with Flutter and powered by Firebase. It demonstrates practical implementation of backend-as-a-service (BaaS), secure user authentication, and real-time database synchronization for a seamless chat experience.

## 📸 App Preview

| Login Screen | Register Screen | Chat Interface |
| :---: | :---: | :---: |
| <img src="https://github.com/user-attachments/assets/d1c12195-315e-49b2-9688-495f5f5b8b1c" width="230" /> | <img src="https://github.com/user-attachments/assets/41137f3f-a522-4b0b-9dfc-6544d0cb8bf8" width="230" /> | <img src="https://github.com/user-attachments/assets/25a5bb01-92a4-40e4-b640-4a3b6221c23b" width="230" /> |

## ✨ Key Features
- **Real-Time Messaging:** Instantly send and receive messages using Cloud Firestore real-time listeners.
- **Secure Authentication:** User registration and login flows powered by Firebase Authentication.
- **Custom Chat Bubbles:** A clean, dynamic UI that visually differentiates between sent and received messages.
- **Bilingual UI Support:** Features Arabic interfaces for authentication and tailored UX for the target audience.

## 🛠️ Tech Stack & Backend
- **Frontend Framework:** Flutter / Dart
- **Backend & Database:** Firebase (Cloud Firestore)
- **Authentication:** Firebase Auth (Email & Password)
- **State Management:** SetState / Flutter Core

## 📂 Folder Structure
The application is structured to separate UI components from data models:
```text
lib/
 ┣ models/           # Data models (e.g., MessageModel)
 ┣ screens/          # Application views (Login, Register, ChatPage)
 ┣ widgets/          # Reusable components (ChatBubble, CustomTextField, CustomButton)
 ┗ main.dart         # Entry point and Firebase initialization
```

## 🚀 How to Run
1. Clone the repository:
   ```bash
   git clone [https://github.com/your-username/chat_app.git](https://github.com/your-username/chat_app.git)
   ```
2. Connect to your own Firebase Project:
   - Replace the existing `google-services.json` in the `android/app` directory with your own.
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```
