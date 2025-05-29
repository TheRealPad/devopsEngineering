FROM node:20-alpine
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
COPY . .
EXPOSE 80
CMD ["node", "server.js"]