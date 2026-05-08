from supabase import create_client, Client
from pydantic import BaseModel


def main(req: Request, res: Response) -> Response:
    """Supabase Edge Function - GET messages from database"""
    
    # Get Supabase URL and key from environment
    supabase_url = req.headers.get("x-supabase-url")
    supabase_key = req.headers.get("x-supabase-api-key")
    
    # Fallback to environment variables if headers not set
    if not supabase_url:
        supabase_url = req.env.get("SUPABASE_URL")
    if not supabase_key:
        supabase_key = req.env.get("SUPABASE_SERVICE_KEY")
    
    if not supabase_url or not supabase_key:
        return res.json(
            {"error": "Missing Supabase configuration"},
            status_code=500
        )
    
    try:
        # Create Supabase client
        supabase: Client = create_client(supabase_url, supabase_key)
        
        # Fetch messages from database
        response = supabase.table("messages").select("*").execute()
        
        # Return the messages
        return res.json({
            "messages": response.data,
            "count": len(response.data)
        })
        
    except Exception as e:
        return res.json(
            {"error": str(e)},
            status_code=500
        )