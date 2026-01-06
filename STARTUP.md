# Progress Cloud - Startup Checklist

This guide will help you get the Progress Cloud application running on your machine.

---

## 📋 Prerequisites Checklist

Before starting, ensure you have the following installed:

### Required Software

- [ ] **Flutter SDK** (3.0.0 or higher)
  - Download from: https://docs.flutter.dev/get-started/install
  - Verify installation: `flutter --version`

- [ ] **Dart SDK** (comes with Flutter)
  - Verify: `dart --version`

- [ ] **Git**
  - Verify: `git --version`

### Recommended IDEs (pick one)

- [ ] **Android Studio** with Flutter plugin
- [ ] **VS Code** with Flutter and Dart extensions
- [ ] **IntelliJ IDEA** with Flutter plugin

### Platform-Specific Requirements

#### For Android Development:
- [ ] **Android SDK** (installed via Android Studio)
- [ ] **Android Emulator** or physical device
- [ ] Verify: `flutter doctor --android-licenses` (accept all)

#### For iOS Development (macOS only):
- [ ] **Xcode** (latest stable version)
- [ ] **CocoaPods**: `sudo gem install cocoapods`
- [ ] iOS Simulator or physical device
- [ ] Verify: `xcode-select --install`

#### For Web Development:
- [ ] **Chrome browser**
- [ ] Enable web support: `flutter config --enable-web`

---

## 🚀 Installation Steps

### 1. Clone the Repository

```bash
# If you haven't already
git clone <repository-url>
cd Progress-Cloud
```

### 2. Verify Flutter Installation

```bash
flutter doctor -v
```

**Expected output**: All required components should show ✓ (checkmarks)

**Common issues**:
- If Android licenses are not accepted: `flutter doctor --android-licenses`
- If cmdline-tools not found: Install via Android Studio SDK Manager

### 3. Install Dependencies

```bash
flutter pub get
```

**Expected output**:
```
Running "flutter pub get" in Progress-Cloud...
Resolving dependencies...
+ drift 2.14.0
+ flutter_riverpod 2.4.9
...
Changed X dependencies!
```

### 4. Generate Code

This project uses code generation for Drift (database) and Riverpod. Run:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

**Expected output**:
```
[INFO] Generating build script completed, took 2.1s
[INFO] Creating build script completed, took 203ms
[INFO] Generating files...
[INFO] Generated .dart files!
```

**Note**: This step is CRITICAL. The app will not compile without generated files.

**If you encounter errors**:
```bash
# Clean and retry
flutter pub run build_runner clean
flutter pub run build_runner build --delete-conflicting-outputs
```

### 5. Verify Project Structure

Check that these key directories exist:

```bash
ls -la lib/
```

**Expected directories**:
- `lib/domain/` - Business logic and models
- `lib/persistence/` - Database layer
- `lib/ui/` - User interface
- `lib/main.dart` - App entry point

---

## 🏃 Running the Application

### Option 1: Using Command Line

```bash
# List available devices
flutter devices

# Run on a specific device
flutter run -d <device-id>

# Run in debug mode (default)
flutter run

# Run in release mode (better performance)
flutter run --release
```

### Option 2: Using IDE

**VS Code**:
1. Open Command Palette (Cmd/Ctrl + Shift + P)
2. Type "Flutter: Select Device"
3. Choose your target device
4. Press F5 or click "Run > Start Debugging"

**Android Studio**:
1. Select device from dropdown in toolbar
2. Click green "Run" button or press Shift + F10

### Expected Behavior on First Run

When the app launches successfully, you should see:

1. **Home Screen** with bottom navigation (4 tabs)
2. **Cloud View** tab (default) showing an empty canvas with a grid
3. **Tasks**, **Goals**, and **Lists** tabs (currently showing placeholders)

---

## ✅ Testing Checklist

Use this checklist to verify the application is working correctly.

### Basic Functionality Tests

#### 1. Application Launch
- [ ] App launches without crashes
- [ ] No error dialogs appear on startup
- [ ] Bottom navigation bar is visible with 4 tabs

#### 2. Navigation Tests
- [ ] Tap "Cloud" tab - Shows cloud visualization screen
- [ ] Tap "Tasks" tab - Shows task list screen
- [ ] Tap "Goals" tab - Shows goal list screen
- [ ] Tap "Lists" tab - Shows lists screen
- [ ] Tab indicator moves correctly when switching tabs

#### 3. Cloud View Tests

**Canvas Interaction**:
- [ ] Pinch to zoom in - Canvas zooms in smoothly
- [ ] Pinch to zoom out - Canvas zooms out smoothly
- [ ] Two-finger drag - Canvas pans in all directions
- [ ] Grid lines are visible
- [ ] Grid responds to zoom/pan transformations

**Current State** (No data yet):
- [ ] Canvas shows empty with grid background
- [ ] No nodes are displayed (expected - data layer not connected)
- [ ] No connections are displayed (expected)

#### 4. Screen Placeholder Tests
- [ ] Task List Screen shows "Tasks" title and placeholder text
- [ ] Goal List Screen shows "Goals" title and placeholder text
- [ ] Lists Screen shows "Lists" title and placeholder text

### Performance Tests

