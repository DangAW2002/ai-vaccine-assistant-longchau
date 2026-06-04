# Batch 02 · Day 06 — AI Product Hackathon

> SPEC → Prototype → Demo. Hôm nay không có bài giảng mới — hôm nay chứng minh: SPEC là giả thuyết, prototype là bằng chứng, demo là thuyết phục.

---

## 🏥 Sản phẩm: AI Vaccine Assistant — Long Châu

> **Track:** Healthcare | **App gốc:** Long Châu Pharmacy

**Mô tả ngắn:** Chatbot AI tư vấn vắc xin thông minh tích hợp vào hệ thống Long Châu — giúp khách hàng xác định đúng vắc xin cần tiêm, lịch tiêm phù hợp, và đặt lịch tự động 24/7; giảm tải tư vấn lặp lại cho nhân viên.

---

## 👥 Danh sách thành viên nhóm C6

| Thành viên | Phụ trách |
|-----------|-----------|
| 2A202600574 - Hoàng Kim Tuấn Anh | Backend API + OpenAI integration |
| 2A202600652 - Nguyễn Hưng Nguyên | Frontend chatbot UI |
| 2A202600602 - Nguyễn Nhựt Đăng | Prompt engineering + kiểm thử |
| 2A202600633 - Nguyễn Thanh Toàn | Demo script + dry run |
| 2A202600723 - Nguyễn Thị Vang | SPEC · Báo cáo · Bằng chứng pain point |

---

## 📁 Cấu trúc repo

```
Day06-E403-NhomC6/
├── README.md              ← Thông tin nhóm + mô tả sản phẩm
├── hackathon-rules.md     ← Luật chơi & cách chấm điểm
├── spec/
│   └── README.md          ← Hướng dẫn viết SPEC sản phẩm
├── codebase/
│   ├── backend/           ← API server (Node.js + OpenAI)
│   ├── frontend/          ← Giao diện chatbot
│   └── scripts/           ← Script hỗ trợ
└── docs/
    ├── report.md          ← Báo cáo chi tiết sản phẩm
    └── figure/            ← Hình ảnh minh họa & screenshots
        ├── pain point/    ← Ảnh pain point từ app Long Châu gốc
        └── chatbot_longchau_new/  ← Demo chatbot cải tiến
```

---

## 🎯 Bài toán & Giải pháp

### Pain Point
- Chatbot Long Châu hiện tại **không phản hồi** hoặc trả lời sai lịch tiêm
- **Một câu hỏi, hai câu trả lời khác nhau** — thiếu nhất quán
- Tư vấn độ tuổi tiêm chưa chính xác → gây nhầm lẫn cho phụ huynh
- Khách hàng **phải gọi điện** hoặc đến trực tiếp để được tư vấn

### Giải pháp AI
AI Vaccine Assistant tích hợp vào Long Châu, hỏi đúng câu, phân tích hồ sơ, và đề xuất lịch tiêm cá nhân hóa — hỗ trợ 24/7, không cần nhân viên trực.

---

## 🛠️ Công nghệ & API sử dụng

Dự án prototype được xây dựng trên một ngăn xếp công nghệ hiện đại, tối ưu cho việc xây dựng ứng dụng AI Agent và phản hồi nhanh chóng:

