import { createClient } from "https://esm.sh/@supabase/supabase-js@2";

export default async function handler(req: Request): Promise<Response> {
  // Only handle GET
  if (req.method !== "GET") {
    return new Response(JSON.stringify({ error: "Method not allowed. Use GET." }), {
      status: 405,
      headers: { "Content-Type": "application/json" }
    });
  }

  // Get config from environment
  const supabaseUrl = Deno.env.get("DB_URL") || Deno.env.get("SUPABASE_URL");
  const supabaseKey = Deno.env.get("DB_SERVICE_KEY") || Deno.env.get("SUPABASE_SERVICE_KEY");

  if (!supabaseUrl || !supabaseKey) {
    return new Response(JSON.stringify({ error: "Missing config. Set DB_URL and DB_SERVICE_KEY secrets." }), {
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }

  try {
    // Create Supabase client
    const supabase = createClient(supabaseUrl, supabaseKey);

    // Fetch messages
    const { data, error } = await supabase.from("messages").select("*");

    if (error) throw error;

    console.log(`Fetched ${data?.length || 0} messages`);

    return new Response(JSON.stringify({
      messages: data,
      count: data?.length || 0
    }), {
      headers: { "Content-Type": "application/json" }
    });

  } catch (e) {
    console.error(`Error: ${e}`);
    return new Response(JSON.stringify({
      error: "Failed to fetch messages",
      details: String(e)
    }), {
      status: 500,
      headers: { "Content-Type": "application/json" }
    });
  }
}
