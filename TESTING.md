# SQL Script Validation & Testing Guide

This document explains the automated SQL script validation workflow and how to use it.

## Overview

The SQL validation system automatically:
- ✅ Runs all SQL scripts against actual database instances (MySQL, PostgreSQL, SQLite)
- 🐛 Detects errors and creates GitHub Issues
- 🔄 Automatically closes issues when errors are fixed
- 📊 Generates detailed test reports

## Workflow Architecture

### GitHub Actions Workflow
The workflow (`.github/workflows/sql-validation.yml`) runs on:
- **Push** to main or develop branches
- **Pull Request** creation/updates to main or develop branches

### Workflow Steps

1. **Checkout Code** - Gets the latest repository code
2. **Setup Go** - Prepares Go 1.22 runtime
3. **Download Dependencies** - Downloads Go modules
4. **Start Services** - MySQL and PostgreSQL containers
5. **Compile Test Runner** - Builds the test executable
6. **Run Tests** - Executes all SQL scripts
7. **Compile Report Generator** - Builds the report generator
8. **Generate Reports** - Creates test reports
9. **Comment on PR** - Posts results as PR comment
10. **Manage Issues** - Creates/updates/closes GitHub issues

## Local Testing

### Prerequisites

- Docker and Docker Compose
- Go 1.22+
- MySQL client (optional, for troubleshooting)
- PostgreSQL client (optional, for troubleshooting)

### Running Tests Locally

```bash
# Make script executable
chmod +x scripts/run-tests.sh

# Run the test suite
./scripts/run-tests.sh
```

This will:
1. Start MySQL and PostgreSQL containers using Docker Compose
2. Wait for databases to be ready
3. Install Python dependencies
4. Run all SQL scripts against the databases
5. Generate HTML and Markdown reports
6. Optionally stop the containers

### Manual Setup (Advanced)

```bash
# Start databases
docker-compose up -d

# Wait for databases to be ready
sleep 10

# Download Go modules
cd scripts
go mod download
cd ..

# Build test runner
cd scripts
go build -o test_sql_scripts test_sql_scripts.go
cd ..

# Run tests
./scripts/test_sql_scripts

# Build report generator
cd scripts
go build -o generate_report generate_report.go
cd ..

# Generate reports
./scripts/generate_report

# View results
cat test_results.json

# Stop databases
docker-compose down
```

## Test Results

### Output Files

- **test_results.json** - Structured test results (JSON)
- **test_report.md** - Markdown formatted report
- **test_report.html** - HTML formatted report with styling

### Example Results Structure

```json
{
  "status": "failure",
  "passed": 45,
  "failed": 2,
  "total": 47,
  "passed_scripts": [
    "mysql/01_crud-operations/create-tables.sql",
    "...more files..."
  ],
  "failures": [
    {
      "script": "mysql/02_operators/01_between-operator.sql",
      "database": "mysql",
      "error": "Syntax error at line 5"
    }
  ]
}
```

## GitHub Issue Management

### Automatic Issue Creation

When tests fail, the workflow automatically:

1. **Creates a new issue** with:
   - Title: "SQL Script Validation Failure"
   - Label: `sql-validation-failure`
   - Detailed failure information
   - Link to the workflow run

2. **Updates existing issue** if one already exists

3. **Posts failure details** including:
   - Commit SHA
   - Branch name
   - Author
   - Failed scripts list
   - Error messages

### Automatic Issue Resolution

When all tests pass after a failure:

1. **Issue is closed** automatically
2. **Comment is added** confirming the fix
3. **Commit SHA** is recorded in the closing comment

### Example Issue

```
Title: SQL Script Validation Failure

SQL Script Validation Failure Report

Commit: abc123def456
Branch: refs/heads/feature/new-queries
Author: @username
Timestamp: 2024-04-20T10:30:00Z

Failed Scripts:
- mysql/02_operators/01_between-operator.sql: Syntax error...
- postgresql/01_crud-operations/select-queries.sql: Table not found...

Action Required:
Please review the failed SQL scripts and fix the issues. The issue will be
automatically closed once the failures are resolved in the next push/PR.
```

## Test Execution Details

### MySQL Testing

- **Image**: mysql:8.0
- **User**: root
- **Password**: root
- **Database**: test_db
- **Port**: 3306

### PostgreSQL Testing

- **Image**: postgres:15
- **User**: postgres
- **Password**: postgres
- **Database**: test_db
- **Port**: 5432

### SQLite Testing

- **File**: /tmp/test_db.sqlite
- **No credentials needed**

### Database Reset

