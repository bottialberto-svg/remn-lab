# remn-lab

Flutter Web app connected to Supabase Edge Function backend.

## Quick Start

1. **Open in Codespaces** - GitHub → Code → Codespaces → Create codespace

2. **Run the app:**
   ```bash
   cd /workspaces/remn-lab/mobile_app
   flutter run -d web-server --web-port 8080
   ```

3. **Preview** - Click "Ports" tab → Forward port 8080 → Open in browser

## Configure Supabase

1. **Get credentials:**
   - Supabase Dashboard → Settings → API
   - Copy Project URL and anon public key

2. **Update API config** in `mobile_app/lib/main.dart`:
   ```dart
   static const String _apiUrl = 'https://YOUR_PROJECT.supabase.co/functions/v1/messages';
   static const String _apiKey = 'YOUR_ANON_KEY';
   ```

3. **Deploy Edge Function:**
   - Supabase Dashboard → Edge Functions → New
   - Name: `messages`
   - Copy code from `supabase/functions/messages/index.ts`

4. **Set secrets:**
   ```bash
   supabase secrets set DB_URL=https://YOUR_PROJECT.supabase.co
   supabase secrets set DB_SERVICE_KEY=YOUR_SERVICE_ROLE_KEY
   ```

## App Features

- Phone UI with camera/speaker design
- Next button cycles through messages
- Tap phone to toggle dark/light mode
