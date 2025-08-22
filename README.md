# Closi - AI-Powered Digital Wardrobe

A modern Flutter app that helps users manage their wardrobe digitally with AI-powered styling and virtual try-on capabilities.

## Features

### Core Features ✅
- **Clerk Authentication**: Secure authentication with email/social sign-in
- **Smart Camera Capture**: Single/batch photo modes with automatic background removal
- **AI Tagging**: 100-200 semantic tags per item using OpenAI for powerful search
- **Virtual Try-On**: Fast 2D warping preview + high-quality Kling/Huhu API integration
- **Body Capture**: Firebase ML Kit pose detection for accurate measurements
- **Wardrobe Management**: Organize items with Hive local storage + cloud sync
- **Outfit Builder**: Create and save outfit combinations with AI recommendations
- **Trial Room**: 2D visualization with AR mode toggle (UI ready)
- **Profile & Settings**: User profile management and app preferences
- **Glass Morphism UI**: Beautiful frosted glass design throughout

### Technical Stack
- **Framework**: Flutter 3.8.1+
- **State Management**: Riverpod 2.5+ with code generation
- **Navigation**: GoRouter 13.2+ integrated with Riverpod
- **Local Storage**: Hive 2.2+ with type adapters
- **Cloud Storage**: Cloudinary or custom solution
- **Authentication**: Clerk Flutter SDK
- **AI Services**: OpenAI GPT-4 Vision for tagging
- **ML Services**: 
  - Google ML Kit for selfie segmentation & pose detection
  - Custom warping service for fast 2D try-on
  - Kling/Huhu API for high-quality virtual try-on
- **Networking**: Dio with interceptors & cookie management
- **UI/UX**: Custom glass morphism widgets with Flutter Animate
- **Image Handling**: Image Picker, Cached Network Image

## Project Structure

```
lib/
├── core/
│   ├── services/       # App services and bindings
│   ├── theme/          # App theme and styling
│   └── widgets/        # Reusable widgets (GlassContainer, OrbNav)
├── data/
│   ├── models/         # Data models (WardrobeItem, Outfit, UserProfile)
│   ├── repositories/   # Data repositories
│   └── services/       # API and storage services
├── features/
│   ├── onboarding/     # Splash, Welcome, Auth, Permissions
│   ├── home/           # Home screen with search
│   ├── wardrobe/       # Wardrobe management screens
│   ├── outfits/        # Outfit builder and library
│   ├── trial/          # Trial room screens
│   ├── profile/        # User profile screen
│   └── settings/       # Settings screen
├── routes/
│   ├── app_routes.dart # Route definitions
│   └── app_pages.dart  # GetX page bindings
└── main.dart           # App entry point
```

## Getting Started

### Prerequisites
- Flutter 3.8.1 or higher
- Dart 3.0 or higher
- iOS 11.0+ / Android API 21+

### Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/closi_ai.git
cd closi_ai
```

2. Install dependencies
```bash
flutter pub get
```

3. Set up environment variables
```bash
cp .env.example .env
# Edit .env with your API keys
```

4. Run code generation
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

5. Run the app
```bash
flutter run
```

### Configuration

#### Required API Keys
- **Clerk**: Sign up at [clerk.com](https://clerk.com) for authentication
- **OpenAI**: Get API key from [platform.openai.com](https://platform.openai.com)
- **Cloud Storage**: Set up Cloudinary or your preferred solution
- **Kling API**: Contact Kling for virtual try-on API access (optional)

#### Environment Variables
See `.env.example` for all required environment variables

## Key Components

### Navigation System
- **Orb Navigation**: Custom floating navigation with glass morphism effect
- **GoRouter**: Declarative routing with Riverpod integration and auth guards

### Data Management
- **Local Storage**: Hive for type-safe offline data persistence
- **Cloud Storage**: Cloudinary integration for image uploads
- **API Service**: Dio-based service with error handling and interceptors
- **Repository Pattern**: Clean separation between data and UI layers with Riverpod providers

### UI/UX Design
- **Glass Morphism**: Consistent frosted glass containers throughout
- **Animations**: Smooth fade and scale animations using flutter_animate
- **Color Scheme**: Purple/pink gradient theme with soft colors

## API Integration

### External Services
- **Clerk API**: User authentication and session management
- **OpenAI API**: Semantic tagging and outfit recommendations
- **Cloud Storage API**: Image upload and management
- **Virtual Try-On API**: Fast warping and high-quality try-on generation

### Custom Backend Endpoints (Optional)
- `/wardrobe/*` - Wardrobe item sync operations
- `/outfits/*` - Outfit management and sharing
- `/upload` - Image upload for wardrobe items

## Development Status

### Completed 
- **State Management Migration**: Fully migrated from GetX to Riverpod
- **Authentication**: Clerk integration with OAuth and email/password
- **Local Storage**: Hive with type adapters for all data models
- **Cloud Storage**: Service layer for Cloudinary integration
- **AI Tagging**: OpenAI GPT-4 Vision for 100-200 semantic tags
- **Camera System**: Batch/single capture with background removal
- **Body Capture**: ML Kit pose detection for measurements
- **Virtual Try-On**: Fast warping service + Kling API integration
- **Navigation**: GoRouter with Riverpod and auth guards
- **UI Components**: Glass morphism theme maintained

### Ready for Testing 
- Camera capture with background removal
- AI semantic tagging workflow
- Body photo validation and measurements
- Virtual try-on preview system

### Next Steps 
- Deploy warping ML model to server
- Obtain Kling API credentials
- Set up Cloudinary account
- Test end-to-end flows
- Add error handling and loading states
- Implement offline sync strategy
- Implement AR features for Trial Room
- Add social features (sharing, following)
- Implement calendar/planner features
- Add weather integration
- Performance optimization and testing

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Flutter team for the amazing framework
- GetX for state management and navigation
- All open-source package contributors:
samples, guidance on mobile development, and a full API reference.
