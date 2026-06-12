import os
import logging

# Configure logging first thing so all imported modules get configured logger
logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s"
)
logger = logging.getLogger("vaccine-assistant-backend")

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import StreamingResponse
from pydantic import BaseModel
from typing import List, Dict, Any, Optional, Generator
from dotenv import load_dotenv
import json

# Load env variables
load_dotenv()

# Import agent functionalities after configuring logging
from agent import (
    run_safety_guardrails,
    execute_mock_agent,
    OpenAIProvider,
    OpenAICompatibleProvider,
    GeminiProvider,
    VaccineAssistantAgent
)

app = FastAPI(title="AI Vaccine Assistant Backend", version="1.0.0")

# Enable CORS for frontend integration
# We set allow_origins=["*"] and allow_credentials=False to prevent any CORS preflight errors
# on production/deployment environments (where the frontend URL can be dynamic or mismatches are common).
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

# API Request/Response models
class ChatMessage(BaseModel):
    from_role: str = "user" # Matches client 'from' field ('user' or 'bot')
    text: str

    class Config:
        # Allow mapping from 'from' to 'from_role'
        fields = {'from_role': 'from'}
        populate_by_name = True

# Helper to deserialize frontend schema properly
class ChatRequest(BaseModel):
    messages: List[Dict[str, Any]] # Expecting list of {"from": "bot"|"user", "text": "..."}

class CallbackRequest(BaseModel):
    name: str
    phone: str
    details: Optional[str] = ""

@app.get("/api/health")
@app.get("/health")
async def health_check():
    api_key = (
        os.getenv("OPENAI_API_KEY") 
        or os.getenv("COMPATIBLE_API_KEY") 
        or os.getenv("OPENROUTER_API_KEY") 
        or os.getenv("GEMINI_API_KEY")
    )
    mode = "Mock Fallback Agent (Out of the box mode)"
    if os.getenv("OPENAI_API_KEY"):
        mode = "OpenAI API Agent"
    elif os.getenv("COMPATIBLE_API_KEY"):
        mode = "OpenAI Compatible Agent"
    elif os.getenv("OPENROUTER_API_KEY"):
        mode = "OpenRouter AI Agent"
    elif os.getenv("GEMINI_API_KEY"):
        mode = "Gemini API Agent"
    return {
        "status": "healthy",
        "has_api_key": bool(api_key),
        "mode": mode
    }

def stream_mock_agent(history: List[Dict[str, Any]]) -> Generator[Dict[str, Any], None, None]:
    result = execute_mock_agent(history)
    text = result.get("text", "")
    yield {"type": "text", "content": text}
    if result.get("tool_data"):
        yield {"type": "tool_data", "content": result["tool_data"]}

def chat_stream_generator(messages: List[Dict[str, Any]], api_key: Optional[str]):
    user_messages = [m for m in messages if m.get("from") == "user"]
    if not messages or not user_messages:
        payload = {
            "type": "text",
            "content": "Chào mừng Anh/Chị đến với Tiêm chủng Long Châu.  Long Châu có thể giúp gì cho mình ạ?"
        }
        yield json.dumps(payload, ensure_ascii=False) + "\n"
        return

    last_user_message = user_messages[-1].get("text", "")
    logger.info(f"Received message from user: {last_user_message}")

    # 1. Run Safety Guardrails Check on user message
    safety_result = run_safety_guardrails(last_user_message, api_key)
    
    if safety_result.get("is_dangerous"):
        logger.warning(f"Safety red flags triggered for query: {last_user_message}")
        payload = {
            "type": "safety_triggered",
            "content": True,
            "text": safety_result["warning_message"],
            "tool_data": {
                "safety_escalation": True,
                "type": safety_result["type"]
            }
        }
        yield json.dumps(payload, ensure_ascii=False) + "\n"
        return

    # 2. Run agent execution
    if api_key:
        logger.info("Executing AI Agent Stream Loop...")
        if os.getenv("OPENAI_API_KEY"):
            provider = OpenAIProvider(
                model_name=os.getenv("OPENAI_MODEL_NAME", "gpt-4o-mini"),
                api_key=os.getenv("OPENAI_API_KEY")
            )
        elif os.getenv("COMPATIBLE_API_KEY"):
            provider = OpenAICompatibleProvider(
                model_name=os.getenv("COMPATIBLE_MODEL_NAME", "mimo-v2.5-pro"),
                base_url=os.getenv("COMPATIBLE_BASE_URL", "http://localhost:8000/v1"),
                api_key=os.getenv("COMPATIBLE_API_KEY")
            )
        elif os.getenv("OPENROUTER_API_KEY"):
            provider = OpenAICompatibleProvider(
                model_name=os.getenv("OPENROUTER_MODEL_NAME", "google/gemini-2.5-flash"),
                base_url="https://openrouter.ai/api/v1",
                api_key=os.getenv("OPENROUTER_API_KEY")
            )
        else:
            provider = GeminiProvider(
                model_name="gemini-2.5-flash",
                api_key=api_key
            )
        
        agent = VaccineAssistantAgent(llm=provider)
        stream_gen = agent.run_stream(messages)
    else:
        logger.info("No API_KEY found. Executing Mock Fallback Agent Stream...")
        stream_gen = stream_mock_agent(messages)
        
    for chunk in stream_gen:
        yield json.dumps(chunk, ensure_ascii=False) + "\n"

@app.post("/api/chat")
@app.post("/chat")
def chat_endpoint(payload: ChatRequest):
    messages = payload.messages
    api_key = (
        os.getenv("OPENAI_API_KEY") 
        or os.getenv("COMPATIBLE_API_KEY") 
        or os.getenv("OPENROUTER_API_KEY") 
        or os.getenv("GEMINI_API_KEY")
    )
    return StreamingResponse(
        chat_stream_generator(messages, api_key),
        media_type="application/x-ndjson"
    )

@app.post("/api/callback")
@app.post("/callback")
async def register_callback(payload: CallbackRequest):
    logger.info(f"Registered pharmacist callback request: Name={payload.name}, Phone={payload.phone}, Details={payload.details}")
    return {
        "status": "success",
        "message": f"Dạ,  trực ca đã nhận được thông tin. Hotline hỗ trợ 1800 6928 sẽ liên hệ đến số {payload.phone} trong 15 phút tới để tư vấn trực tiếp cho Anh/Chị {payload.name}."
    }

if __name__ == "__main__":
    import uvicorn
    # Start server locally on port 8080
    uvicorn.run(app, host="0.0.0.0", port=8080)
