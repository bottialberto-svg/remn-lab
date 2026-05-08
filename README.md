# remn-lab

This repository contains a Flutter Web application.

## Flutter Web App

The app is located in the `mobile_app` folder.

### Prerequisites

- GitHub Codespaces (or any Linux environment with Flutter SDK)
- No local installation needed - everything runs in the browser

### Running in GitHub Codespaces

1. **Open the project in Codespaces:**
   
   Navigate to your GitHub repository and click "Code" → "Codespaces" → "Create codespace"

2. **Verify Flutter is installed:**
   
   In the terminal, run:
   ```bash
   flutter --version
   ```

3. **Run the web app:**
   
   Navigate to the mobile_app directory:
   ```bash
   cd mobile_app
   ```
   
   Run the app as a web server:
   ```bash
   flutter run -d web
   ```
   
   Or use a specific web port:
   ```bash
   flutter run -d web --web-port 8080
   ```

### Preview in Browser (No Local Installation)

When running in GitHub Codespaces:

1. **Start the Flutter web server:**
   ```bash
   cd mobile_app
   flutter run -d web
   ```

2. **Open the preview:**
   
   The terminal will show a URL like `http://localhost:port`. Click on it to view your app in the browser.
   
   In Codespaces, you can also use the "Ports" tab in the terminal panel:
   - Click "Ports" 
   - Find the port that Flutter is running on
   - Right-click and select "Open in Browser"

3. **Hot reload:**
   
   The app supports hot reload. Make changes to your code and save to see updates instantly.

### Building for Production

To build the web app:
```bash
cd mobile_app
flutter build web
```

The built files will be in `mobile_app/build/web/`.

### Project Structure

```
mobile_app/
├── lib/
│   └── main.dart        # Main application code
├── web/
│   └── index.html      # HTML entry point
└── pubspec.yaml        # Dependencies
```

### Useful Links

- [Flutter Web Documentation](https://docs.flutter.dev/web)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)