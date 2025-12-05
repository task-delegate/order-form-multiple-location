/**
 * Serverless proxy function for Vercel/Netlify
 * Forwards order data to Google Apps Script with CORS support
 * 
 * Environment Variables Required:
 *   - GAS_URL: Your Google Apps Script deployment URL (ends with /exec)
 *   - PROXY_API_KEY: (optional) Secret key for additional security
 */

module.exports = async (req, res) => {
  // === CORS Headers ===
  res.setHeader('Access-Control-Allow-Origin', '*'); // Allow all origins (change to specific domain in production)
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type, x-api-key, x-request-id');
  res.setHeader('Access-Control-Max-Age', '86400'); // 24 hours

  // === Handle OPTIONS preflight ===
  if (req.method === 'OPTIONS') {
    res.status(204).end();
    return;
  }

  // === Validate request method ===
  if (req.method !== 'POST') {
    res.status(405).json({ error: 'Method not allowed. Use POST.' });
    return;
  }

  // === Validate body ===
  if (!req.body || typeof req.body !== 'object') {
    res.status(400).json({ error: 'Invalid request body. Expected JSON object.' });
    return;
  }

  // === Optional: API Key validation ===
  const expectedKey = process.env.PROXY_API_KEY;
  if (expectedKey) {
    const providedKey = req.headers['x-api-key'];
    if (!providedKey || providedKey !== expectedKey) {
      res.status(401).json({ error: 'Unauthorized. Invalid or missing API key.' });
      return;
    }
  }

  // === Get Google Apps Script URL from environment ===
  const GAS_URL = process.env.GAS_URL;
  if (!GAS_URL) {
    console.error('❌ PROXY ERROR: GAS_URL environment variable not set');
    res.status(500).json({ 
      error: 'Server misconfigured. GAS_URL not set in environment variables.',
      hint: 'Contact administrator to configure deployment.'
    });
    return;
  }

  try {
    console.log(`📤 Proxy: Forwarding to GAS...`);
    console.log(`   GAS_URL: ${GAS_URL.substring(0, 50)}...`);
    console.log(`   Items: ${req.body.items?.length || 0}`);

    // === Forward to Google Apps Script (server-to-server, no CORS issues) ===
    const response = await fetch(GAS_URL, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(req.body),
      timeout: 30000 // 30 second timeout
    });

    const responseText = await response.text();
    let responseBody;

    // Try to parse as JSON, else return as raw text
    try {
      responseBody = JSON.parse(responseText);
    } catch (e) {
      responseBody = { raw: responseText };
    }

    console.log(`📥 Proxy: Received from GAS`);
    console.log(`   Status: ${response.status}`);
    console.log(`   OK: ${response.ok}`);

    // === Return response with CORS headers (already set above) ===
    res.status(response.ok ? 200 : response.status).json({
      success: response.ok,
      gasStatus: response.status,
      gasOk: response.ok,
      gasBody: responseBody,
      timestamp: new Date().toISOString(),
      proxyVersion: '1.0'
    });

  } catch (error) {
    console.error(`❌ PROXY ERROR: ${error.message}`);
    res.status(502).json({
      error: 'Proxy forwarding failed',
      detail: error.message,
      timestamp: new Date().toISOString()
    });
  }
};
