# E-Commerce Flutter App

A modular, scalable e-commerce application built with Flutter, featuring onboarding, authentication, product browsing, cart management, and secure checkout with credit card support.

---

## 🚀 Features

- **Onboarding Flow:** Splash screen and introduction screens to guide new users.
- **Authentication:** Login, registration, password reset, OTP verification, and success screens.
- **Product Browsing:** Scrollable screens to view a list of products.
- **Product Selection:** Select products, view details, and choose the desired quantity.
- **Cart & Checkout:** Add products to a cart, view selected items with prices and amounts, and proceed to checkout.
- **Credit Card Payment:** Checkout process supports credit card payments.
- **State Management:** Uses the BLoC (Business Logic Component) pattern for scalable and testable state management.
- **Reusable Widgets:** Custom buttons, text fields, modals, and social login components.
- **Consistent Theming:** Centralized color and text style management.
- **Modern UI:** Uses Google Fonts and SVG assets for a polished look.

---

## 🛠️ Tools & Packages

- **Flutter SDK** (>=3.7.0)
- **flutter_bloc:** State management using the BLoC pattern.
- **equatable:** Simplifies value comparisons in Dart objects.
- **google_fonts:** Easy use of Google Fonts in the app.
- **cupertino_icons:** iOS-style icons.
- **flutter_svg:** SVG image support.
- **Material Design:** Built-in Flutter Material components.

---

## 📁 Project Structure

```
lib/
│
├── main.dart
├── app_theme.dart
├── constants/
│   ├── colors.dart
│   └── text_styles.dart
│
├── auth/
│   ├── bloc/
│   ├── screens/
│   └── widgets/
│
├── onboarding/
│   ├── bloc/
│   ├── screens/
│   └── widgets/
```

---

## 🏁 Getting Started

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd e_commerce
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

---

## 📦 Assets

- All assets are located in the `assets/` directory and registered in `pubspec.yaml`.

---

## 🤝 Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements and bug fixes.

---
