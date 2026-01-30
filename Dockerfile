cat Dockerfile 
# Use an official Node.js runtime as a parent image (choose a specific LTS version for stability)
FROM node:20-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (or npm-shrinkwrap.json)
# separately to leverage Docker cache layers
COPY package*.json ./

# Install dependencies (including devDependencies for development)
RUN npm install

# Copy the rest of your application's source code to the container
COPY . .

# Expose the port your app runs on (e.g., 3000, 5173, etc. - check your package.json script)
EXPOSE 3000

# Define the command to run your app in development mode
# This assumes you have a "dev" script in your package.json (e.g., "dev": "nodemon index.js")
CMD [ "npm", "run", "dev" ]
