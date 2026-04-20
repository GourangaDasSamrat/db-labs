package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"time"

	_ "github.com/go-sql-driver/mysql"
	_ "github.com/lib/pq"
	_ "github.com/mattn/go-sqlite3"
)

// TestResult represents a single test result
type TestResult struct {
	Passed        int          `json:"passed"`
	Failed        int          `json:"failed"`
	Total         int          `json:"total"`
	Status        string       `json:"status"`
	PassedScripts []string     `json:"passed_scripts"`
	Failures      []FailureInfo `json:"failures"`
}

// FailureInfo represents a single failure
type FailureInfo struct {
	Script   string `json:"script"`
	Database string `json:"database"`
	Error    string `json:"error"`
}

// DatabaseConfig holds database connection info
type DatabaseConfig struct {
	Host     string
	User     string
	Password string
	Database string
	Port     string
}

var (
	mysqlConfig = DatabaseConfig{
		Host:     "127.0.0.1",
		User:     "root",
		Password: "root",
		Database: "test_db",
		Port:     "3306",
	}

	postgresConfig = DatabaseConfig{
		Host:     "127.0.0.1",
		User:     "postgres",
		Password: "postgres",
		Database: "test_db",
		Port:     "5432",
	}

	sqlitePath = "/tmp/test_db.sqlite"

	dbPatterns = map[string]string{
		"mysql":      "mysql/**/*.sql",
		"postgresql": "postgresql/**/*.sql",
		"sqlite":     "sqlite/**/*.sql",
	}

	excludePatterns = []string{
		"Tasks",
		".dbml",
	}
)

// isExcluded checks if a file path should be excluded
func isExcluded(filepath string) bool {
	for _, pattern := range excludePatterns {
		if strings.Contains(filepath, pattern) {
			return true
		}
	}
	return false
}

// getSQLFiles returns all SQL files for a given database type
func getSQLFiles(dbType string) []string {
	var files []string

	err := filepath.Walk(dbType, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}

		if !info.IsDir() && strings.HasSuffix(path, ".sql") && !isExcluded(path) {
			files = append(files, path)
		}
		return nil
	})

	if err != nil {
		fmt.Printf("Error walking directory %s: %v\n", dbType, err)
	}

	sort.Strings(files)
	return files
}

// readSQLFile reads a SQL file and returns its content
func readSQLFile(filepath string) (string, error) {
	content, err := ioutil.ReadFile(filepath)
	if err != nil {
		return "", err
	}
	return string(content), nil
}

// resetMySQL resets the MySQL test database
func resetMySQL() error {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/", mysqlConfig.User, mysqlConfig.Password, mysqlConfig.Host, mysqlConfig.Port)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return err
	}
	defer db.Close()

	if err := db.Ping(); err != nil {
		return err
	}

	db.Exec("DROP DATABASE IF EXISTS " + mysqlConfig.Database)
	if _, err := db.Exec("CREATE DATABASE " + mysqlConfig.Database); err != nil {
		return err
	}

	return nil
}

// resetPostgreSQL resets the PostgreSQL test database
func resetPostgreSQL() error {
	connStr := fmt.Sprintf("host=%s user=%s password=%s dbname=postgres port=%s sslmode=disable",
		postgresConfig.Host, postgresConfig.User, postgresConfig.Password, postgresConfig.Port)
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return err
	}
	defer db.Close()

	if err := db.Ping(); err != nil {
		return err
	}

	// Terminate existing connections
	db.Exec(`SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE datname = 'test_db' AND pid <> pg_backend_pid()`)
	db.Exec("DROP DATABASE IF EXISTS " + postgresConfig.Database)
	if _, err := db.Exec("CREATE DATABASE " + postgresConfig.Database); err != nil {
		return err
	}

	return nil
}

// resetSQLite resets the SQLite test database
func resetSQLite() error {
	if _, err := os.Stat(sqlitePath); err == nil {
		os.Remove(sqlitePath)
	}
	return nil
}

// executeMySQL executes SQL against MySQL
func executeMySQL(sqlContent string) (bool, string) {
	dsn := fmt.Sprintf("%s:%s@tcp(%s:%s)/%s", mysqlConfig.User, mysqlConfig.Password, mysqlConfig.Host, mysqlConfig.Port, mysqlConfig.Database)
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		return false, fmt.Sprintf("MySQL Error: %v", err)
	}
	defer db.Close()

	statements := strings.Split(sqlContent, ";")
	for _, stmt := range statements {
		stmt = strings.TrimSpace(stmt)
		if stmt == "" || strings.HasPrefix(stmt, "--") || strings.HasPrefix(stmt, "/*") {
			continue
		}

		if _, err := db.Exec(stmt); err != nil {
			return false, fmt.Sprintf("MySQL Error: %s", truncateError(err.Error()))
		}
	}

	return true, "Success"
}

