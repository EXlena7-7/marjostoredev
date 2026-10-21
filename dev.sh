#!/bin/bash

# Para matar procesos correindos pkill -f "artisan serve"; php artisan serve & npm run dev


# Colores
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}Iniciando servidores de desarrollo...${NC}"

# Matar procesos al salir con Ctrl+C
cleanup() {
    echo -e "\n${YELLOW}Deteniendo servidores...${NC}"
    kill $PID_SERVE $PID_NPM 2>/dev/null
    exit 0
}
trap cleanup INT TERM

# Iniciar php artisan serve en background
php artisan serve &
PID_SERVE=$!
echo -e "${GREEN}✓ php artisan serve iniciado (PID: $PID_SERVE)${NC}"

# Iniciar npm run dev en background
npm run dev &
PID_NPM=$!
echo -e "${GREEN}✓ npm run dev iniciado (PID: $PID_NPM)${NC}"

echo -e "${YELLOW}Presiona Ctrl+C para detener ambos servidores.${NC}\n"

# Esperar a que terminen
wait $PID_SERVE $PID_NPM