### 1. Backend (Python & FastAPI)
- **Framework API:** [FastAPI](https://fastapi.tiangolo.com/) + [Uvicorn](https://www.uvicorn.org/) cho hiệu năng cao, hỗ trợ phản hồi dạng dòng (Streaming Response) tối ưu.
- **AI Engine (LLMs) & SDK:**
  - **OpenAI GPT-4o-mini** (SDK `openai`): Sử dụng cho việc suy luận ngữ nghĩa chính, phân tích hồ sơ bệnh nhân và kích hoạt các Tool Calling.
  - **Google Gemini 2.5 Flash** (SDK `google-genai`): Tích hợp trực tiếp hoặc thông qua OpenRouter như một lựa chọn thay thế hiệu quả.
  - **Chế độ Mock Fallback Agent:** Tự động chạy ngoại tuyến nếu không có bất kỳ API key nào được thiết lập, giúp dễ dàng kiểm thử giao diện ngay lập tức.
- **Semantic Safety Guardrails:** Sử dụng LLM phân tích ngữ nghĩa sâu hoặc bộ lọc regex dự phòng tại chỗ nhằm phát hiện các dấu hiệu y khoa nguy hiểm (như sốt cao, dị ứng/phản vệ trước đó, mang thai đối với vắc-xin sống) để tự động kích hoạt quy trình chuyển sang dược sĩ/bác sĩ.
- **RAG & Search Tools:**
  - **Tìm kiếm ngữ nghĩa (RAG):** Sử dụng model `text-embedding-3-small` của OpenAI để mã hóa ngữ nghĩa dữ liệu vắc xin và các gói tiêm. Kết quả vector được lưu cache cục bộ (`vaccine_embeddings_cache.json`) giúp phản hồi dưới 100ms.
  - **Tool Calling & Database:** AI Agent tự động gọi các tool (`search_vaccine_tool`, `search_stores_tool`, `search_nearest_stores_by_coordinates_tool`, `book_appointment_tool`) để truy xuất dữ liệu từ các tệp JSON giả lập.
  - **Tính khoảng cách tọa độ:** Áp dụng công thức Haversine để tìm ra 5 trung tâm tiêm chủng FPT Long Châu gần nhất từ tọa độ GPS của khách hàng.

### 2. Frontend (React & Vite)
- **Framework & Build tool:** React 19 (TypeScript) + [Vite](https://vite.dev/) để khởi chạy và đóng gói nhanh chóng.
- **Styling & UI Components:** [Tailwind CSS v4](https://tailwindcss.com/) + [Shadcn UI](https://ui.shadcn.com/) (Radix UI) + [Lucide Icons](https://lucide.dev/) giúp thiết kế giao diện chatbot mượt mà, chuyên nghiệp, chuẩn phong cách FPT Long Châu.
- **Quản lý dữ liệu & Định tuyến:** [TanStack Router](https://tanstack.com/router) & [TanStack Query](https://tanstack.com/query) đảm bảo luồng truyền tin tức thời (NDJSON Streaming) và đồng bộ trạng thái hội thoại.

---

## 🚀 Hướng dẫn cài đặt & Chạy Prototype

Dự án hỗ trợ cả việc chạy tự động qua script viết sẵn hoặc khởi chạy thủ công.

### 1. Cấu hình biến môi trường (`.env`)
Tạo một file `.env` ở thư mục gốc của dự án hoặc thư mục `codebase/backend/` và cấu hình một trong các API key sau (khuyên dùng OpenAI):

```env
# Cấu hình API Key (Chọn 1 trong các dịch vụ sau, hệ thống sẽ tự động nhận diện)
OPENAI_API_KEY=your_openai_api_key_here
OPENAI_MODEL_NAME=gpt-4o-mini

# Hoặc sử dụng Gemini API trực tiếp
GEMINI_API_KEY=your_gemini_api_key_here

# Hoặc sử dụng OpenRouter
OPENROUTER_API_KEY=your_openrouter_api_key_here
OPENROUTER_MODEL_NAME=google/gemini-2.5-flash

# Hoặc API tương thích chuẩn OpenAI khác
COMPATIBLE_BASE_URL=http://localhost:8000/v1
COMPATIBLE_API_KEY=your_compatible_key
COMPATIBLE_MODEL_NAME=mimo-v2.5-pro
```
*Lưu ý: Nếu không cấu hình bất kỳ API Key nào, backend sẽ chạy ở chế độ **Mock Fallback** (giả lập ngoại tuyến) giúp bạn trải nghiệm các flow cơ bản mà không cần key.*

### 2. Các bước khởi chạy dự án

#### Cách 1: Chạy tự động bằng Script (Khuyên dùng)
Chúng tôi đã viết sẵn các script tự động thiết lập môi trường, cài đặt thư viện và chạy song song cả 2 dịch vụ.

- **Trên Linux / macOS:**
  ```bash
  chmod +x codebase/scripts/run.sh
  ./codebase/scripts/run.sh
  ```
- **Trên Windows:**
  Chạy trực tiếp file batch sau:
  ```cmd
  codebase\scripts\run.bat
  ```

#### Cách 2: Khởi chạy thủ công từng thành phần

1. **Khởi chạy Backend (FastAPI):**
   ```bash
   cd codebase/backend
   # Khuyên dùng: tạo virtual environment
   python3 -m venv .venv
   source .venv/bin/activate  # Trên Windows: .venv\Scripts\activate
   
   # Cài đặt các thư viện cần thiết
   pip install -r requirements.txt
   
   # Chạy server backend
   python src/main.py
   ```
   *Backend sẽ khởi chạy tại địa chỉ: `http://localhost:8080`*

2. **Khởi chạy Frontend (React + Vite):**
   ```bash
   cd codebase/frontend
   # Cài đặt thư viện
   npm install  # Hoặc dùng: bun install
   
   # Khởi chạy server development
   npm run dev  # Hoặc dùng: bun run dev
   ```
   *Frontend sẽ khởi chạy tại địa chỉ: `http://localhost:5173`*

---

*Batch 02 · Ngày 06 — VinUni A20 · AI Thực Chiến · 2026 · Nhóm C6 — Healthcare Track*
