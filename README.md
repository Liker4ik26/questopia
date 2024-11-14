# 🕸 **Questopia** - An app for booking and filtering escape rooms.

**Questopia** This powerful and user-friendly app is perfect for all escape room enthusiasts. It not only allows you to search for and book adventure games, but also helps you manage them with maximum convenience. The app lets you add your favorite escape rooms to a wishlist, easily filter by various criteria, and cancel bookings if your plans change.

---

## 📝 Table of Contents

1. [Description](#description)
2. [Features](#features)
3. [Key Features](#key-features)
4. [Installation and Setup](#installation-and-setup)
5. [Technical Details](#technical-details)
6. [Contributing to the Project](#contributing-to-the-project)
7. [Contact](#contact)

---

## 📌 Description 

**Questopia** is a mobile app developed using **Flutter**. This powerful and user-friendly app is perfect for all escape room enthusiasts. It not only allows you to search for and book adventure games, but also helps you manage them with maximum convenience. The app lets you add your favorite escape rooms to a wishlist, easily filter by various criteria, and cancel bookings if your plans change.

- 📱 **Platforms**: Android
- 🔒 **Hive**: Stores favorite quests
- ☁️ **Supabase**: Stores all information about quests.
- 🔔 **Local notifications**: Reminds users about booked quests via notifications

---

## 🚀 Features 

- **User-friendly Interface** 🖥️ Intuitive design with easy navigation makes ordering your favorite coffee fast and simple.
- **Supabase** ☁️  Stores and manages data, ensuring fast and easy access to quests.
- **Email confirmation** 📧  Allows you to confirm your email to secure your account.
- **Local notifications** 🔔  Enables reminders about your booked quests.

---

## 🌟 Key Features

### 1. **Email Registration and Login with Supabase** 📧

Users can easily register or log in using their email address. After registration, they will receive a confirmation email to verify their account. Supabase handles all authentication and account management.

| Registration | Login | Confirmation |
|--------------|-------|--------------|
| ![Email Registration Example 1](https://github.com/user-attachments/assets/69d98b54-3937-464b-b844-9ace93973ad3) | ![Email Registration Example 2](https://github.com/user-attachments/assets/d8f5df92-ab6f-4d37-b866-d630d0774dc6) | ![Email Registration Example 3](https://github.com/user-attachments/assets/ccc4c8ef-d189-43e8-a416-c40e56e8a8e3) |
| *Example of email registration* | *Example of email login* | *Example of email confirmation* |

---

### 2. **Quest Filtering** 🔍

Easily filter quests by various parameters, such as difficulty level or type, to find the perfect adventure. This helps users narrow down their choices and find quests that best match their preferences.

| **Quest Filtering** |
|---------------------|
| ![Quest Filtering Example](https://github.com/user-attachments/assets/34839f82-cc68-4507-a05f-4a1630b05d71) |
| *Example of quest filtering* |


---

### 3. **Category Selection** 📂

Select from various categories of quests, such as scary, kid-friendly, or beginner-friendly. This allows users to quickly browse the types of quests they are most interested in.

| **Category Selection** |
|------------------------|
| ![Category Selection Example](https://github.com/user-attachments/assets/750302f3-5a87-4ea6-8630-f41415e29fb0) |
| *Example of selecting a quest category* |


---

### 4. **Book a Quest** 📅

Once you've selected your desired quest, you can easily book it directly from the app. Choose the date and time, enter your phone number, then complete your booking.

| **Book a Quest** |
|------------------|
| ![Book a Quest Example](https://github.com/user-attachments/assets/153f7720-8453-46c8-b200-6e493a58f7fa) |
| *Example of booking a quest* |


---

### 5. **Cancel a Quest** ❌

If plans change, you can cancel your booked quest directly from the app.

| **Cancel a Quest** |
|--------------------|
| ![Cancel a Quest Example](https://github.com/user-attachments/assets/3c5ddcca-acf7-44dd-b3fd-46813b9aace1) |
| *Example of cancelling a quest* |


---

### 6. **Add and Remove Quests from Favorites** 💖

You can mark quests as favorites, making it easy to return to them later. Add or remove quests from your favorites with a single tap.

| **Add to Favorites** |
|----------------------|
| ![Add to Favorites Example](https://github.com/user-attachments/assets/61543c25-2bda-4630-90ce-5fb69578ff76) |
| *Example of adding a quest to favorites* |


---

### 7. **Profile Editing** ✏️

Edit your personal information, such as full name and phone number, directly in the app.

| **Profile Editing** |
|---------------------|
| ![Profile Editing Example](https://github.com/user-attachments/assets/d3130457-794f-40dc-87a5-81ccfd4154a9) |
| *Example of editing user profile* |


---

### 8. **Quest Search** 🔍

Search for quests by name. The app provides a quick and intuitive search feature to help you find exactly the quest you're looking for.

| **Quest Search** |
|------------------|
| ![Quest Search Example](https://github.com/user-attachments/assets/0fad0762-9299-4b8c-9fe9-510c75348228) |
| *Example of quest search* |


---

### 9. **Logout** 🚪

When you're done, you can log out of your account with a single tap.

| **Logout** |
|------------|
| ![Logout Example](https://github.com/user-attachments/assets/6ad1d1dc-99d7-4754-ad92-1985ca568f9a) |
| *Example of logging out* |

---

## ⚙️ Installation and Setup

### Steps to run the project on an Android device:

1. **Install necessary tools:**
   Ensure that you have all the necessary tools for Flutter development installed:
   
   - **Flutter SDK**: If you haven't installed Flutter yet, download and install it from the [official Flutter website](https://flutter.dev/docs/get-started/install).
   - **Android Studio**: Make sure Android Studio is installed, and that the Android SDK and emulators are properly set up.

2. **Clone the project repository:**
   Download or clone the project source code:
   ```bash
   git clone https://github.com/Liker4ik26/questopia.git
   cd taskmaster
   ```
   
3. **Install dependencies:**
   Open your terminal and run the following command to install all the necessary dependencies:
   ```bash
    flutter pub get
   ```

4. **Connect an Android device:**
   Connect your Android device via USB or launch an Android emulator through Android Studio.
   To check if the device is connected, run the following command:
   ```bash
    flutter devices
   ```

5. **Run the app on the device:**
   To launch the app on the connected device, run the following command:
   ```bash
   flutter run
   ```
---

## 🧑‍💻 Technical Details

**Questopia** uses the following technologies:

- **Flutter** — for cross-platform development
- **Supabase** — remote database
- **Bloc** — for state management
- **Hive** — for storing favorites
- **GoRoute** — for project navigation
- **Dio** — for making network requests
- **Get it** — for Dependency Injection (DI)
- **flutter_dotenv** — for managing .env files
- **flutter_local_notifications** — reminders for booked quests
---

## 🤝 Contributing to the Project

We welcome any contributions to the project! To make changes, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and run the tests.
4. Create a pull request.

Thank you for your help! 🌟
---

## 📬 Contact

- **Developer**: Angelika Semenova
- **GitHub**: [github](https://github.com/Liker4ik26)

---





