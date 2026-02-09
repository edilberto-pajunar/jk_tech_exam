# jk_tech_exam

# Assessment

1. I only follow the register and login api.
2. I validate if the user is existing in the mock @user.dart, then call the api itself.
3. Some example data are on the model itself.
4. I also created a whole abstract for calling the api @client/
5. I implement a local storage for caching the current user, and validates then reroute if the user is valid then go to the @home_page.
6. Please use "123456" when inputting OTP.

Flutter app built with clean architecture, BLoC, and common form/validation and testing tooling.

## Business

App provides auth (login/register), profile creation, and a dashboard (account, community). It uses the ReqRes API for auth and user data.

## Technical

- **State:** BLoC (flutter_bloc)
- **Architecture:** Clean (features, repositories, data/domain layers)
- **Navigation:** go_router
- **Forms:** flutter_form_builder + form_builder_validators
- **Serialization:** json_serializable
- **Testing:** mockito (+ bloc_test), generated mocks
- **DI:** get_it

## How to run

**Prerequisites:** Flutter SDK (see `environment.sdk` in `pubspec.yaml`).

```bash
# Dependencies
flutter pub get

# Code generation (models / mocks)
dart run build_runner build --delete-conflicting-outputs

# Run app
flutter run
```

## Required `.env` file

Create a `.env` file at the project root (copy from `.env.example`):

```bash
cp .env.example .env
```

Then set the ReqRes API key:

- **REQRES_API_KEY** – API key for ReqRes API (used in `x-api-key` header).

Example:

```env
REQRES_API_KEY=your_key_here
```

The app loads `.env` at startup via `flutter_dotenv` in `lib/bootstrap.dart`. Do not commit real keys; keep `.env` in `.gitignore`.

## Tests

```bash
flutter test
```

Generate mocks after changing interfaces:

```bash
dart run build_runner build --delete-conflicting-outputs
```
