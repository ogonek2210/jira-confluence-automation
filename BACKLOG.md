# Backlog — Jira/Confluence Automation

## Phase 1: Core Setup
- [x] Initialize repository and project structure
- [ ] Implement Jira API client (authentication, base requests) (#1)
- [ ] Implement Confluence API client (authentication, base requests) (#2)
- [ ] Add configuration file for API tokens/credentials (env-based, not committed) (#4)
- [ ] Write basic CLI entry point for running automation scripts (#3)

## Phase 2: Automation Features
- [ ] Sync Jira issue status changes to a Confluence status page
- [ ] Auto-generate a Confluence release notes page from closed Jira issues
- [ ] Add scheduled sync job (cron/task scheduler support)

## Phase 3: Polish & Docs
- [ ] Add unit tests for Jira/Confluence clients
- [ ] Write usage documentation in README
- [ ] Add error handling and retry logic for API calls
