# 🧬 Git Workflow for DigitalBank iOS Team

This document defines the Git branching model, commit conventions, MR workflow, and merge rules used by the **DigitalBank iOS** team.

---

## 🌱 Branch Types

Biz **Protected Branch** sifatida faqat `main`dan foydalanamiz — unga to‘g‘ridan-to‘g‘ri push qilish taqiqlangan, faqat MR orqali merge bo‘ladi.

| Type          | Purpose                                            |
|---------------|----------------------------------------------------|
| `main`        | Production-ready, deployed code only               |
| `feat/*`      | New feature in development                         |
| `fix/*`       | Bug fixes (non-critical)                           |
| `ref/*`       | Refactor/improvement without changing behavior     |
| `test/*`      | Test-only changes                                  |
| `docs/*`      | Documentation changes                              |
| `chore/*`     | Build/config/maintenance tasks                     |
| `release/*`   | Preparation for release (if needed)                |
| `hotfix/*`    | Critical fix directly to production                |

### ✅ Example Branch Names
- `feat/auth-swapkey-usecase`
- `fix/network-decoding-error`
- `ref/login-mapper-cleanup`
- `test/getuseripinfo-client-spy`
- `docs/gitworkflow-update`

---

## 📛 Commit Message Conventions

Biz **Conventional Commits** formatidan foydalanamiz.

### Format
```
<type>(scope): message
```

**Types**
- `feat` – New feature
- `fix` – Bug fix
- `refactor` – Code refactor
- `test` – Test only
- `docs` – Documentation
- `chore` – Build/config/maintenance
- `ci` – CI/CD changes

**Examples**
```
feat(auth): implement SwapKeyUseCase with tests
fix(network): correct error mapping for non2xx responses
refactor(ipinfo): extract DTO mapping to separate layer
test(auth): add sad path tests for SwapKeyUseCase
docs(readme): add setup instructions
```

---

## 🔀 Merge Request (MR) Process

1. **Update local main**:
   ```sh
   git checkout main
   git pull --ff-only
   ```
2. **Create branch**:
   ```sh
   git checkout -b feat/your-task
   ```
3. Implement changes (small, focused commits)
4. Commit using Conventional Commits
5. Push branch:
   ```sh
   git push -u origin feat/your-task
   ```
6. Open MR in GitLab:
   - **Source**: `feat/...`
   - **Target**: `main`
7. Fill MR template (`.gitlab/merge_request_templates/default.md`)
8. Assign reviewer(s)
9. Merge only when:
   - ✅ All checks pass (CI green)
   - ✅ All review threads resolved
   - ✅ At least one approval

---

## ✅ Review Checklist

- [ ] Unit tests added/updated (sad + happy path)
- [ ] Passes `swiftlint`
- [ ] No `print`/debug statements
- [ ] No force-unwrap (`!`) unless justified
- [ ] No leftover `TODO:` comments
- [ ] DIP, CQS, YAGNI, LoD respected
- [ ] DTO ↔ Domain mapping is in proper layer
- [ ] Public APIs documented

---

## 🧪 Pre-Merge Checks (CI)

- ✅ Unit tests pass (`xcodebuild test`)
- ✅ Lint (`swiftlint`)
- ✅ Dangerfile checks (if enabled)
- ✅ Code coverage ≥ 80% (target)

---

## 📦 Merge Strategy

- **Always rebase** before merge
- **Squash merge** into `main`
- Delete source branch after merge

Example rebase before push:
```sh
git fetch origin
git rebase origin/main
git push --force-with-lease
```

---

## 🏷 Release Tagging

Semantic Versioning (`MAJOR.MINOR.PATCH`):
```sh
git tag -a v1.3.0 -m "Add GetUserIPInfoUseCase and NetworkError mapping"
git push origin v1.3.0
```

---

## 🧠 Notes

- Branches small and focused → easier review
- Commit messages self-explanatory
- MR discussion should close all questions before merge
- Update `Documentation/NamingConvention.md` and `Documentation/Architecture.md` when conventions evolve
- Protected branch rules enforced in GitLab:
  - ✅ MR only
  - ✅ At least 1 approval
  - ✅ CI must pass
  - ✅ Squash required

---

Maintained by **iOS Team Lead – DigitalBank**

