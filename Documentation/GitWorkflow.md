# 🧬 Git Workflow for DigitalBank iOS Team

This document describes the Git branching model, commit conventions, PR workflow, and merge rules used by the DigitalBank iOS team.

---

## 🌱 Branch Types

| Type       | Purpose                                  |
|------------|------------------------------------------|
| `main`     | Production-ready, deployed code only     |
| `develop`  | Development base, stable intermediate    |
| `feature/*`| New features in development              |
| `bugfix/*` | Minor bug fixes                          |
| `hotfix/*` | Critical fixes directly to production    |
| `release/*`| Preparation for production releases      |

### ✅ Example Branch Names

- `feature/auth-login-flow`
- `bugfix/fix-ip-localization`
- `hotfix/crash-on-launch`

---

## 📛 Commit Message Conventions

We follow [Conventional Commits](https://www.conventionalcommits.org/).

### Format

```
<type>(scope): message
```

### Types

- `feat` – New feature
- `fix` – Bug fix
- `refactor` – Code refactoring
- `docs` – Documentation only
- `test` – Test files only
- `chore` – Build system/config changes
- `ci` – CI/CD related changes

### Examples

```
feat(auth): add biometric login
fix(swapkey): correct retry policy on error
refactor(login): separate encryption logic
docs(readme): add setup instructions
```

---

## 🔀 Merge Request (MR) Process

1. Pull latest develop: `git checkout develop && git pull`
2. Create new branch: `git checkout -b feature/your-task`
3. Implement your changes
4. Commit with conventional commit format
5. Push: `git push origin feature/your-task`
6. Create Merge Request (MR) in GitLab
7. Use template `.gitlab/merge_request_templates/default.md`
8. Assign reviewer(s)
9. Merge only when all checks pass and MR is approved

---

## ✅ Review Checklist

- [ ] Tests added or updated
- [ ] Passes `swiftlint`
- [ ] No force unwrapping (`!`)
- [ ] No print/debug statements
- [ ] No leftover `TODO:` comments
- [ ] All public APIs are documented

---

## 🧪 Pre-Merge Checks

- ✅ Unit tests must pass (`xcodebuild test`)
- ✅ Linting (`swiftlint`)
- ✅ Dangerfile checks (if enabled)
- ✅ Code coverage >= 80%

---

## 📦 Merge Strategy

- **Always rebase** before merge
- **Squash commits** before merging to `develop` or `main`
- No merge commits allowed

```sh
git fetch origin
git rebase origin/develop
git push --force-with-lease
```

---

## 🏷 Release Tagging

Use semantic versioning (SemVer):

```
git tag -a v1.2.0 -m "Add 2FA login support"
git push origin v1.2.0
```

Format: `MAJOR.MINOR.PATCH`

---

## 🧠 Notes

- Keep branches small and focused
- Write self-explanatory commit messages
- Review others' code thoroughly
- Update `Documentation/NamingConvention.md` when naming rules evolve

---

Maintained by the iOS Team Lead
