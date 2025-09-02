# 📘 DigitalBank – Testing Guidelines

Bu hujjat **DigitalBank iOS** loyihasida test yozish qoidalarini belgilaydi. Maqsad – yagona standart, o‘qilishi oson va ishonchli testlar yozish.

> Dizayn prinsiplari: **SRP** (har test bitta xulq), **DIP** (UseCase faqat Repository interfeysiga tayanadi), **CQS** (test qilinayotgan API holatni o‘zgartirmasdan natija qaytaradi), **YAGNI/KISS** (keraksiz murakkablik yo‘q).

---

## 1) Use Case Tests
**Maqsad:** biznes-oqim, error propagation, mapping chaqirilishi.  
**Double:** `RepositorySpy`

**Yopilishi shart bo‘lgan holatlar**
- `init` hech narsa chaqirmaydi
- repository xatosi **o‘sha holida** uzatiladi
- success → repositorydan kelgan **Domain** qaytadi
- repo **1 marta**, to‘g‘ri param bilan chaqiriladi

---

## 2) Repository Tests
**Maqsad:** **Domain ⇄ DTO** mapping va `Client` integratsiyasi.  
**Double:** `ClientSpy (DTO bilan ishlaydi)`

**Holatlar**
- `request.toDTO()` to‘g‘ri chaqiriladi (clientga yuborilgan `DTO.Request` assert)
- client success → `dto.toDomain()` qaytariladi
- client xatosi → policy bo‘yicha uzatiladi

---

## 3) Client Tests
**Maqsad:** `Endpoint.makeRequest`, headers, method, body-encoding, status handling, error mapping.  
**Double:** `NetworkSessionSpy`

**Holatlar**
- Request qurilishi: URL, method, headers (`Content-Type`), body JSON
- Status:
  - 2xx → decode
  - 4xx/5xx → `NetworkError.non2xx`
  - transport → `NetworkError.transport`
  - decode → `NetworkError.decodingFailed`

---

## 4) Mapper Tests
**Maqsad:** maydonlar **1:1** mos tushishi.

**Holatlar**
- `SignInModels.Request.toDTO` → DTO teng
- `SignInDTO.Response.toDomain` → Domain teng

---

## 5) Endpoint Tests
**Maqsad:** path, method, headers, query.

---

## 6) Doubles (Spy/Stubs) Qoidalari
- **Spy**: call count + parameter capture (`receivedRequests`, `checkCallCount`)
- **Stub**: `result` orqali javobni boshqarish
- **Helperlar**: `makeSUT()`, `makeRequest()`, `makeResponse()` → `Tests/.../Helpers` ichida

---

## 7) Naming & Folder Structure
- `DigitalBankTests/Auth/SignIn/SignInUseCaseTests.swift`
- Doubles → `DigitalBankTests/Auth/SignIn/Doubles/`
- Helpers → `DigitalBankTests/Auth/SignIn/Helpers/`
- Mapper tests → `DigitalBankTests/Auth/SignIn/SignInMapperTests.swift` yoki UseCase ichida `// MARK: - Mapper`

---

## 8) MR Checklist (PR tekshiruv ro‘yxati)
- [ ] AAA (Arrange–Act–Assert) aniq ajratilgan
- [ ] Transport / Decode / Non2xx holatlari testlangan
- [ ] Endpoint method/path/headers tekshirilgan
- [ ] Mapperlarda barcha fieldlar qamrab olingan
- [ ] Doubles minimal va o‘qilishi oson
- [ ] No `print`, no `!`, no global state
- [ ] Test nomi: `test_<unitOfWork>_<expectedBehavior>`

---

**Maintainer:** iOS Team Lead – DigitalBank
