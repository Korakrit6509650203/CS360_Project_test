# ใช้ Node.js เป็น base image
FROM node:20

# ตั้งค่า working directory
WORKDIR /usr/src/app

# คัดลอก package.json
COPY backend/package*.json ./

# ติดตั้ง dependencies
RUN npm install --force

# คัดลอกโค้ดทั้งหมดไปยัง container
COPY backend/public ./public
COPY backend/src ./src
COPY backend/routes ./route
COPY backend/mockConfig ./mockConfig

# สร้างไฟล์ .env โดยสุ่มค่าต่าง ๆ
RUN echo "HOST=0.0.0.0" >> .env && \
    echo "PORT=1337" >> .env && \
    echo "APP_KEYS=$(openssl rand -base64 32),$(openssl rand -base64 32),$(openssl rand -base64 32),$(openssl rand -base64 32)" >> .env && \
    echo "API_TOKEN_SALT=$(openssl rand -base64 16)" >> .env && \
    echo "ADMIN_JWT_SECRET=$(openssl rand -base64 32)" >> .env && \
    echo "TRANSFER_TOKEN_SALT=$(openssl rand -base64 16)" >> .env && \
    echo "# Database" >> .env && \
    echo "DATABASE_CLIENT=sqlite" >> .env && \
    echo "DATABASE_FILENAME=.tmp/data.db" >> .env && \
    echo "JWT_SECRET=$(openssl rand -base64 32)" >> .env

# Build the app
RUN npm run build

# ติดตั้ง serve เพื่อ serve static files
RUN npm install -g serve

# เปิด port ที่ต้องการ
EXPOSE 1337

# Start the app using serve
CMD ["serve", "-s", "build", "-l", "1337"]