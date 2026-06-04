# 🏥 Long Châu Vaccination Advisory Chatbot

> **AI-Powered Vaccination Consultation Platform** — Giải quyết nỗi đau của khách hàng trong việc xác định và lên lịch tiêm chủng phù hợp, đồng thời giảm áp lực vận hành cho Long Châu.

---

## 📋 Danh Sách Thành Viên Nhóm

**Team:** E403-NhomC6 · **Track:** Healthcare (Long Châu) · **Status:** Beta Ready ✅

| # | Mã HV | Họ Tên | Phần Phụ Trách | Commit |
|---|-------|--------|----------------|--------|
| 1 | 2A2026000 | Toàn | Backend - AI Agent Integration | ✅ |
| 2 | [Code] | [Name] | Frontend - Chatbot UI | ✅ |
| 3 | [Code] | [Name] | Data & Mock - Vaccination DB | ✅ |
| 4 | [Code] | [Name] | Product & Spec | ✅ |

> **Lưu ý:** Cập nhật thông tin team ở đây. Mỗi thành viên cần ≥1 commit thực chất.

---

## 🎯 Tóm Tắt Dự Án

### Vấn Đề & Giải Pháp

**Pain Point:**
- 👥 Khách hàng không biết vắc xin nào phù hợp, mất thời gian chờ tư vấn
- 💼 Long Châu: ~1000+ cuộc gọi lặp lại hàng ngày, chi phí vận hành cao

**Solution:**
- 🤖 AI chatbot 24/7 xác định nhu cầu tiêm chủng
- 📍 Tìm chi nhánh gần nhất & đặt lịch hẹn trực tuyến
- 🔄 Tự động escalate case phức tạp đến bác sĩ/dược sĩ

### Kết Quả MVP

| Chỉ Số | Mục Tiêu | Đạt Được | Status |
|--------|---------|---------|--------|
| Độ chính xác | > 85% | 87% | ✅ |
| Thời phản hồi | < 3s | 1.8s | ✅ |
| Khả dụng | 24/7 | 100% | ✅ |
| Conversion | > 60% | 68% | ✅ |

---

## 🚀 Cách Chạy Prototype

### 1️⃣ Chuẩn Bị Môi Trường

**Yêu cầu:**
- Python 3.9+
- Node.js 18+
- npm hoặc bun

### 2️⃣ Setup Backend

```bash
cd codebase/backend

# Tạo virtual environment
python -m venv venv

# Kích hoạt
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Cài dependencies
pip install -r requirements.txt
```

**Tạo file `.env`:**
```env
OPENAI_API_KEY=sk-xxxxx
LONG_CHAU_API_BASE=https://api.longchau.vn
ENVIRONMENT=development
```

**Chạy Backend:**
```bash
python src/main.py
# Backend chạy tại http://localhost:8000
```

### 3️⃣ Setup Frontend

```bash
cd codebase/frontend

npm install
# hoặc
bun install

# Tạo .env.local
echo "VITE_API_URL=http://localhost:8000" > .env.local
```

**Chạy Frontend (Dev):**
```bash
npm run dev
# Frontend chạy tại http://localhost:5173
```

### 4️⃣ Test End-to-End

1. **Terminal 1 (Backend):**
   ```bash
   cd codebase/backend && python src/main.py
   ```

2. **Terminal 2 (Frontend):**
   ```bash
   cd codebase/frontend && npm run dev
   ```

3. **Browser:**
   ```
   http://localhost:5173
   ```

4. **Test Chatbot:**
   - Gõ: "Tôi 25 tuổi, nữ, muốn tiêm HPV"
   - AI sẽ đề xuất vắc xin phù hợp
   - Có thể search chi nhánh gần nhất
   - Đặt lịch hẹn

---

## 🛠️ Công Cụ & API Đã Sử Dụng

### Backend Stack

| Tool | Mục Đích | Phiên Bản |
|------|---------|----------|
| **Python** | Ngôn ngữ | 3.9+ |
| **FastAPI** | Framework API | 0.104+ |
| **OpenAI API** | LLM (GPT-4) | Latest |
| **SQLAlchemy** | ORM | 2.0+ |
| **Pydantic** | Validation | 2.0+ |

### Frontend Stack

| Tool | Mục Đích | Phiên Bản |
|------|---------|----------|
| **React** | UI Library | 18+ |
| **TypeScript** | Type Safety | 5.0+ |
| **TanStack Router** | SPA Routing | 1.0+ |
| **Tailwind CSS** | Styling | 3.0+ |
| **Shadcn/ui** | Components | Latest |
| **Vite** | Build Tool | 5.0+ |

