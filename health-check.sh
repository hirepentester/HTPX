#!/bin/bash
cd /opt/server-manager/ServerManager

echo "=========================================="
echo "Server Manager - Health Check"
echo "=========================================="
echo ""
echo "Current time: $(date)"
echo ""

echo "Docker Status:"
docker-compose -f docker-compose.prod.yml ps

echo ""
echo "Port 8001 Status:"
netstat -tulpn 2>/dev/null | grep 8001 || echo "Port 8001 not listening"

echo ""
echo "Application Logs (last 10 lines):"
docker-compose -f docker-compose.prod.yml logs app 2>/dev/null | tail -10 || echo "No app container"

echo ""
echo "Test HTTP Access:"
curl -s -m 5 http://localhost:8001/health 2>&1 | head -5 || echo "Not responding"

echo ""
echo "Done"