// executePostgreSQL executes SQL against PostgreSQL
func executePostgreSQL(sqlContent string) (bool, string) {
	connStr := fmt.Sprintf("host=%s user=%s password=%s dbname=%s port=%s sslmode=disable",
		postgresConfig.Host, postgresConfig.User, postgresConfig.Password, postgresConfig.Database, postgresConfig.Port)
	db, err := sql.Open("postgres", connStr)
	if err != nil {
		return false, fmt.Sprintf("PostgreSQL Error: %v", err)
	}
	defer db.Close()

	// Try executing all at once first
	if _, err := db.Exec(sqlContent); err == nil {
		return true, "Success"
	}

	// Fall back to statement-by-statement
	statements := strings.Split(sqlContent, ";")
	for _, stmt := range statements {
		stmt = strings.TrimSpace(stmt)
		if stmt == "" || strings.HasPrefix(stmt, "--") || strings.HasPrefix(stmt, "/*") {
			continue
		}

		if _, err := db.Exec(stmt); err != nil {
			return false, fmt.Sprintf("PostgreSQL Error: %s", truncateError(err.Error()))
		}
	}

	return true, "Success"
}

// executeSQLite executes SQL against SQLite
func executeSQLite(sqlContent string) (bool, string) {
	db, err := sql.Open("sqlite3", sqlitePath)
	if err != nil {
		return false, fmt.Sprintf("SQLite Error: %v", err)
	}
	defer db.Close()

	statements := strings.Split(sqlContent, ";")
	for _, stmt := range statements {
		stmt = strings.TrimSpace(stmt)
		if stmt == "" || strings.HasPrefix(stmt, "--") {
			continue
		}

		if _, err := db.Exec(stmt); err != nil {
			return false, fmt.Sprintf("SQLite Error: %s", truncateError(err.Error()))
		}
	}

	return true, "Success"
}

// truncateError truncates error messages to 200 chars
func truncateError(msg string) string {
	if len(msg) > 200 {
		return msg[:200]
	}
	return msg
}

// testSQLFile tests a single SQL file
func testSQLFile(filepath string, dbType string) (bool, string) {
	content, err := readSQLFile(filepath)
	if err != nil {
		return false, "File not found"
	}

	if strings.TrimSpace(content) == "" {
		return true, "Empty file (skipped)"
	}

	switch dbType {
	case "mysql":
		return executeMySQL(content)
	case "postgresql":
		return executePostgreSQL(content)
	case "sqlite":
		return executeSQLite(content)
	default:
		return false, fmt.Sprintf("Unknown database type: %s", dbType)
	}
}

// main is the entry point
func main() {
	startTime := time.Now()

	result := &TestResult{
		Passed:        0,
		Failed:        0,
		PassedScripts: []string{},
		Failures:      []FailureInfo{},
	}

	fmt.Println("🔄 Resetting databases...")

	// Reset databases
	if err := resetMySQL(); err != nil {
		fmt.Printf("Warning: Could not reset MySQL: %v\n", err)
	}
	if err := resetPostgreSQL(); err != nil {
		fmt.Printf("Warning: Could not reset PostgreSQL: %v\n", err)
	}
	if err := resetSQLite(); err != nil {
		fmt.Printf("Warning: Could not reset SQLite: %v\n", err)
	}

	fmt.Println("\n" + strings.Repeat("=", 70))
	fmt.Println("🚀 Running SQL Script Validation Tests")
	fmt.Println(strings.Repeat("=", 70) + "\n")

	// Test each database type
	for dbType := range dbPatterns {
		files := getSQLFiles(dbType)

		fmt.Printf("\n📦 Testing %s (%d files)\n", strings.ToUpper(dbType), len(files))
		fmt.Println(strings.Repeat("-", 70))

		for _, filepath := range files {
			success, message := testSQLFile(filepath, dbType)

			if success {
				result.Passed++
				result.PassedScripts = append(result.PassedScripts, filepath)
				fmt.Printf("  ✅ %s\n", filepath)
			} else {
				result.Failed++
				result.Failures = append(result.Failures, FailureInfo{
					Script:   filepath,
					Database: dbType,
					Error:    message,
				})
				fmt.Printf("  ❌ %s\n", filepath)
				fmt.Printf("     └─ %s\n", message)
			}
		}
	}

	result.Total = result.Passed + result.Failed

	if result.Failed == 0 {
		result.Status = "success"
	} else {
		result.Status = "failure"
	}

	// Print summary
	fmt.Println("\n" + strings.Repeat("=", 70))
	fmt.Println("📊 Test Summary")
	fmt.Println(strings.Repeat("=", 70))
	fmt.Printf("Total Tests: %d\n", result.Total)
	fmt.Printf("✅ Passed: %d\n", result.Passed)
	fmt.Printf("❌ Failed: %d\n", result.Failed)

	if result.Failed > 0 {
		fmt.Println("\n🔴 Failed Scripts:")
		for _, failure := range result.Failures {
			fmt.Printf("  - %s (%s)\n", failure.Script, failure.Database)
			fmt.Printf("    Error: %s\n", failure.Error)
		}
	}

	// Write results to JSON file
	jsonData, err := json.MarshalIndent(result, "", "  ")
	if err != nil {
		fmt.Printf("Error marshaling JSON: %v\n", err)
		os.Exit(1)
	}

	if err := ioutil.WriteFile("test_results.json", jsonData, 0644); err != nil {
		fmt.Printf("Error writing test results: %v\n", err)
		os.Exit(1)
	}

	fmt.Println("\n✅ Test results saved to test_results.json")
	fmt.Printf("⏱️  Test duration: %v\n", time.Since(startTime))

	if result.Failed > 0 {
		fmt.Printf("\n❌ %d test(s) failed\n", result.Failed)
		os.Exit(1)
	} else {
		fmt.Println("\n✅ All tests passed!")
		os.Exit(0)
	}
}
