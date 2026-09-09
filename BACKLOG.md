# Backlog — Jira/Confluence Automation

## Phase 1: Core Setup
- [x] Initialize repository and project structure
- [ ] Implement Jira API client (authentication, base requests) (#1)
- [ ] Implement Confluence API client (authentication, base requests) (#2)
- [x] Add configuration file for API tokens/credentials (env-based, not committed) (#4, closed)
- [ ] Write basic CLI entry point for running automation scripts (#3)

## Phase 2: Automation Features
- [ ] Sync Jira issue status changes to a Confluence status page
- [ ] Auto-generate a Confluence release notes page from closed Jira issues
- [ ] Add scheduled sync job (cron/task scheduler support)

## Phase 3: Polish & Docs
- [ ] Add unit tests for Jira/Confluence clients
- [ ] Write usage documentation in README
- [ ] Add error handling and retry logic for API calls

## Candidates for GitHub Coding Agent (Module 19)
Well-scoped, self-contained tasks that could be delegated to an autonomous coding agent:
- #1 Implement Jira API client — clear scope, now has a subtask checklist
- #2 Implement Confluence API client — mirrors #1, same pattern
- #3 Write basic CLI entry point — small, well-defined surface area

Less suitable for delegation (needs human judgment on secrets/config handling): the closed
config-file task (#4) and anything touching credential storage.