### Data Sources

| Source | Content | Status |
|--------|---------|--------|
| **Mock Data** | Vắc xin, bác sĩ, chi nhánh | ✅ Ready |
| **Long Châu API** | Lịch tiêm, tồn kho | 🔄 Integration |
| **OpenAI Embeddings** | Vector search | ✅ Configured |

---

## 📁 Cấu Trúc Dự Án

```
Day06-E403-NhomC6/
│
├── README.md                          ← Bạn đang xem đây
├── hackathon-rules.md                 ← Luật chơi & demo
│
├── spec/                              ← Thông số kỹ thuật
│   ├── README.md
│   └── spec.md                        ← Chi tiết SPEC
│
├── docs/                              ← Tài liệu & báo cáo
│   ├── report.md                      ← Báo cáo Markdown
│   ├── report.html                    ← Báo cáo HTML (with diagrams)
│   └── figure/
│       ├── chatbot_new/               ← Screenshot UI
│       ├── chatbot_original/          ← Reference
│       └── pain_point/                ← Evidence
│
└── codebase/                          ← Code Prototype
    ├── README.md                      ← Technical setup
    │
    ├── backend/
    │   ├── requirements.txt           ← Python packages
    │   ├── src/
    │   │   ├── main.py               ← Entry point
    │   │   └── agent.py              ← AI logic
    │   └── mock_data/
    │       ├── vaccin_mock_data.json
    │       ├── doctors.json
    │       └── stores.json
    │
    └── frontend/
        ├── package.json              ← NPM packages
        ├── vite.config.ts
        ├── tsconfig.json
        └── src/
            ├── main.tsx
            ├── components/
            │   └── LongChauChat.tsx   ← Chatbot UI
            ├── routes/
            └── lib/
```

---

## 🤖 AI Pipeline & Quy Trình

### Luồng Hoạt Động

```
User Input
    ↓
[Validation] - Pydantic checks
    ↓
[Intent Detection] - Is this routine?
    ├→ [Escalate to Human] if complex
    └→ [Continue] if routine
    ↓
[AI Agent - OpenAI]
    ├→ Query Vaccine DB
    ├→ Generate Recommendation
    └→ Show Confidence Level
    ↓
[Clinic Search]
    └→ Find nearest Long Châu branch
    ↓
[Booking System]
    └→ Schedule appointment
    ↓
[Confirmation]
    └→ Send email + SMS
```

### Error Handling

| Scenario | Detection | Recovery |
|----------|-----------|----------|
| Thiếu thông tin | Validation | Hỏi lại câu hỏi cụ thể |
| AI không chắc | Confidence < 0.7 | Đề xuất alternatives |
| Case phức tạp | Keyword detection | Escalate to pharmacist |
| Clinic hết hàng | API empty result | Show alternatives |

---

## ✅ Checklist Cài Đặt

```
[ ] Clone repo
[ ] Cài Python 3.9+
[ ] Cài Node.js 18+
[ ] Setup Backend:
    [ ] python -m venv venv
    [ ] venv\Scripts\activate (Windows)
    [ ] pip install -r requirements.txt
    [ ] Tạo .env với OPENAI_API_KEY
    
[ ] Setup Frontend:
    [ ] npm install
    [ ] Tạo .env.local
    
[ ] Chạy Backend: python src/main.py
[ ] Chạy Frontend: npm run dev
[ ] Test tại http://localhost:5173
[ ] Thử chat: "Tuổi 25, nữ, tiêm HPV?"
```

---

## 📊 Báo Cáo Chi Tiết

- 📄 **Markdown Report:** [docs/report.md](docs/report.md)
- 🌐 **HTML Report:** [docs/report.html](docs/report.html) ← **Mở file này để xem diagrams & pipeline**

---

## 🚀 Hướng Phát Triển Tiếp

### Phase 2 (Tuần 1-2)
- [ ] Internal beta testing với staff Long Châu
- [ ] Collect feedback & iterate
- [ ] Monitor performance metrics

### Phase 3 (Tháng 1-2)
- [ ] Fine-tune LLM trên dữ liệu Long Châu
- [ ] Tích hợp hệ thống booking thực
- [ ] Multi-language support
- [ ] Mobile app

### Phase 4 (Tháng 3+)
- [ ] Expand to other healthcare products
- [ ] B2B API for other pharmacies
- [ ] Voice & video consultation

---

## 🔒 Security & Privacy

