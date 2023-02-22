# Stage 1: Define Base Image
FROM node:16-alpine as builder

# Define Working Directory
WORKDIR '/app'

# Preparing npm to work
COPY package.json ./
RUN npm install
RUN mkdir ./node_modules/.cache && chmod -R 777 ./node_modules/.cache

# Copying data after dependencies installation
COPY . .

# Building the Production Code (/app/build <---- Files we want)
RUN npm run build

# Stage 2: Define Base Image
FROM nginx
EXPOSE 80

# Copy the builded Code from Previous Stage to Nginx
COPY --from=builder /app/build /usr/share/nginx/html
