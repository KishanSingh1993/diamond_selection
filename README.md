# Diamond Selection App

A Flutter application for browsing, filtering, and managing a diamond inventory with a persistent cart.

## Project Structure
- `assets/`: Contains the `data.json` file with diamond data.
- `lib/`
    - `bloc/`: BLoC files for state management (DiamondBloc and CartBloc).
    - `models/`: Data model for Diamond.
    - `pages/`: UI screens (FilterPage, ResultPage, CartPage).
    - `main.dart`: App entry point.
    - `data.dart`: Data loading logic.

## State Management Logic
- **DiamondBloc**: Manages diamond data loading, filtering, and sorting.
    - Events: `LoadDiamonds`, `FilterDiamonds`
    - States: `DiamondInitial`, `DiamondLoading`, `DiamondLoaded`, `DiamondError`
- **CartBloc**: Manages cart operations with persistent storage.
    - Events: `LoadCart`, `AddToCart`, `RemoveFromCart`
    - States: `CartInitial`, `CartLoaded`

## Persistent Storage Usage
- Uses `shared_preferences` to store cart data as JSON.
- Cart data persists across app restarts.
- Loaded and saved in `CartBloc` using `SharedPreferences`.

## Setup Instructions
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.
3. Ensure `assets/data.json` is populated with diamond data.
4. Run the app with `flutter run`.

## Features
- Filter diamonds by carat range, lab, shape, color, and clarity.
- Sort results by price or carat (ascending/descending).
- Add/remove diamonds to/from a persistent cart.
- View cart summary with total carat, total price, average price, and average discount.