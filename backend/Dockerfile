# Stage 1: Build Stage
FROM node:20 AS build

# กำหนด Working Directory
WORKDIR /usr/src/app
COPY backend/package*.json ./
RUN npm install --force
COPY . .
RUN npm run build

# Stage 2: Production Stage
FROM node:20
WORKDIR /usr/src/app
COPY --from=build /usr/src/app/dist ./dist  
COPY --from=build /usr/src/app/node_modules ./node_modules 
EXPOSE 1337
CMD ["npm", "start"]
