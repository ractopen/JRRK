# Mobile Programming Project

This repository contains the Flutter application for the Mobile Programming course.

## CI/CD: Automated Android Builds

We use GitHub Actions to automatically build and compile the Android app. 

### How it Works

1. **Development / Testing Builds (Automated)**
   * Every push to the `main` or `dev` branches triggers the workflow.
   * It compiles a release APK with the version name `1.0.0-dev.<run_number>`.
   * The output artifact is named **`app-dev-<run_number>`**.

2. **Milestone / Final Builds (Triggered by Git Tags)**
   * When you reach a project milestone, you can trigger a release build by pushing a version tag.
   * It compiles a release APK using your tag name as the version.
   * The output artifact is named **`app-v<version>`** (e.g., `app-v1.0.0`).

---

### How to Release a Milestone Build

To trigger a milestone build, run the following commands in your terminal:

```bash
# 1. Create a version tag (always start with 'v')
git tag v1.0.0

# 2. Push the tag to GitHub
git push --tags
```

Once pushed, go to the **Actions** tab on your GitHub repository to monitor the build progress and download the compiled APK artifact.
