# Build Stage
FROM node:18-alpine AS builder

# Set the working directory
WORKDIR /app

# Install dependencies
COPY package*.json ./
RUN npm install

# Copy the application code and build it
COPY . .
RUN npm run build

# Production Stage
FROM nginx:1.23

# Copy built files to Nginx directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose the port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

