package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
	"time"
)

// TestResult represents the test results structure
type TestResult struct {
	Passed        int            `json:"passed"`
	Failed        int            `json:"failed"`
	Total         int            `json:"total"`
	Status        string         `json:"status"`
	PassedScripts []string       `json:"passed_scripts"`
	Failures      []FailureInfo  `json:"failures"`
}

// FailureInfo represents a single test failure
type FailureInfo struct {
	Script   string `json:"script"`
	Database string `json:"database"`
	Error    string `json:"error"`
}

// generateMarkdownReport generates a markdown report from test results
func generateMarkdownReport(results *TestResult) string {
	statusEmoji := "✅"
	if results.Status != "success" {
		statusEmoji = "❌"
	}

	report := fmt.Sprintf(`# SQL Script Validation Test Report

**Generated**: %s
**Status**: %s %s

## Summary

| Metric | Count |
|--------|-------|
| Total Tests | %d |
| ✅ Passed | %d |
| ❌ Failed | %d |
| Success Rate | %.1f%% |

`,
		time.Now().Format(time.RFC3339),
		statusEmoji,
		strings.ToUpper(results.Status),
		results.Total,
		results.Passed,
		results.Failed,
		func() float64 {
			if results.Total == 0 {
				return 0
			}
			return float64(results.Passed) / float64(results.Total) * 100
		}())

	if results.Failed > 0 {
		report += "## ❌ Failed Scripts\n\n"
		for _, failure := range results.Failures {
			report += fmt.Sprintf("### %s\n\n**Database**: %s  \n**Error**: `%s`\n\n",
				failure.Script, failure.Database, failure.Error)
		}
	}

	if results.Passed > 0 {
		report += fmt.Sprintf("## ✅ Passed Scripts (%d)\n\n", results.Passed)
		for _, script := range results.PassedScripts {
			report += fmt.Sprintf("- %s\n", script)
		}
	}

	return report
}

