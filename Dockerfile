FROM node:slim AS builder

WORKDIR /app

COPY package.json yarn.lock ./
RUN yarn install

COPY . .
RUN yarn build

FROM node:slim AS runner

WORKDIR /app

COPY --from=builder /app ./

EXPOSE 3105

CMD ["yarn", "preview", "--host", "--port", "3105"]