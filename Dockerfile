# Tahap 1: Build aplikasi React
FROM node:18-alpine AS builder
WORKDIR /app
COPY package.json yarn.lock ./
# Atau jika menggunakan npm:
# COPY package.json package-lock.json ./

# Install dependencies
RUN yarn install --frozen-lockfile
# Atau jika menggunakan npm:
# RUN npm ci

COPY . .
RUN yarn build
# Atau jika menggunakan npm:
# RUN npm run build

# Tahap 2: Sajikan aplikasi menggunakan Nginx
FROM nginx:1.25-alpine
COPY --from=builder /app/build /usr/share/nginx/html

# (Opsional) Salin konfigurasi Nginx kustom jika ada
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]