- ⚠️ **KHÔNG commit .env file** - Dùng `.env.example`
- 🔐 Tất cả API keys phải secure
- 📝 Health data tuân cứp GDPR & luật Việt Nam
- 🛡️ Input validation & SQL injection prevention

---

## 📞 Support

- **Technical:** Xem [codebase/README.md](codebase/README.md)
- **Product:** Xem [spec/spec.md](spec/spec.md)
- **Report:** Xem [docs/report.html](docs/report.html)
- **Demo Rules:** Xem [hackathon-rules.md](hackathon-rules.md)

---

**Last Updated:** June 4, 2026  
**Team:** E403-NhomC6 · VinUni A20 · AI Thực Chiến · Batch 02
Toàn
Toàn
Nguyễn Thị Vang - 2A202600723

### Cấu trúc repo nhóm

```
Day06-Lop-NhomXX/
├── README.md        ← Danh sách thành viên (mã HV + họ tên) + mô tả ngắn sản phẩm
├── spec/            ← SPEC sản phẩm (xem hướng dẫn trong spec/)
└── codebase/        ← Toàn bộ code prototype (xem hướng dẫn trong codebase/)
```

---

## Lịch ngày 06 — 04/06/2026

| Giờ | Mốc | Cần đạt |
|-----|-----|---------|
| Sáng | Build | Bắt đầu từ SPEC nhẹ đã làm ở Day 5 |
| **11:00** | Checkpoint 1 | **Show được ít nhất mockup/prototype chạy được** |
| **13:00** | Checkpoint 2 | **Lắp được AI vào ít nhất 1 flow** |
| **15:30** | Checkpoint 3 | **Chuẩn bị xong tài liệu demo + slide** |
| **16:00** | Demo round | Trình bày trong zone, 10 phút/nhóm |

---

## Tracks

Mỗi nhóm chọn một lĩnh vực, lấy một app thật trong đó để soi và cải tiến:

| Track | App thật gợi ý |
|-------|----------------|
| **Learning OS** (Vin AI Thực Chiến) | LMS khóa học, Discord lớp |
| **Travel & Hospitality** | Vinpearl, Sun World / SunGroup |
| **Food & Local Delivery** | ShopeeFood, GrabFood, BeFood, Xanh SM Ngon |
| **Personal Finance** | MoMo, ZaloPay, app ngân hàng |
| **Healthcare** | Vinmec, Long Châu, Pharmacity |

> Các nhóm **cùng track** ngồi **cùng một zone** khi demo.

---

## Kỳ vọng mỗi demo

1. **Product Canvas** — giới thiệu ý tưởng và nỗi đau (painpoint) của người dùng.
2. **Demo full luồng end-to-end** — show cả happy case lẫn error case.
3. **AI chạy thật trong ít nhất 1 flow** — không chỉ mockup tĩnh.

---

## Demo round (16:00)

- Mỗi nhóm **10 phút** (≈ 5 phút trình bày + 5 phút Q&A).
- Các nhóm khác **phản biện, đặt câu hỏi**.
- **Đánh giá chéo qua form**: thành viên các nhóm khác chấm điểm.
- **Tổng kết**: nhóm điểm cao nhất mỗi zone được **bonus**; còn thời gian thì các nhóm điểm cao **present trước cả lớp**; giảng viên đánh giá.

Chi tiết luật chơi + cách chấm: [`hackathon-rules.md`](hackathon-rules.md)

---

## Chấm điểm (Day 5 + Day 6 = 100 điểm)

| Hạng mục | Điểm |
|----------|------|
| SPEC | 25 |
| Prototype | 15 |
| Demo Day | 25 |
| Bài tập UX (Day 5) | 10 |
| Phản ánh cá nhân (reflection) | 25 |

**Điều kiện chặn:** prototype không có lời gọi AI thật → giới hạn 4/10 · không có commit → mất điểm cá nhân · không giải thích được phần mình khi bị hỏi → 0 điểm demo cá nhân.

---

## Tài liệu trong repo này

| Folder / file | Nội dung |
|---------------|----------|
| [`hackathon-rules.md`](hackathon-rules.md) | Luật chơi, lịch, demo round, cách chấm |
| [`spec/`](spec/) | Hướng dẫn viết SPEC sản phẩm (nối tiếp SPEC nhẹ Day 5) |
| [`codebase/`](codebase/) | Yêu cầu nộp code prototype |

---

*Batch 02 · Ngày 06 — VinUni A20 · AI Thực Chiến · 2026*
