# db-labs 🚀

Personal Backend practice repository — a collection of small labs, exercises, and experiments I work on while learning and exploring databse (sql and nosql).

[![SQL Script Validation](https://github.com/gouranga2/db-labs/actions/workflows/sql-validation.yml/badge.svg)](https://github.com/gouranga2/db-labs/actions/workflows/sql-validation.yml)

About
-----
- Purpose: Practice Databse concepts, try out ideas, and keep short, focused experiments. 🧪
- Style: Labs are usually small and self-contained. Each lab may include a short README describing its goal. 📘
- Intent: This is a learning playground — expect experiments, notes, and incremental improvements. 🔧

## 🧪 Automated Testing

All SQL scripts are automatically validated against real database instances:

- ✅ **MySQL 8.0** - Tests all `mysql/` SQL scripts
- ✅ **PostgreSQL 15** - Tests all `postgresql/` SQL scripts
- ✅ **SQLite** - Tests all `sqlite/` SQL scripts

### Quick Start - Local Testing

```bash
# Make test script executable
chmod +x scripts/run-tests.sh

# Run all SQL tests locally
./scripts/run-tests.sh
```

This will:
1. Start MySQL and PostgreSQL containers
2. Execute all SQL scripts
3. Generate test reports
4. Show results with pass/fail status

### GitHub Actions

Tests run automatically on:
- 🔀 **Pull Requests** to main/develop
- 📤 **Pushes** to main/develop

If tests fail:
- 🚨 A GitHub Issue is automatically created
- 🔍 Issue contains detailed failure information

When tests pass again:
- ✅ Issue is automatically closed
- 💬 Confirmation comment is added

## 📚 Documentation

- [TESTING.md](./TESTING.md) - Complete testing guide
- [SQL Best Practices](./TESTING.md#sql-script-best-practices)
- [Troubleshooting](./TESTING.md#troubleshooting)

## 📁 Structure

```
db-labs/
├── mysql/              # MySQL practice scripts
├── postgresql/         # PostgreSQL practice scripts
├── sqlite/             # SQLite practice scripts
├── redis/              # Redis practice labs
├── scripts/            # Testing and utility scripts
└── .github/workflows/  # GitHub Actions workflows
```

Happy coding!
