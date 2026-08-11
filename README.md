# Mobile Programming Project

## How to Build the App on GitHub Actions (Manual)

To compile the app without running it on your PC:
1. Go to the **Actions** tab on your GitHub repository.
2. Select the **Build Flutter Android** workflow.
3. Click the **Run workflow** dropdown on the right.
4. Select the branch you want to compile (e.g. `development` or feature branch).
5. Click the green **Run workflow** button.

---

## How to Release a Milestone Build (Tags)

To build a final/milestone version, create and push a Git tag:

```bash
git tag v1.0.0
git push --tags
```
The pipeline will detect the tag and automatically compile your release APK.
