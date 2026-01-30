# Stage 1: Build Stage
FROM node:20-bullseye-slim AS builder

# Set the working directory
WORKDIR /app

# Copy package files first to leverage Docker's layer caching
COPY package*.json ./

# Install all dependencies (including dev dependencies for building)
RUN npm install

# Copy the rest of the application source code
COPY . .

# Build the application (adjust if your command is different, e.g., 'npm run build:prod')
RUN npm run build

# Stage 2: Production Stage (Serving with Nginx)
FROM nginx:stable-alpine

# Copy the built files from the 'builder' stage to Nginx's default public folder
# Note: 'dist' is the common folder name; change to 'build' if using Create React App
COPY --from=builder /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
