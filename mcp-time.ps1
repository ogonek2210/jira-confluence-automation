#requires -Version 5.1
# Minimal MCP server over stdio (JSON-RPC 2.0, newline-delimited) exposing a single "get_time" tool.

$ErrorActionPreference = 'Stop'
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$stdout = [Console]::Out
$stdin = [Console]::In

function Send-Response {
    param($Id, $Result)
    $response = [ordered]@{ jsonrpc = '2.0'; id = $Id; result = $Result }
    $stdout.Write(($response | ConvertTo-Json -Depth 10 -Compress) + "`n")
    $stdout.Flush()
}

function Send-ErrorResponse {
    param($Id, $Code, $Message)
    $response = [ordered]@{ jsonrpc = '2.0'; id = $Id; error = [ordered]@{ code = $Code; message = $Message } }
    $stdout.Write(($response | ConvertTo-Json -Depth 10 -Compress) + "`n")
    $stdout.Flush()
}

while ($true) {
    $line = $stdin.ReadLine()
    if ($null -eq $line) { break }
    if ([string]::IsNullOrWhiteSpace($line)) { continue }

    try {
        $request = $line | ConvertFrom-Json -ErrorAction Stop
    } catch {
        continue
    }

    $method = $request.method
    $id = $request.id

    switch ($method) {
        'initialize' {
            Send-Response $id @{
                protocolVersion = '2024-11-05'
                capabilities    = @{ tools = @{} }
                serverInfo      = @{ name = 'time-windows'; version = '1.0.0' }
            }
        }
        'notifications/initialized' {
            # notification: no response expected
        }
        'tools/list' {
            Send-Response $id @{
                tools = @(
                    @{
                        name        = 'get_time'
                        description = 'Returns the current local date and time.'
                        inputSchema = @{
                            type       = 'object'
                            properties = @{}
                        }
                    }
                )
            }
        }
        'tools/call' {
            $toolName = $request.params.name
            $toolArgs = $request.params.arguments
            switch ($toolName) {
                'get_time' {
                    $now = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
                    Send-Response $id @{
                        content = @(
                            @{ type = 'text'; text = "Current time: $now" }
                        )
                    }
                }
                default {
                    Send-ErrorResponse $id -32601 "Unknown tool: $toolName"
                }
            }
        }
        default {
            if ($null -ne $id) {
                Send-ErrorResponse $id -32601 "Method not found: $method"
            }
        }
    }
}
