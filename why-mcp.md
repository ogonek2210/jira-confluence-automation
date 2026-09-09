# Why Create and Connect an MCP Server

## What is MCP?
The Model Context Protocol (MCP) is a standard way for an AI assistant to call external tools —
local scripts, remote APIs, databases, etc. — through a common JSON-RPC interface, instead of the
assistant only being able to read/write text.

## Why create your own MCP server?
- **Expose custom capabilities**: Give the AI access to actions that don't exist as built-in tools
  (e.g. this project's `echo` and `get_time` tools in [mcp-echo.ps1](../mcp-echo.ps1) and
  [mcp-time.ps1](../mcp-time.ps1)).
- **Wrap internal/private systems**: Connect the AI to internal APIs, databases, or company tools
  that no public integration covers (Jira, Confluence, internal dashboards, etc.).
- **Control and auditability**: You decide exactly what the server does and what data it can
  access — unlike giving the AI raw shell/network access.
- **Reusability**: One server definition can be shared across any MCP-compatible client (VS Code,
  Cursor, etc.), not just a single chat session.

## Why connect to an existing MCP server (e.g. GitHub)?
- **Avoid reinventing integrations**: Official servers like GitHub's remote MCP endpoint already
  implement auth, pagination, and API coverage for repos/issues/PRs.
- **Live, authenticated actions**: The AI can act on your behalf (list repos, create files, open
  PRs) using your real credentials/session instead of guessing or requiring manual copy-paste.
- **Consistent protocol**: Local (stdio) and remote (HTTP) servers both plug into the same
  `mcp.json` configuration and tool-calling flow.

## How it fits together in this project
`.vscode/mcp.json` registers three servers:
- `echo-windows` — local PowerShell script, `echo` tool.
- `time-windows` — local PowerShell script, `get_time` tool.
- `github` — remote HTTP server, GitHub repo/issue/PR tools.

Once registered and started, each server's tools become directly callable by the AI in chat,
turning simple instructions into real actions (file edits, repo creation, git pushes, etc.).