- [ ] App starts within 3-5 seconds
- [ ] Navigation between tabs is smooth (< 100ms)
- [ ] Cloud view zoom/pan gestures are responsive
- [ ] No visible lag or stuttering during interactions
- [ ] Memory usage is reasonable (check with `flutter run --profile`)

### Visual Tests

- [ ] Material Design 3 theme is applied
- [ ] Bottom navigation icons are visible
- [ ] Tab labels are readable
- [ ] Colors are consistent across screens
- [ ] Grid lines are subtle but visible

---

## 🧪 Advanced Testing

### Run Unit Tests

```bash
flutter test
```

**Current state**: No tests implemented yet (this is expected based on IMPLEMENTATION.md)

### Run in Profile Mode

For performance testing:

```bash
flutter run --profile
```

This enables:
- Performance overlay (tap top-right to show FPS)
- Observatory for debugging
- Better approximation of release performance

### Check for Linting Issues

```bash
flutter analyze
```

**Expected**: No issues or only minor warnings

---

## 🔧 Troubleshooting Common Issues

### Issue: "flutter: command not found"

**Solution**:
1. Ensure Flutter is installed
2. Add Flutter to PATH:
   ```bash
   export PATH="$PATH:`pwd`/flutter/bin"
   ```
3. Restart terminal
4. Run `flutter doctor`

### Issue: "No devices found"

**Solution**:
- **Android**: Start an emulator via Android Studio or connect a physical device with USB debugging enabled
- **iOS**: Open Simulator.app or connect an iPhone with developer mode enabled
- **Web**: Ensure Chrome is installed
- Run `flutter devices` to verify detection

### Issue: Build runner fails with "conflicting outputs"

**Solution**:
```bash
flutter pub run build_runner clean
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### Issue: "MissingPluginException"

**Solution**:
1. Stop the app
2. Run `flutter clean`
3. Run `flutter pub get`
4. Restart the app

### Issue: Gradle build fails (Android)

**Solution**:
1. Update Android SDK via Android Studio
2. Accept licenses: `flutter doctor --android-licenses`
3. Increase Gradle memory in `android/gradle.properties`:
   ```
   org.gradle.jvmargs=-Xmx2048m
   ```

### Issue: Pod install fails (iOS)

**Solution**:
```bash
cd ios
pod repo update
pod install
cd ..
flutter clean
flutter run
```

---

## 📊 Current Implementation Status

Based on IMPLEMENTATION.md, here's what's working and what's not:

### ✅ Working (Ready to Test)
- Flutter project structure
- All domain models (Task, Goal, List, ListItem, Connection, MetricEntry)
- Database schema (Drift tables defined)
- Repository interfaces (defined, not implemented)
- Business logic services (MetricAggregator, ProgressCalculator)
- UI screens (Home, Cloud, Tasks, Goals, Lists)
- Cloud visualization (CustomPainter with zoom/pan/tap)
- Navigation system

### ⚠️ Not Yet Functional (Expected to Be Empty/Placeholder)
- Data persistence (repositories not implemented)
- State management (Riverpod providers not created)
- CRUD operations (no forms for creating/editing entities)
- Cloud view data (no real nodes/connections to display)
- Metric entry tracking (UI not built)
- Progress displays (visual indicators not connected)

**This means**: The app will launch and you can navigate around, but you can't create tasks, goals, or lists yet. The cloud view will be empty.

---

## 🎯 What to Test Right Now

Given the current implementation state, focus on testing:

1. **Build Process**
   - Does `flutter pub get` succeed?
   - Does `build_runner` generate code without errors?
   - Does the app compile for your target platform?

2. **App Launch**
   - Does the app start without crashes?
   - Is the UI responsive?

3. **Navigation**
   - Do all 4 tabs work?
   - Are screen transitions smooth?

4. **Cloud View Gestures**
   - Does zoom work?
   - Does pan work?
   - Is the grid visible?

5. **Visual Polish**
   - Does the Material Design 3 theme look correct?
   - Are there any visual glitches?

---

## 🔜 Next Steps After Startup

Once you've verified the app runs, the next development priorities (from IMPLEMENTATION.md) are:

1. Implement repository implementations (Drift-based data access)
2. Set up Riverpod providers for state management
3. Build CRUD forms for creating tasks, goals, and lists
4. Connect CloudPainter to real data via providers
5. Implement metric entry forms
6. Add progress visualization to UI
7. Write tests

---

## 📞 Getting Help

If you encounter issues:

1. Check `flutter doctor -v` output
2. Review error messages in console
3. Search Flutter documentation: https://docs.flutter.dev
4. Check Drift documentation: https://drift.simonbinder.eu
5. Verify you've run code generation: `flutter pub run build_runner build`

---

## 🎉 Success Checklist

You're ready to start developing if:

- [ ] `flutter doctor` shows no critical issues
- [ ] `flutter pub get` completes successfully
- [ ] Code generation completes without errors
- [ ] App launches on at least one device/emulator
- [ ] You can navigate between all 4 tabs
- [ ] Cloud view responds to zoom/pan gestures
- [ ] No runtime errors appear in console

**If all boxes are checked, you're good to go!** 🚀

---

*Last updated: 2026-01-06*
*Project version: 0.1.0+1*
