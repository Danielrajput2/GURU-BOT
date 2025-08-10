# ---- Base Image ----
FROM node:20-bullseye

# ---- System Dependencies ----
RUN apt-get update && \
    apt-get install -y \
    ffmpeg \
    imagemagick \
    webp && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# ---- App Directory ----
WORKDIR /app

# ---- Install Dependencies ----
# Copy only package.json files first (for caching)
COPY package*.json ./

# Install only production deps for smaller image
RUN npm install --only=production

# ---- Copy Source Code ----
COPY . .

# ---- Render Port Config ----
# If your bot is a web service, Render will set process.env.PORT
# Uncomment the following line if you want to set a default:
# ENV PORT=3000

# ---- Start Command ----
# If package.json has "start" script, this will work:
CMD ["npm", "start"]

# If not, comment above and uncomment below:
# CMD ["node", "index.js"]
