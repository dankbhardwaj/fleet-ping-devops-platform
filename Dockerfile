# ================================
# Stage 1: Build dependencies
# ================================
FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

# ================================
# Stage 2: Production runtime
# ================================
FROM node:22-alpine

WORKDIR /app

COPY --from=builder /app ./

# Create non-root user and remove npm from runtime image
RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup && \
    rm -rf /usr/local/lib/node_modules/npm

USER appuser

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
    CMD wget --no-verbose --tries=1 --spider http://127.0.0.1:3000/health || exit 1

CMD ["node", "server.js"]
