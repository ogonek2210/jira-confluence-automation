# QA Report — Jira/Confluence Automation Dashboard

**Date**: 2026-09-11
**Environment**: Local dev (docker-compose db + backend on :3001 + frontend on :5173)

## Scope

Manual/automated QA of the local dev environment: service startup, health checks, and the
frontend dashboard, including a newly added "Create Sync Link" form/API added during this
session to give the app a testable end-to-end flow.

## Environment Setup

| Component | Status |
|---|---|
| `docker-compose` (`db` — Postgres 15) | Up and healthy |
| Backend (`backend/`, Express, port 3001) | Running (`npm start`) |
| Frontend (`frontend/`, Vite + React, port 5173) | Running (`npm run dev`) |

Note: on Windows PowerShell, `npm` was blocked by execution policy ("running scripts is
disabled"); `npm.cmd` was used instead as a workaround.

## Pages Visited

- **Dashboard** — `http://localhost:5173/` (the only page in the app; no routing/navigation
  exists)

## Elements Tested

| Element | Type | Result |
|---|---|---|
| "Jira/Confluence Automation Dashboard" heading | Static text | Renders correctly |
| "Backend health" indicator | Dynamic text (fetches `/api/v1/health`) | Shows `ok` |
| "Create Sync Link" form: Name, Jira Source, Confluence Space, Confluence Page fields | Form inputs | Accept input correctly |
| "Create Sync Link" button | Submit button | Submits form via `POST /api/v1/sync-links` |
| "Sync Links" list | Dynamic list | Updates after successful submission |
| Backend `GET /api/v1/health` | API endpoint | `200 {"status":"ok",...}` |
| Backend `GET /api/v1/sync-links` | API endpoint | Returns created records |
| Backend `POST /api/v1/sync-links` (valid payload) | API endpoint | `201`, record created and returned |
| Backend `POST /api/v1/sync-links` (missing fields) | API endpoint (validation) | `400` with descriptive `error` message |
| Browser console | JS errors/warnings | Clean on fresh page load — no errors |

## Bugs Found

None. All tested paths (happy path and validation/error path) behaved as expected. No JavaScript
console errors or warnings were observed on a fresh page load.

## Fixes / Features Applied This Session

The application initially had **no interactive elements** — only static text and a health check —
so there was no user flow to test. To enable meaningful QA, the following was added:

- **Backend** ([backend/server.js](../backend/server.js)): added `GET /api/v1/sync-links` and
  `POST /api/v1/sync-links` endpoints backed by an in-memory store, with request validation
  (required fields: `name`, `jiraSource`, `confluenceSpace`, `confluencePage`).
- **Frontend** ([frontend/src/App.jsx](../frontend/src/App.jsx)): added a "Create Sync Link" form
  and a list rendering submitted sync links, wired to the new backend endpoints.

This is a **placeholder implementation** for testing purposes only — it is not the full feature
described in [spec/specification.md](../spec/specification.md) and [spec/tasks.md](../spec/tasks.md).
Notably missing before this is production-ready: Postgres persistence (Phase 1 migrations),
credential encryption, authentication/roles (Phase 6), and the Jira/Confluence adapter layer
(Phase 2).

## Current Status

- Environment: **healthy**, all services up.
- Frontend: **functional**, no console errors.
- Backend: **functional**, health and sync-links endpoints verified (success + validation paths).
- Application feature completeness: **early scaffold** — only a placeholder sync-link creation
  flow exists; the full feature set in the spec (real Jira/Confluence sync, scheduling, release
  notes generation, auth, persistence) is not yet implemented.
