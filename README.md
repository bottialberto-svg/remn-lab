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
---

## Supabase Edge Functions

This project includes a Supabase Edge Function that provides a REST API for messages.

### Prerequisites

- A Supabase project (supabase.com)
- Supabase CLI installed (optional for local testing)

### Database Setup

Create the `messages` table in your Supabase dashboard:

```sql
CREATE TABLE messages (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    content TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insert sample data
INSERT INTO messages (content) VALUES ('Hello from Supabase!');
```

### Deploy the Edge Function

**Option 1: Via Dashboard (No CLI needed)**

The easiest way - no installation required:

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project → **Edge Functions**
3. Click **New Edge Function**
4. Name it `messages`
5. Change runtime to **Python**
6. Copy the code from `supabase/functions/messages/index.py`
7. Click **Deploy**

**Option 2: Via Supabase CLI**

(Requires Supabase CLI installed)

```bash
# Link to your Supabase project
supabase link --project-ref YOUR_PROJECT_REF

# Deploy the function
supabase functions deploy messages

# Set environment variables
supabase secrets set SUPABASE_URL=https://YOUR_PROJECT.supabase.co
supabase secrets set SUPABASE_SERVICE_KEY=YOUR_SERVICE_KEY
```

**Option 3: Via GitHub Actions**

Add to `.github/workflows/deploy-functions.yml`:

```yaml
name: Deploy Edge Functions
on:
  push:
    branches:
      - main
    paths:
      - supabase/functions/**

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: supabase/functions/deploy@v1
        with:
          project-ref: ${{ secrets.SUPABASE_PROJECT_REF }}
        env:
          SUPABASE_SERVICE_ROLE_KEY: ${{ secrets.SUPABASE_SERVICE_ROLE_KEY }}
```

### Test the Function

**Via Browser:**

```
https://YOUR_PROJECT.supabase.co/functions/v1/messages
```

**Via curl:**

```bash
curl -X GET "https://YOUR_PROJECT.supabase.co/functions/v1/messages" \
  -H "Authorization: Bearer YOUR_ANON_KEY" \
  -H "apikey: YOUR_ANON_KEY"
```

**Expected Response:**

```json
{
  "messages": [
    {"id": 1, "content": "Hello from Supabase!", "created_at": "2025-01-01T00:00:00Z"}
  ],
  "count": 1
}
```

### Configuration

The function uses environment variables (not hardcoded keys):

- `SUPABASE_URL` - Your Supabase project URL
- `SUPABASE_SERVICE_KEY` - The service role key for admin access

These are set via Supabase secrets to keep credentials secure.

### File Structure

```
supabase/
└── functions/
    └── messages/
        ├── index.py      # Edge Function code
        └── config.json  # Function configuration
```

### Useful Links

- [Supabase Edge Functions Docs](https://supabase.com/docs/guides/functions)
- [Supabase Python SDK](https://supabase.com/docs/reference/python/start)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)

## Flutter + Supabase Configuration

### Configure API Connection

1. **Get your Supabase credentials:**
   - Go to Supabase Dashboard → Project Settings → API
   - Copy the `Project URL` (anon key)

2. **Edit the Flutter app:**
   
   Open `mobile_app/lib/main.dart` and replace the placeholders:

   ```dart
   static const String _apiUrl = 'https://YOUR_PROJECT.supabase.co/functions/v1/messages';
   static const String _apiKey = 'YOUR_ANON_KEY';
   ```

3. **Set up the database:**

   In Supabase SQL Editor:
   ```sql
   CREATE TABLE messages (
     id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
     content TEXT NOT NULL,
     created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
   );

   INSERT INTO messages (content) VALUES ('Hello from Supabase!');
   ```

4. **Run the app:**

   ```bash
   cd mobile_app
   flutter pub get
   flutter run -d web-server --web-port 8080
   ```
