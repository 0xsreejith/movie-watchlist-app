# 🎬 Movie Watchlist App

A beautiful, modern Flutter app to manage your movie watchlist with local storage, beautiful UI, and intuitive user experience.

## ✨ Features

### 🎯 Core Features
- **Add Movies** - Add movies with title, optional notes, image URL, and rating
- **Display List** - Beautiful card-based list view with movie information
- **Mark as Watched** - Toggle watched status with visual indicators
- **Edit Movies** - Update movie details anytime
- **Delete Movies** - Remove movies with confirmation dialog
- **Local Storage** - Data persists using Hive database

### 🎨 UI/UX Features
- **Dark Cinematic Theme** - Modern dark mode with purple accents
- **Splash Screen** - Animated startup screen with app branding
- **Responsive Design** - Works on all screen sizes
- **Google Fonts** - Modern typography (Montserrat, Poppins)
- **Star Ratings** - Interactive 5-star rating system
- **Image Support** - Display movie posters from URLs
- **Smooth Animations** - Fluid transitions and interactions

## 📱 Screenshots

### Main Screen
- Movie list with cards
- Watched/unwatched status
- Star ratings
- Edit/Delete actions

### Add/Edit Dialog
- Modal bottom sheet
- Form validation
- Star rating input
- Image URL support

## 🛠️ Technology Stack

- **Framework**: Flutter
- **State Management**: GetX (MVC Pattern)
- **Local Storage**: Hive Database
- **UI Components**: Material Design 3
- **Fonts**: Google Fonts
- **Rating**: flutter_rating_bar

## 📋 Requirements

- Flutter SDK (3.0 or higher)
- Dart SDK (3.0 or higher)
- Android Studio / VS Code
- Android SDK (for Android development)
- iOS SDK (for iOS development)

## 🚀 Installation

### 1. Clone the Repository
```bash
git clone https://github.com/0xsreejith/movie-watchlist-app.git
cd watchlist_app
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Run the App
```bash
flutter run
```

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   ├── movie_model.dart         # Movie data model
│   └── movie_model.g.dart       # Generated Hive adapter
├── controllers/
│   └── movie_controller.dart    # GetX controller for state management
├── views/
│   ├── splash_screen.dart       # Animated splash screen
│   └── movie_list_view.dart     # Main UI components
└── services/
    └── hive_service.dart        # Database operations layer
```

## 🎯 Usage Guide

### Adding a Movie
1. Tap the **"Add Movie"** floating action button
2. Enter the movie title (required)
3. Add optional notes (e.g., "Watch with family")
4. Enter an image URL (optional) - supports .jpg, .png, .webp
5. Set a rating using the star system (optional)
6. Tap **"Save"** to add the movie

### Managing Movies
- **Mark as Watched**: Tap the movie card or the check icon
- **Edit Movie**: Tap the edit (pencil) icon
- **Delete Movie**: Tap the delete (trash) icon and confirm

### Image URLs
Use direct image URLs ending in common image formats:
- `https://picsum.photos/300/450` (example)
- `https://via.placeholder.com/300x450/000000/FFFFFF?text=Movie+Poster`

## 🎨 Customization

### Colors
The app uses a dark theme with:
- **Primary**: Deep Purple
- **Accent**: Amber
- **Background**: Black with gradients
- **Cards**: Dark grey with transparency

### Fonts
- **Titles**: Montserrat (Bold)
- **Body Text**: Poppins (Regular)

## 🔧 Configuration

### Android NDK Version
If you encounter NDK version issues, update your `android/app/build.gradle.kts`:

```kotlin
android {
    ndkVersion = "27.0.12077973"
    // ... other configurations
}
```

## 📊 Data Model

```dart
class Movie {
  String title;        // Required
  String? note;        // Optional
  bool watched;        // Default: false
  String? imageUrl;    // Optional
  double? rating;      // Optional (0-5)
}
```

## 🚀 Deployment

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- GetX for state management
- Hive for local storage
- Google Fonts for typography
- Material Design for UI components

## 📞 Support

If you encounter any issues or have questions:
- Create an issue in the repository
- Check the Flutter documentation
- Review the code comments for implementation details

---

**Made with ❤️ using Flutter**
