# From oven/bun:latest
From node:18

WORKDIR /app

COPY package.json ./
# COPY package.json bun.lockb ./

RUN npm install

# RUN bun install

COPY . .

EXPOSE 3000

# RUN bun run build
RUN npm run build

# CMD bun run preview
CMD npm run preview