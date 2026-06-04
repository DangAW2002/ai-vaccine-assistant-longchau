# 🚀 Hướng dẫn Chạy Prototype & Thông tin Codebase

Chào mừng bạn đến với thư mục mã nguồn của **AI Vaccine Assistant (Long Châu)** do **Nhóm C6** phát triển. 

*Tài liệu chính thức toàn dự án nằm tại file [README.md](../README.md) ở thư mục gốc.*

---

## 🛠️ Công nghệ & API sử dụng

Dự án sử dụng kiến trúc phân tách Client-Server với các công nghệ chính:

### Backend (Python & FastAPI)
- **Framework API:** [FastAPI](https://fastapi.tiangolo.com/) + [Uvicorn](https://www.uvicorn.org/) hỗ trợ Streaming NDJSON phản hồi real-time.
- **LLM Engine:** 
  - Mặc định sử dụng **OpenAI GPT-4o-mini** (SDK `openai`).
  - Hỗ trợ linh hoạt **Google Gemini 2.5 Flash** (qua SDK `google-genai` hoặc OpenRouter) và các mô hình tương thích OpenAI khác.
  - Tự động kích hoạt **Mock Fallback Agent** (giả lập ngoại tuyến) khi không có API key.
- **Tính năng thông minh:**
  - **RAG Semantic Search:** Dùng model `text-embedding-3-small` mã hóa ngữ nghĩa thông tin vaccine & gói tiêm, lưu cache tại local (`vaccine_embeddings_cache.json`) tăng tốc độ tìm kiếm.
  - **Tool Calling:** Tự động điều hướng gọi các hàm Python để truy vấn dữ liệu stores (trung tâm tiêm chủng), doctors (bác sĩ tư vấn), và đặt lịch tiêm.
  - **Safety Guardrails:** LLM kiểm tra an toàn y tế đầu vào (phát hiện sốt cao, có thai khi tiêm vaccine sống, tiền sử sốc phản vệ...) để chuyển hướng cuộc gọi sang Dược sĩ.
  - **Định vị GPS:** Dùng công thức toán học Haversine tính toán khoảng cách thực để tìm 5 trung tâm Long Châu gần vị trí người dùng nhất.

### Frontend (React & Vite)
- **Framework:** React 19 (TypeScript) + [Vite](https://vite.dev/) đóng gói siêu tốc.
- **UI & Styling:** [Tailwind CSS v4](https://tailwindcss.com/) + [Shadcn UI](https://ui.shadcn.com/) + [Lucide Icons](https://lucide.dev/).
- **Data & Routing:** [TanStack Router](https://tanstack.com/router) & [TanStack Query](https://tanstack.com/query) đảm bảo truyền tin tức thời dạng NDJSON Stream.

---

## 👥 Phân công công việc (Nhóm C6)

| Thành viên | Vai trò & Phụ trách chính |
|-----------|---------------------------|
| **Hoàng Kim Tuấn Anh** | Backend API, OpenAI integration, RAG, Tool Calling |
| **Nguyễn Hưng Nguyên** | Thiết kế Frontend Chatbot UI, bản đồ, đặt lịch |
| **Nguyễn Nhựt Đăng** | Prompt Engineering, cấu trúc kịch bản, kiểm thử AI |
| **Nguyễn Thanh Toàn** | Kịch bản demo, chuẩn bị slide, dry-run kiểm thử |
| **Nguyễn Thị Vang** | Viết tài liệu SPEC, viết Báo cáo dự án, thu thập bằng chứng pain point |

---

## 🚀 Hướng dẫn cài đặt & Khởi chạy

### 1. Cấu hình biến môi trường (`.env`)
Tạo một file `.env` tại thư mục gốc của dự án hoặc thư mục `codebase/backend/` với nội dung cấu hình sau:

```env
# Nhập API Key của bạn (Chọn 1 trong các dịch vụ dưới đây)
OPENAI_API_KEY=your_openai_api_key_here
OPENAI_MODEL_NAME=gpt-4o-mini

# Hoặc sử dụng Gemini API trực tiếp
GEMINI_API_KEY=your_gemini_api_key_here

# Hoặc sử dụng OpenRouter
OPENROUTER_API_KEY=your_openrouter_api_key_here
OPENROUTER_MODEL_NAME=google/gemini-2.5-flash
```
*Lưu ý: Nếu không có API Key, backend sẽ tự động chạy chế độ Mock giả lập ngoại tuyến.*

### 2. Các bước khởi chạy

#### Cách 1: Sử dụng Script tự động (Khuyên dùng)
Dự án đã chuẩn bị sẵn các script khởi tạo môi trường, cài đặt dependencies và chạy song song 2 dịch vụ:

- **Linux / macOS:**
  ```bash
  chmod +x scripts/run.sh
  ./scripts/run.sh
  ```
- **Windows:**
  Chạy trực tiếp file:
  ```cmd
  scripts\run.bat
  ```

#### Cách 2: Khởi chạy thủ công từng phần

1. **Khởi chạy Backend (FastAPI):**
   ```bash
   cd backend
   python3 -m venv .venv
   source .venv/bin/activate  # Windows: .venv\Scripts\activate
   pip install -r requirements.txt
   python src/main.py
   ```
   *Backend chạy tại: `http://localhost:8080`*

2. **Khởi chạy Frontend (React + Vite):**
   ```bash
   cd frontend
   npm install  # Hoặc: bun install
   npm run dev  # Hoặc: bun run dev
   ```
   *Frontend chạy tại: `http://localhost:5173`*

