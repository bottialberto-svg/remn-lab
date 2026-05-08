from supabase import create_client, Client


def main(req: Request, res: Response) -> Response:
    """Supabase Edge Function - GET messages from database"""
    
    # Only handle GET requests
    if req.method != "GET":
        return res.json(
            {"error": "Method not allowed. Use GET."},
            status_code=405
        )
    
    # Get Supabase URL and key from environment (avoid SUPABASE_ prefix)
    supabase_url = req.headers.get("x-supabase-url")
    supabase_key = req.headers.get("x-supabase-api-key")
    
    # Fallback to environment variables if headers not set
    if not supabase_url:
        supabase_url = req.env.get("DB_URL")
    if not supabase_key:
        supabase_key = req.env.get("DB_SERVICE_KEY")
    
    if not supabase_url or not supabase_key:
        return res.json(
            {"error": "Missing configuration. Set DB_URL and DB_SERVICE_KEY secrets."},
            status_code=500
        )
    
    try:
        # Create Supabase client
        supabase: Client = create_client(supabase_url, supabase_key)
        
        # Fetch messages from database
        response = supabase.table("messages").select("*").execute()
        
        # Log success
        print(f"Fetched {len(response.data)} messages successfully")
        
        # Return the messages
        return res.json({
            "messages": response.data,
            "count": len(response.data)
        })
        
    except Exception as e:
        # Log the error
        print(f"Error fetching messages: {str(e)}")
        return res.json(
            {"error": "Failed to fetch messages", "details": str(e)},
            status_code=500
        )