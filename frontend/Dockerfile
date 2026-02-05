# Use Bun official image
FROM oven/bun:latest

# Set working directory
WORKDIR /app

# Copy package files and install deps early (for caching)
COPY package.json ./
COPY bun.lock ./

RUN bun install

# Copy rest of the source
COPY . .

# Run Vite dev server
CMD ["bun", "run", "dev"]