// generateHTMLReport generates an HTML report from test results
func generateHTMLReport(results *TestResult) string {
	statusClass := "success"
	if results.Status != "success" {
		statusClass = "failure"
	}

	statusEmoji := "✅"
	if results.Status != "success" {
		statusEmoji = "❌"
	}

	successRate := 0.0
	if results.Total > 0 {
		successRate = float64(results.Passed) / float64(results.Total) * 100
	}

	failedRows := ""
	if results.Failed > 0 {
		for _, failure := range results.Failures {
			failedRows += fmt.Sprintf(`
            <tr class="failure-row">
                <td>%s</td>
                <td>%s</td>
                <td><code>%s</code></td>
            </tr>
            `, failure.Script, failure.Database, failure.Error)
		}
	}

	passedList := ""
	if results.Passed > 0 {
		for _, script := range results.PassedScripts {
			passedList += fmt.Sprintf("<li>%s</li>\n", script)
		}
	}

	failedSection := ""
	if results.Failed > 0 {
		failedSection = fmt.Sprintf(`
        <section>
            <h2>❌ Failed Scripts (%d)</h2>
            <table>
                <thead>
                    <tr>
                        <th>Script</th>
                        <th>Database</th>
                        <th>Error</th>
                    </tr>
                </thead>
                <tbody>
                    %s
                </tbody>
            </table>
        </section>
        `, results.Failed, failedRows)
	}

	passedSection := ""
	if results.Passed > 0 {
		passedSection = fmt.Sprintf(`
        <section>
            <h2>✅ Passed Scripts (%d)</h2>
            <ul>
                %s
            </ul>
        </section>
        `, results.Passed, passedList)
	}

	html := fmt.Sprintf(`<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SQL Validation Test Report</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            background: #f6f8fa;
            color: #24292e;
            line-height: 1.6;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            padding: 20px;
        }

        header {
            background: white;
            border: 1px solid #e1e4e8;
            border-radius: 6px;
            padding: 24px;
            margin-bottom: 24px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }

        h1 {
            font-size: 28px;
            margin-bottom: 8px;
        }

        .status {
            display: inline-block;
            padding: 4px 8px;
            border-radius: 4px;
            font-weight: 600;
            font-size: 14px;
        }

        .status.success {
            background: #28a745;
            color: white;
        }

        .status.failure {
            background: #dc3545;
            color: white;
        }

        .timestamp {
            color: #586069;
            font-size: 14px;
            margin-top: 8px;
        }

        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }

        .metric {
            background: white;
            border: 1px solid #e1e4e8;
            border-radius: 6px;
            padding: 16px;
            text-align: center;
        }

        .metric-value {
            font-size: 28px;
            font-weight: 600;
            color: #24292e;
        }

        .metric-label {
            font-size: 12px;
            color: #586069;
            text-transform: uppercase;
            margin-top: 8px;
        }

        .metric.passed .metric-value {
            color: #28a745;
        }

        .metric.failed .metric-value {
            color: #dc3545;
        }

        section {
            background: white;
            border: 1px solid #e1e4e8;
            border-radius: 6px;
            padding: 24px;
            margin-bottom: 24px;
        }

        h2 {
            font-size: 20px;
            margin-bottom: 16px;
            padding-bottom: 12px;
            border-bottom: 2px solid #e1e4e8;
        }

        table {
            width: 100%%;
            border-collapse: collapse;
            margin-bottom: 16px;
        }

        th {
            background: #f6f8fa;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            border-bottom: 2px solid #e1e4e8;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #e1e4e8;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .failure-row {
            background: #fff5f5;
        }

        .failure-row:hover {
            background: #ffe6e6;
        }

        code {
            background: #f6f8fa;
            border: 1px solid #e1e4e8;
            border-radius: 3px;
            padding: 2px 6px;
            font-family: 'Monaco', 'Menlo', 'Ubuntu Mono', monospace;
            font-size: 12px;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        ul li {
            padding: 8px 0;
            padding-left: 24px;
            position: relative;
        }

        ul li:before {
            content: "✅";
            position: absolute;
            left: 0;
        }

        .no-content {
            color: #586069;
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>SQL Validation Test Report</h1>
            <div class="status %s">%s %s</div>
            <div class="timestamp">Generated: %s</div>
        </header>

        <div class="summary">
            <div class="metric">
                <div class="metric-value">%d</div>
                <div class="metric-label">Total Tests</div>
            </div>
            <div class="metric passed">
                <div class="metric-value">%d</div>
                <div class="metric-label">Passed</div>
            </div>
            <div class="metric failed">
                <div class="metric-value">%d</div>
                <div class="metric-label">Failed</div>
            </div>
            <div class="metric">
                <div class="metric-value">%.1f%%</div>
                <div class="metric-label">Success Rate</div>
            </div>
        </div>

        %s
        %s
    </div>
</body>
</html>
`,
		statusClass, statusEmoji, strings.ToUpper(results.Status),
		time.Now().Format(time.RFC3339),
		results.Total, results.Passed, results.Failed, successRate,
		failedSection, passedSection)

	return html
}

func main() {
	// Check if test_results.json exists
	if _, err := os.Stat("test_results.json"); os.IsNotExist(err) {
		fmt.Println("❌ test_results.json not found")
		os.Exit(1)
	}

	// Read test results
	data, err := ioutil.ReadFile("test_results.json")
	if err != nil {
		fmt.Printf("Error reading test_results.json: %v\n", err)
		os.Exit(1)
	}

	var results TestResult
	if err := json.Unmarshal(data, &results); err != nil {
		fmt.Printf("Error parsing test_results.json: %v\n", err)
		os.Exit(1)
	}

	// Generate reports
	markdownReport := generateMarkdownReport(&results)
	htmlReport := generateHTMLReport(&results)

	// Save reports
	if err := ioutil.WriteFile("test_report.md", []byte(markdownReport), 0644); err != nil {
		fmt.Printf("Error writing test_report.md: %v\n", err)
		os.Exit(1)
	}

	if err := ioutil.WriteFile("test_report.html", []byte(htmlReport), 0644); err != nil {
		fmt.Printf("Error writing test_report.html: %v\n", err)
		os.Exit(1)
	}

	fmt.Println("✅ Reports generated:")
	fmt.Println("  - test_report.md")
	fmt.Println("  - test_report.html")
}
