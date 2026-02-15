# CampusReserve 🎓

CampusReserve is a cross-platform mobile application built with Flutter designed to streamline the booking of university resources, including classrooms, quiet study desks, and specialized media labs.

This project demonstrates a modular architecture, responsive design principles (mobile & tablet), and robust form validation without reliance on heavy external packages.

## 📱 Features

### Core Functionality
* **Room Browsing:** Browse available spaces with a clean, responsive grid layout.
* **Smart Filtering:** Filter rooms by category (Free vs. Premium tiers).
* **Booking System:** Complete booking flow with date selection and time-range validation.
* **User Profile:** View user details and toggle app-wide settings.

### Technical Highlights (Assignment Requirements)
* **Responsive UI:**
    * **Portrait:** Uses a standard `BottomNavigationBar` for mobile navigation.
    * **Landscape:** Automatically switches to a `NavigationRail` (side navigation) and adjusts grid layouts for tablets/desktop.
* **Form Validation:**
    * Ensures all required fields (Purpose, Date) are filled.
    * **Logic Validation:** Prevents selecting an End Time that is earlier than the Start Time.
    * **Tier Logic:** Differentiates between Standard (Free) and Premium functionalities.
* **Theme Support:** Fully functional **Light/Dark Mode** toggle using `ValueNotifier` for efficient state management.

## 🛠️ Tech Stack

* **Framework:** Flutter (Dart)
* **State Management:** Native `ValueNotifier` & `setState` (No external boilerplate).
* **Architecture:** MVC (Model-View-Controller) inspired modular file structure.
* **Design System:** Material Design 3.

## 📂 Project Structure

The codebase is organized for maintainability and scalability:

```text
lib/
├── models/
│   └── room_model.dart         # Data class and static mock data
├── screens/
│   ├── login_screen.dart       # User authentication UI
│   ├── dashboard_screen.dart   # Main grid view of rooms
│   ├── booking_detail_screen.dart # Form with validation logic
│   ├── bookings_screen.dart    # List of active bookings
│   └── profile_screen.dart     # Settings and Theme toggle
├── widgets/
│   └── navigation_wrapper.dart # Responsive root navigation logic
└── main.dart                   # Entry point and Theme data
