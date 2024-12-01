# ใช้ Node.js เป็น base image
FROM node:18-alpine AS build

# กำหนด Working Directory
WORKDIR /usr/src/app

# คัดลอกไฟล์ package.json และ package-lock.json
COPY package.json package-lock.json ./

# ติดตั้ง dependencies
RUN npm install

# คัดลอกไฟล์โค้ดทั้งหมด
COPY . .

# สร้างไฟล์ build (ใช้สำหรับ Production)
RUN npm run build

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