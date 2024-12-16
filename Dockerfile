# Stage 1: Build the app
FROM node:18-alpine AS build

WORKDIR /app

# Copy only the package files first
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY ./src ./src
COPY ./public ./public

# Build the app
RUN npm run build

# Stage 2: Serve the app
FROM node:18-alpine

WORKDIR /app

# Install serve globally
RUN npm install -g serve

# Copy the build output from the previous stage
COPY --from=build /app/build /app/build

# Expose port 8089
EXPOSE 8089

# Start the app using serve command and specify port 8089
CMD [ "serve", "-s", "build", "-l", "8089" ]
