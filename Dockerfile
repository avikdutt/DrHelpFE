# Stage 1: Build
FROM node:18-alpine AS builder

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --legacy-peer-deps

# Copy the rest of the code
COPY . .

# Build the Next.js app
RUN npm run build

# Stage 2: Run
FROM node:18-alpine

WORKDIR /app

# Copy built app from builder
COPY --from=builder /app ./

# Install production dependencies only (optional)
RUN npm install --omit=dev

# Expose the port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
