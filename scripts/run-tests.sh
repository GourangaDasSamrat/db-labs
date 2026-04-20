#!/bin/bash
# Local SQL Script Testing Script
# Run this to test all SQL scripts locally before pushing to GitHub

set -e

echo "🚀 SQL Script Local Testing"
echo "=================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;94m'
NC='\033[0m' # No Color

# Check if Docker is running
if ! command -v docker &> /dev/null; then
    echo -e "${RED}❌ Docker is not installed${NC}"
    echo "Please install Docker to run the tests"
    exit 1
fi

# Check if docker-compose is running
if ! command -v docker-compose &> /dev/null; then
    echo -e "${RED}❌ Docker Compose is not installed${NC}"
    echo "Please install Docker Compose to run the tests"
    exit 1
fi

# Check if Go is installed
if ! command -v go &> /dev/null; then
    echo -e "${RED}❌ Go is not installed${NC}"
    echo "Please install Go 1.22+ to run the tests"
    exit 1
fi

# Start databases
echo -e "${BLUE}📦 Starting database containers...${NC}"
docker-compose up -d

# Wait for databases to be ready
echo -e "${BLUE}⏳ Waiting for databases to be ready...${NC}"
sleep 10

# Check MySQL
echo -e "${BLUE}Checking MySQL...${NC}"
until mysql -h 127.0.0.1 -u root -proot -e "SELECT 1" &> /dev/null; do
    echo "  Waiting for MySQL..."
    sleep 2
done
echo -e "${GREEN}✅ MySQL is ready${NC}"

# Check PostgreSQL
echo -e "${BLUE}Checking PostgreSQL...${NC}"
until PGPASSWORD=postgres psql -h 127.0.0.1 -U postgres -d postgres -c "SELECT 1" &> /dev/null; do
    echo "  Waiting for PostgreSQL..."
    sleep 2
done
echo -e "${GREEN}✅ PostgreSQL is ready${NC}"

echo ""
echo -e "${BLUE}🧪 Compiling and running SQL tests...${NC}"

# Build the test binary
echo -e "${BLUE}📥 Building test runner...${NC}"
cd scripts
go mod download
go build -o test_sql_scripts test_sql_scripts.go
cd ..

# Run tests
./scripts/test_sql_scripts
TEST_EXIT_CODE=$?

# Generate report
echo ""
echo -e "${BLUE}📊 Building and running report generator...${NC}"
cd scripts
go build -o generate_report generate_report.go
cd ..

./scripts/generate_report

# Display results
if [ -f "test_results.json" ]; then
    echo ""
    echo -e "${BLUE}📋 Test Results Summary:${NC}"
    echo "=================================="
    cat test_results.json | jq '.' || cat test_results.json
fi

# Optional: Stop containers
read -p "Stop database containers? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${BLUE}Stopping containers...${NC}"
    docker-compose down
    echo -e "${GREEN}✅ Containers stopped${NC}"
fi

# Exit with test result code
if [ $TEST_EXIT_CODE -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✅ All tests passed!${NC}"
    exit 0
else
    echo ""
    echo -e "${RED}❌ Some tests failed${NC}"
    exit 1
fi
