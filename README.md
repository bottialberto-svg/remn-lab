# remn-lab

This repository contains a Flutter Web application.

## Flutter Web App

The app is located in the `mobile_app` folder.

### Prerequisites

- GitHub Codespaces (automatic Flutter installation via devcontainer)
- No local installation needed - everything runs in the browser

> **Note:** Flutter SDK is automatically installed when the Codespace starts, thanks to the `.devcontainer` configuration. The first run may take a minute while Flutter downloads.

### Running in GitHub Codespaces

1. **Open the project in Codespaces:**
   
   Navigate to your GitHub repository and click "Code" → "Codespaces" → "Create codespace"

2. **Verify Flutter is installed:**
   
   In the terminal, run:
   ```bash
   flutter --version
   ```

3. **Run the web app:**
   
   Navigate to the `mobile_app` directory (required!):
   ```bash
   cd /workspaces/remn-lab/mobile_app
   ```
   
   Run the app as a web server:
   ```bash
   flutter run -d web --web-port 8080
   ```
   
   If `flutter run -d web` fails with "Target file lib/main.dart not found", check the workspace path:

```bash
pwd                    # Shows current directory
ls -la               # Lists files in current directory
ls mobile_app/lib/    # Checks if mobile_app folder has lib/
```

The correct path may be one of:
- `/workspace/project/remn-lab/mobile_app` (absolute path)
- `../mobile_app` (relative from current folder)

If you can't use the web device or Linux desktop, you can still build the web app and serve it manually:

### Correct Device: Use `chrome` instead of `web`

Flutter shows "Chrome (web)" as a device. However, in Codespaces you may need to run as root:

```bash
export CHROME_FLAGS="--no-sandbox --headless --disable-gpu --disable-software-rasterizer"
flutter run -d chrome --web-port 8080
```

Or use web-server for a simpler approach:

```bash
flutter run -d web-server --web-port 8080
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

### DevContainer Configuration

This project includes a `.devcontainer/devcontainer.json` file that automatically:

- Installs Flutter SDK when the Codespace starts
- Makes `flutter` command available globally
- Configures port 5000 for the web preview

The Flutter SDK is downloaded from Google's official release archive and installed to `/opt/flutter`.

When the Codespace starts, you'll see a message like "Setting up Flutter..." - this is normal and may take 1-2 minutes on first run.

### Useful Links

- [Flutter Web Documentation](https://docs.flutter.dev/web)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)