Before each test run, databases are:
1. Dropped (previous data removed)
2. Recreated (fresh state)
3. Ready for tests

This ensures tests are isolated and repeatable.

## File Organization

```
.github/
└── workflows/
    └── sql-validation.yml          # Main GitHub Actions workflow

scripts/
├── test_sql_scripts.go             # Core test runner (Go)
├── generate_report.go              # Report generator (Go)
└── run-tests.sh                    # Local testing script

go.mod                              # Go module definition

docker-compose.yml                  # Database containers configuration

mysql/
├── 01_crud-operations/
├── 02_operators/
└── ...

postgresql/
├── 01_crud-operations/
├── 02_operators/
└── ...

sqlite/
├── 01_crud-operations/
├── 02_operators/
└── ...
```

## Troubleshooting

### Tests fail locally but I want to push anyway

```bash
# Skip GitHub Actions check (not recommended)
git push --no-verify
```

### Database connection errors

```bash
# Verify containers are running
docker-compose ps

# View container logs
docker-compose logs mysql
docker-compose logs postgres

# Restart containers
docker-compose restart
```

### Go compilation issues

```bash
# Ensure Go 1.22+ is installed
go version

# Download modules if not already done
cd scripts
go mod download
cd ..

# Clean build
cd scripts
go clean
go build -o test_sql_scripts test_sql_scripts.go
go build -o generate_report generate_report.go
cd ..
```

### Excluded Test Directories

The following are automatically excluded from tests:
- `Tasks/**` - Task directories (not actual SQL examples)
- `**/schema.dbml` - Database schema diagrams

### Adding New SQL Scripts

Simply add `.sql` files to the appropriate database directory:

```
mysql/your-category/
└── your-script.sql          # Will be automatically tested
```

## SQL Script Best Practices

For scripts to pass validation:

1. **Use valid syntax** for target database
2. **Include error handling** for existing data
3. **Use IF NOT EXISTS** for CREATE statements
4. **Use IF EXISTS** for DROP statements
5. **Avoid hardcoded data paths** (use relative paths or environment variables)
6. **Comment your code** for clarity

### Example: MySQL Script

```sql
-- Create tables if they don't exist
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE
);

-- Insert sample data
INSERT INTO users (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

-- Query results
SELECT * FROM users;
```

### Example: PostgreSQL Script

```sql
-- Create table with constraints
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert data
INSERT INTO users (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com')
ON CONFLICT (email) DO NOTHING;

-- Query results
SELECT * FROM users WHERE created_at > NOW() - INTERVAL '1 day';
```

### Example: SQLite Script

```sql
-- SQLite doesn't support IF NOT EXISTS for columns
DROP TABLE IF EXISTS users;

-- Create table
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT UNIQUE
);

-- Insert data
INSERT INTO users (name, email) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com');

-- Query results
SELECT * FROM users;
```

## GitHub Actions Secrets

No additional secrets are required. The workflow uses:
- Built-in `github` context for API access
- Service containers for databases
- Default permissions for issues and PR comments

## Permissions

The workflow requires:
- `contents: read` - Read repository code
- `issues: write` - Create/update GitHub issues
- `pull-requests: write` - Comment on pull requests

These are configured in the workflow file.

## Performance

- **Test Duration**: 2-5 minutes typical
- **Database Startup**: ~30 seconds
- **SQL Execution**: ~1-2 minutes
- **Report Generation**: <10 seconds

## Environment Variables

The workflow uses these environment variables:

```yaml
MYSQL_ROOT_PASSWORD: root
MYSQL_DATABASE: test_db
POSTGRES_PASSWORD: postgres
POSTGRES_DB: test_db
```

## Success Criteria

A test passes when:
- ✅ SQL syntax is valid
- ✅ All statements execute successfully
- ✅ No database errors occur
- ✅ Data operations complete without exceptions

A test fails when:
- ❌ Syntax errors in SQL
- ❌ Reference errors (table/column not found)
- ❌ Constraint violations
- ❌ Permission errors
- ❌ Connection timeouts

## Next Steps

1. Push this repository to GitHub
2. The workflow will automatically run on the first push
3. Check the "Actions" tab to see workflow results
4. Fix any failing scripts
5. The workflow will automatically close fixed issues

## Support

For issues with the workflow:
1. Check the workflow run details in GitHub Actions
2. Review the test results JSON
3. Compare test scripts with working examples
4. Check database connectivity logs

## Additional Resources

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Docker Compose Reference](https://docs.docker.com/compose/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [SQLite Documentation](https://www.sqlite.org/docs.html)
