FROM node:17.4.0-alpine AS base

# パッケージのインストールを行う
WORKDIR /base
COPY . .
RUN npm install

# Production向けビルドを行う
FROM base AS build
WORKDIR /build
COPY --from=base /base ./
RUN NODE_ENV=production npm run build

# ビルド成果物をコピーし、サーバーを起動
FROM node:17.4.0-alpine AS production
ENV NODE_ENV=production
WORKDIR /app
# ビルド成果物のみをコピーしてやる
COPY --from=build /build/package.json /build/package-lock.json ./
COPY --from=build /build/.next ./.next
COPY --from=build /build/public ./public
# node_modules以下がこのイメージにないので、next.jsのサーバーを動かすために必要
RUN npm install next

EXPOSE 3000
CMD ["npm", "run", "start"]
