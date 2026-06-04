# DANH SÁCH HÌNH ẢNH CẦN CHỤP DEMO (SCREENSHOT CHECKLIST)
## DỰ ÁN: TRỢ LÝ TIÊM CHỦNG LONG CHÂU AI

Để hoàn thiện slide thuyết trình một cách thuyết phục nhất trước ban giám khảo (đạt điểm tối đa tiêu chí "Demo Quality" và "AI Product Thinking"), bạn hãy khởi động ứng dụng và chụp lại các màn hình giao diện thực tế theo danh sách dưới đây:

---

### 1. Giao diện chào mừng ban đầu (Greeting Screen)
*   **Mục đích**: Minh họa cho **Slide 1 (Ảnh bìa)** và mở đầu phần giới thiệu sản phẩm.
*   **Cách chụp**: Chụp lại giao diện chatbot ngay khi vừa tải trang, hiển thị lời chào của bác sĩ trực ca và danh sách các câu hỏi gợi ý nhanh (Quick Replies) ở phía dưới.
*   **Trạng thái mong muốn**: Khung chat gọn gàng, nút bấm gợi ý hiển thị rõ nét.

### 2. Luồng thành công - Tìm kiếm Vắc-xin (Happy Path - Search Vaccine)
*   **Mục đích**: Minh họa cho **Slide 3 (Giải pháp)** và **Slide 4 (Lát cắt sản phẩm)**.
*   **Cách chụp**: Nhập câu hỏi: `"Tư vấn vắc-xin cúm cho con"` hoặc câu hỏi tương tự. Chụp lại đoạn chatbot trả lời kèm theo **các thẻ thông tin Vắc-xin (Vaccine Cards)** hiển thị chi tiết tên thuốc, giá, xuất xứ và phác đồ tiêm.

### 3. Luồng thành công - Định vị Trung tâm Tiêm chủng (Happy Path - GPS Store Locator)
*   **Mục đích**: Minh họa cho tính năng tự động hóa định vị địa điểm gần nhất.
*   **Cách chụp**: Bấm vào nút định vị vị trí (biểu tượng Map Pin ở ô nhập tin nhắn) để kích hoạt định vị GPS của trình duyệt, hoặc nhập `"Địa chỉ trung tâm Quận 7"`. Chụp lại danh sách **các trung tâm tiêm chủng gần nhất (Store Cards)** hiển thị kèm theo khoảng cách tính bằng km và nút bản đồ.

### 4. Đặt lịch tiêm thành công & Mô phỏng tin nhắn SMS (Happy Path - Booking & SMS Ticket)
*   **Mục đích**: Minh họa cho **Slide 4 (Happy Path kết thúc)** và **Slide 7 (Đường thuận)**.
*   **Cách chụp**: Hoàn tất các bước nhập tên, số điện thoại, chọn ngày tiêm hợp lý (ngày trong tương lai) và chọn trung tâm. Chụp lại **Phiếu hẹn tiêm chủng màu xanh lục (Booking Ticket)** hiển thị mã hẹn `LCB-XXXXXX` cùng với **Trình giả lập tin nhắn SMS xác nhận (SMS Simulator)** ở ngay phía dưới.

### 5. Giao diện Cảnh báo Y khoa - Sốt cao (Medical Safety Alert - High Fever)
*   **Mục đích**: Minh họa cho **Slide 7 (Error/Warning Path)** và **Slide 8 (Safety Guardrails)**.
*   **Cách chụp**: Nhập câu hỏi kích hoạt cảnh báo sốt cao: `"Bé nhà tôi đang sốt 39.2 độ thì có tiêm cúm được không?"`. Chụp lại **hộp cảnh báo y tế viền đỏ đậm** hiển thị lời khuyên hoãn tiêm từ hệ thống an toàn.

### 6. Form Dược sĩ gọi lại tư vấn trực tiếp (Pharmacist Callback Form)
*   **Mục đích**: Minh họa cho tính năng an toàn y khoa "Trust" trong AI Product Canvas (Slide 5).
*   **Cách chụp**: Khi cảnh báo đỏ xuất hiện (như ở mục 5), hệ thống sẽ hiển thị **Form đăng ký gọi lại**. Nhập thử thông tin Họ tên và Số điện thoại vào form rồi chụp lại giao diện này trước hoặc sau khi bấm nút đăng ký gọi lại.

### 7. Luồng xử lý lỗi nhập sai ngày hẹn (Past-Date Booking Validation Error)
*   **Mục đích**: Minh họa cho **Slide 7 (Correction Path)** để thấy AI phản ứng và hướng dẫn người dùng sửa lỗi.
*   **Cách chụp**: Yêu cầu đặt lịch hẹn tiêm vào một ngày trong quá khứ (ví dụ: ngày hôm qua hoặc ngày của tuần trước). Chụp lại **thông báo lỗi màu đỏ** hướng dẫn người dùng nhập đúng định dạng ngày `DD/MM/YYYY` và yêu cầu không đặt lịch trong quá khứ.

---

> [!TIP]
> **Hướng dẫn chèn ảnh vào slide**:
> Sau khi chụp xong các màn hình trên, bạn hãy lưu ảnh dưới định dạng `.png` hoặc `.jpg` và chèn trực tiếp vào các vị trí đã đánh dấu `Vị trí chèn ảnh Demo` trong file [slides.md](slides.md).
