# Kiwi 🥝

**Track. Search. Sync. Organize.**

Kiwi is a modern, cross-platform movie and TV show tracking and streaming application. Built to provide a seamless and visually stunning experience for all your entertainment needs.

## Features
- **Discover:** Find new movies and TV shows to watch.
- **Track:** Keep track of your progress across all your favorite series.
- **Sync:** Sync your library across all your devices using Supabase.
- **Modern UI:** Built with Flutter, offering a beautiful, fast, and responsive user interface with a sleek dark theme.

## 🛠 Setup Guide (Frontend & Backend)

To build and run Kiwi yourself, you will need to set up the backend database (Supabase) and configure your Flutter environment.

### 1. Backend Setup (Supabase)
Kiwi uses [Supabase](https://supabase.com/) for user authentication, cloud sync, and watch rooms.
1. Create a free account at [Supabase](https://supabase.com/) and create a new project.
2. In your Supabase SQL editor, you need to create the following tables (or run the migration script if available):
   - `mylist`
   - `history`
   - `watch_rooms`
   - `room_participants`
   - `room_messages`
   - `backups`
3. Go to Storage and create a public bucket named `avatars`.
4. Go to **Project Settings > API** and copy your **Project URL** and **anon public key**.
5. Open `lib/core/environment.dart` in the source code and replace the default Supabase credentials:
   ```dart
   static const String supabaseUrl = 'YOUR_SUPABASE_URL';
   static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
   ```

### 2. Frontend Setup (Flutter)
1. Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) (version 3.11.5 or newer).
2. Clone this repository:
   ```bash
   git clone https://github.com/Reinhart-py/kimi.git
   cd kimi
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app on your connected device or emulator:
   ```bash
   flutter run
   ```

### 3. Third-Party Trackers (Optional)
By default, Kiwi includes Client IDs for tracking integrations (AniList, MyAnimeList, Simkl). If you want to use your own Developer API keys:
1. Register a new OAuth application on [Simkl](https://simkl.com/), [AniList](https://anilist.co/), etc.
2. Set the redirect URI to `kiwi://[provider]-auth` (e.g., `kiwi://simkl-auth`).
3. Replace the `clientId` and `clientSecret` variables in `lib/core/environment.dart`.

## Community & Support
- **Discord:** [Join our Server](https://discord.gg/Nhy7xa3vC5)
- **Telegram:** [Join our Channel](https://t.me/kimistream)
- **Support the Developer:** [Buy Me A Coffee](https://buymeacoffee.com/reinhart.dev)

## Contributing
Contributions, issues, and feature requests are welcome! Feel free to check the [issues page](https://github.com/Reinhart-py/kimi/issues).

## License
Copyright (C) 2026 Reinhart. All rights reserved.
