# Repository Guidelines

## Project Structure & Module Organization

This repository contains two independently run applications:

- `backend/`: Java 21 and Spring Boot REST API. Production code is under `src/main/java/ee/bcs/bank`, configuration under `src/main/resources`, and tests under `src/test/java`.
- `frontend/`: Vue 3 and Vite SPA. Application code is in `src/`, static assets in `src/assets/` and `public/`, routes in `src/router/`, and Pinia stores in `src/stores/`.
- `docs/`: database scripts, frontend notes, tutorials, and workshop materials.
- `scripts/`: repository automation helpers.

Read the root `CLAUDE.md` and the module-specific `backend/CLAUDE.md` or `frontend/CLAUDE.md` before changing a module.

## Build, Test, and Development Commands

Run commands from the relevant module directory.

```bash
cd backend
./gradlew build       # Compile and run backend tests
./gradlew test        # Run JUnit tests
./gradlew bootRun     # Start the API on port 8080

cd frontend
npm install           # Install dependencies
npm run dev           # Start Vite on port 8081
npm run build         # Create a production build
npm run lint          # Run oxlint and ESLint with fixes
npm run format        # Format src/ with Prettier
```

The backend expects local PostgreSQL database `vali_it`. Initialize it with scripts in `docs/database/` in numeric order.

## Coding Style & Naming Conventions

Java packages use lowercase names under `ee.bcs.bank`; classes use PascalCase and methods/variables use camelCase. Keep controllers DTO-focused, business logic in services, and persistence concerns in repositories/entities. Use descriptive DTO variable names such as `locationDetailDto`, not `dto`.

Frontend files use two-space indentation, LF line endings, single quotes, no semicolons, and a 100-character line limit. Name Vue components in PascalCase, for example `ImageInput.vue`.

## Testing Guidelines

Backend tests use JUnit Platform and belong in `backend/src/test/java`, named `*Tests.java`. Run `./gradlew test` before submitting backend changes. No frontend test runner is currently configured; always run `npm run lint` and `npm run build` for frontend changes.

## Commit & Pull Request Guidelines

Use short, imperative commit subjects with a conventional prefix, matching history: `feat: improve catch up teacher skill` or `docs: update workshop materials`. Keep unrelated changes in separate commits.

Pull requests should explain the change, list verification commands, and link the relevant issue or task. Include screenshots for visible frontend changes and call out database or configuration changes explicitly. Never commit production credentials or personal local settings.

## Current Work: Claude Code Workshop Checklist

The current task is to continue `docs/oppekava/check-list.md` for the Claude Code
workshop. Keep simple topics as short checklist bullets. For topics that need explanation,
add a concise Estonian cheat sheet under `docs/oppekava/materjalid/` and link it from the
checklist. Match the structure and level of detail of the existing materials. The workshop
is scheduled for 2026-08-12, so prioritize a usable presenter checklist over exhaustive
documentation.
