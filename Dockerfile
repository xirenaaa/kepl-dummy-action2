# Stage 1: Build
FROM php:8.4-cli-alpine AS builder

# Install system dependencies and PHP extensions
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    libxml2-dev \
    zip \
    unzip \
    sqlite-dev \
    libzip-dev \
    && docker-php-ext-install pdo pdo_sqlite zip pcntl bcmath

# Install Composer
COPY --from=composer:2.8 /usr/bin/composer /usr/bin/composer

WORKDIR /app

# Cache layer: Copy composer dependency files first
COPY composer.json composer.lock ./

# Install dependencies without running application scripts
RUN composer install --no-dev --no-scripts --no-interaction --prefer-dist --optimize-autoloader

# Copy application source code
COPY . .

# Generate optimized autoloader and set up environment
RUN composer dump-autoload --optimize \
    && cp .env.example .env \
    && php artisan key:generate \
    && touch database/database.sqlite \
    && php artisan migrate --force \
    && php artisan db:seed --force

# Create user and change permissions in builder
RUN addgroup -g 1000 appgroup && adduser -u 1000 -G appgroup -S appuser \
    && chown -R appuser:appgroup /app \
    && chmod -R 775 /app/storage /app/bootstrap/cache /app/database

# Stage 2: Production
FROM php:8.4-cli-alpine

# Install ONLY runtime dependencies
RUN apk add --no-cache curl sqlite-libs libzip \
    && addgroup -g 1000 appgroup && adduser -u 1000 -G appgroup -S appuser

# Copy compiled PHP extensions and configuration from builder
COPY --from=builder /usr/local/lib/php/extensions/ /usr/local/lib/php/extensions/
COPY --from=builder /usr/local/etc/php/conf.d/ /usr/local/etc/php/conf.d/

WORKDIR /app

# Copy the app from builder with proper ownership
COPY --from=builder --chown=appuser:appgroup /app /app

USER appuser

EXPOSE 8000

HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl -f http://127.0.0.1:8000/ || exit 1

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
