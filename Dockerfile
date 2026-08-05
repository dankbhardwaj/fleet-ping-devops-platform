# ==========================
# Stage 1 - Build
# ==========================

FROM node:22-alpine AS builder

WORKDIR /app

COPY package*.json ./

RUN npm ci --omit=dev

COPY . .

# ==========================
# Stage 2 - Production
# ==========================

FROM node:22-alpine

WORKDIR /app

ENV NODE_ENV=production

COPY --from=builder /app .

RUN addgroup -S appgroup && \
    adduser -S appuser -G appgroup

USER appuser

EXPOSE 3000

HEALTHCHECK --interval=30s \
            --timeout=5s \
            --start-period=20s \
            --retries=3 \
CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

CMD ["node","server.js"]
