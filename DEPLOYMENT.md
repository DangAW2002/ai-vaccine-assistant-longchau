# 🚀 Hướng dẫn Triển khai Hệ thống (Deployment Guide)

Tài liệu này hướng dẫn chi tiết các bước đưa **AI Vaccine Assistant (Long Châu)** lên môi trường Live Production bằng hai hình thức: **Render Blueprint** (Tự động hóa cả Frontend & Backend trên Render) hoặc kết hợp **Render (Backend) + Vercel (Frontend)**.

---

## 🖥️ 1. Triển khai cả Frontend và Backend lên Render (Dùng Blueprint)

Chúng ta sử dụng tính năng **Render Blueprints** (`render.yaml` ở gốc dự án) để khởi tạo tự động cả hai dịch vụ `vaccine-assistant-backend` và `vaccine-assistant-frontend`.

### Các bước thực hiện:
1. Đẩy toàn bộ mã nguồn lên **GitHub** (nhánh `main` của bạn).
2. Đăng nhập vào [Render.com](https://render.com).
3. Chọn **Blueprints** ở thanh menu -> Click chọn **New Blueprint Instance**.
4. Chọn repository chứa dự án này.
5. Render sẽ tự động đọc file `render.yaml` và hiển thị cấu hình cho cả hai dịch vụ:
   - **Backend**: `vaccine-assistant-backend` (Python)
   - **Frontend**: `vaccine-assistant-frontend` (Node)
6. Điền các biến môi trường cho dịch vụ backend:
   - `OPENAI_API_KEY`: API Key OpenAI của bạn.
   - `GEMINI_API_KEY`: API Key Gemini của bạn.
   - `COMPATIBLE_BASE_URL`: URL API tương thích (Ví dụ: `https://api.deepseek.com`).
   - `COMPATIBLE_API_KEY`: API Key tương thích (Ví dụ: Key DeepSeek của bạn).
   - `COMPATIBLE_MODEL_NAME`: Tên mô hình tương thích (Ví dụ: `deepseek-v4-flash`).
7. Bấm **Apply**. Render sẽ bắt đầu build cả 2 dịch vụ song song.
8. Sau khi backend deploy thành công, copy địa chỉ URL của backend (ví dụ: `https://vaccine-assistant-backend-xxxx.onrender.com`).
9. Vào phần cấu hình **Environment** của `vaccine-assistant-frontend` trên Render và cập nhật biến `VITE_API_URL` bằng URL của backend kèm hậu tố `/api` (ví dụ: `https://vaccine-assistant-backend-xxxx.onrender.com/api`).
10. Tương tự, cập nhật biến `ALLOWED_ORIGINS` của backend bằng địa chỉ URL của frontend (ví dụ: `https://vaccine-assistant-frontend-xxxx.onrender.com`).

---

## 🌐 2. Triển khai Frontend lên Vercel (Phương án thay thế)

Vercel hỗ trợ tối ưu các dự án sử dụng Vite và TanStack Router/Start.

### Các bước thực hiện:
1. Đăng nhập vào [Vercel.com](https://vercel.com).
2. Click **Add New** -> **Project** -> Chọn Repository từ GitHub.
3. Trong phần cấu hình dự án:
   - **Root Directory**: Chọn `codebase/frontend`.
   - **Framework Preset**: Chọn **Vite** (hoặc Vercel tự động nhận diện).
4. Mở phần **Environment Variables** và cấu hình biến môi trường sau:
   - **Key**: `VITE_API_URL`
   - **Value**: Địa chỉ URL của Backend ở Render kèm hậu tố `/api` (Ví dụ: `https://vaccine-assistant-backend-xxxx.onrender.com/api`).
5. Bấm **Deploy**. Vercel sẽ tự động cài đặt dependencies, biên dịch mã nguồn và cấp cho bạn một tên miền Live miễn phí (ví dụ: `https://your-project.vercel.app`).

---

## 🔒 3. Cấu hình bảo mật CORS sau khi có tên miền Frontend

Sau khi frontend đã deploy và có tên miền Vercel chính thức (ví dụ: `https://long-chau-chatbot.vercel.app`):

1. Đăng nhập lại vào **Render.com**.
2. Chọn dịch vụ Web Service `vaccine-assistant-backend`.
3. Vào mục **Environment** -> Tìm biến `ALLOWED_ORIGINS`.
4. Thêm địa chỉ tên miền Vercel của bạn vào cuối danh sách (phân tách bằng dấu phẩy `,` không chứa khoảng trắng).
   - Ví dụ: `http://localhost:5173,http://127.0.0.1:5173,https://long-chau-chatbot.vercel.app`
5. Lưu cấu hình. Render sẽ tự động khởi động lại dịch vụ để áp dụng CORS mới.

---

## 🧪 4. Kiểm tra hoạt động (Smoke Test)

Sau khi hoàn tất, bạn có thể kiểm tra hoạt động trực tiếp qua `curl`:

```bash
# Kiểm tra tình trạng kết nối API của Backend
curl https://vaccine-assistant-backend-xxxx.onrender.com/api/health
```
Kết quả mong muốn:
```json
{
  "status": "healthy",
  "has_api_key": true,
  "mode": "OpenAI API Agent" (hoặc Gemini API Agent)
}
```

---

## 🐳 5. Triển khai bằng Docker Compose (Môi trường Tự chủ)

Dự án đã được tích hợp đầy đủ cấu hình Docker. Bạn có thể tự chạy toàn bộ hệ thống (cả Frontend và Backend) bằng Docker Compose.

### Các bước thực hiện:
1. Đảm bảo máy tính/VPS đã cài đặt **Docker** và **Docker Compose**.
2. Thiết lập các biến môi trường trong file `.env` ở thư mục gốc:
   ```env
   OPENAI_API_KEY=your_openai_api_key_here
   GEMINI_API_KEY=your_gemini_api_key_here
   COMPATIBLE_BASE_URL=https://api.deepseek.com
   COMPATIBLE_API_KEY=your_deepseek_api_key_here
   COMPATIBLE_MODEL_NAME=deepseek-v4-flash
   ```
3. Chạy lệnh để build và khởi chạy các container dưới dạng background:
   ```bash
   docker compose up -d --build
   ```
4. Kiểm tra trạng thái các container:
   ```bash
   docker compose ps
   ```
   * **Frontend** sẽ chạy tại: `http://localhost:3000`
   * **Backend** sẽ chạy tại: `http://localhost:8080`

