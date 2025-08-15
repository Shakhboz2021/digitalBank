# 🧾 DigitalBank Naming Convention Guide

Ushbu hujjat loyihadagi barcha elementlar uchun bir xil va professional nomlashni ta’minlash uchun ishlab chiqilgan.

---

## 📁 1. FOLDER & FILE NAMING

| Layer              | Folder Name Format        | Example                      |
|-------------------|---------------------------|------------------------------|
| Domain Layer       | `Domain`                  | `Auth/Login/Domain/`         |
| Application Layer  | `Application`             | `Auth/Login/Application/`    |
| Infrastructure     | `Infrastructure`          | `Auth/Login/Infrastructure/` |
| Interface Adapter  | `InterfaceAdapter`        | `Auth/Login/InterfaceAdapter/` |
| UI Layer           | `UI`                      | `Auth/Login/UI/`             |
| Test Layer         | `*Tests.swift` suffix     | `SwapKeyUseCaseTests.swift`  |

🔹 **Feature-based structure**:

```
DigitalBank/
├── Auth/
│   └── Login/
│       ├── Domain/
│       ├── Application/
│       ├── Infrastructure/
│       ├── InterfaceAdapter/
│       ├── UI/
│       └── Tests/
```

---

## 🧩 2. CLASS / STRUCT / PROTOCOL NAMING

| Type          | Convention              | Example                         |
|---------------|--------------------------|----------------------------------|
| Entity model  | `EntityNameModel`       | `UserProfileModel`              |
| Use case      | `*UseCase`              | `SwapKeyUseCase`                |
| Interface     | `*Protocol` (faqat zarur bo‘lsa) | `SwapKeyServiceProtocol`        |
| Impl class    | `*Impl`                 | `SwapKeyServiceImpl`            |
| ViewModel     | `*ViewModel`            | `LoginViewModel`                |
| Mapper        | `*Mapper`               | `SwapKeyMapper`                 |
| Coordinator   | `*Coordinator`          | `AuthCoordinator`               |
| NetworkClient | `*Client`               | `HTTPClient`, `AlamofireClient` |
| Test Double   | `*Spy` / `*Stub` / `*Mock` | `SwapKeyClientSpy`              |

---

## 🏷️ 3. VARIABLE NAMING

| Type              | Convention              | Example                         |
|------------------|--------------------------|----------------------------------|
| Constant         | `camelCase` + descriptive| `defaultTimeout`, `maxRetry`    |
| Property (private) | `_camelCase`           | `_currentUser`                  |
| Public property  | `camelCase`             | `isAuthorized`, `deviceID`      |
| Boolean          | Prefix with `is`, `has` | `isConnected`, `hasToken`       |
| Closure          | `on<Event>`             | `onLoginSuccess`, `onFailure`   |

---

## 🧪 4. TEST NAMING

| Element     | Convention                         | Example                                 |
|-------------|-------------------------------------|------------------------------------------|
| Test file   | `*Tests.swift`                     | `SwapKeyUseCaseTests.swift`              |
| Test func   | `test_<unitOfWork>_<expected>`     | `test_execute_returnsError_whenMissingKey` |

📌 Test structure:

```swift
func test_execute_returnsInvalidData_whenEncryptedKeyIsMissing() {
    // Given
    ...

    // When
    ...

    // Then
    ...
}
```

---

## 💬 5. COMMIT MESSAGE PREFIXES (Git)

| Prefix     | Purpose                           |
|------------|------------------------------------|
| feat:      | New feature                        |
| fix:       | Bug fix                            |
| test:      | Test added or updated              |
| refactor:  | Code restructuring (no behavior change) |
| chore:     | Docs, configs, etc.                |
| ci:        | CI/CD related changes              |

📌 Example:
```
feat(SwapKey): implement DH key generation
test(SwapKey): add missing encryptedData test
```

---

## 🌐 6. NETWORK LAYER

| Component     | Convention           | Example                        |
|---------------|----------------------|---------------------------------|
| Endpoint      | `*Endpoint.swift`    | `LoginEndpoint.swift`          |
| API Client    | `*Client`            | `SwapKeyClient`, `AlamofireClient` |
| Error Model   | `*Error`             | `NetworkError`, `SwapKeyError` |
| Request Model | `Models.Request`     | `SwapKeyModels.Request`        |
| Response Model| `Models.Response`    | `SwapKeyModels.Response`       |

---

## 📦 7. CoreData (Agar ishlatsangiz)

- Entity: `PascalCase` (`User`, `UserCache`)
- NSManagedObject subclass: `UserEntity`
- Mapper: `UserMapper`

---

## ♻️ Best Practices Summary

✅ Har doim `PascalCase` typelar uchun (class, struct, enum, protocol)  
✅ `camelCase` o‘zgaruvchilar va funksiyalar uchun  
✅ Qisqa va ma’nosiz nomlardan qochish  
✅ Test fayllari test qilinayotgan UseCase nomiga mos bo‘lishi  
✅ Git commitlar qisqa, aniq va prefiksli bo‘lishi  
✅ SRP, OCP, DIP kabi SOLID prinsiplariga amal qilish  
✅ DRY, KISS, YAGNI va CQS tamoyillariga rioya qilish  

---

DigitalBank loyihasi jiddiy bank ilovasi bo‘lgani uchun strukturani aniq va doimiy saqlash katta ahamiyatga ega. Bu konventsiyalar orqali barcha team memberlar bir xil formatda ishlaydi.

