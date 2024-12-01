# ใช้ Node.js เป็น base image
FROM node:18-alpine AS build

# กำหนด Working Directory
WORKDIR /usr/src/app

# คัดลอกไฟล์ package.json
COPY backend/package*.json ./

# ติดตั้ง dependencies
RUN npm install --force

# คัดลอกโค้ดทั้งหมดไปยัง container
COPY backend/mockConfig ./mockConfig
COPY backend/routes ./routes
COPY backend/src ./src
COPY backend/public ./public
COPY backend/config/database.js ./config/database.js

# สร้างไฟล์ build (ใช้สำหรับ Production)
RUN npm run build

RUN mkdir -p .tmp && \
    echo "HOST=0.0.0.0" >> .env && \
    echo "PORT=1337" >> .env && \
    echo "APP_KEYS=$(openssl rand -base64 32)" >> .env && \
    echo "API_TOKEN_SALT=$(openssl rand -base64 16)" >> .env && \
    echo "ADMIN_JWT_SECRET=$(openssl rand -base64 32)" >> .env && \
    echo "DATABASE_CLIENT=sqlite" >> .env && \
    echo "DATABASE_FILENAME=.tmp/data.db" >> .env && \
    echo "JWT_SECRET=$(openssl rand -base64 32)" >> .env

# ใช้ Alpine Linux เพื่อรันแอปใน Production
FROM node:18-alpine

# กำหนด Working Directory
WORKDIR /usr/src/app

# คัดลอก Dependencies จาก stage build มา
COPY --from=build /usr/src/app/node_modules ./node_modules

# คัดลอกไฟล์โค้ดทั้งหมด (รวมไฟล์ build)
COPY --from=build /usr/src/app .

# เปิดพอร์ต (Strapi ใช้พอร์ตเริ่มต้น 1337)
EXPOSE 1337

# เริ่มแอป Strapi
CMD ["npm", "start"]