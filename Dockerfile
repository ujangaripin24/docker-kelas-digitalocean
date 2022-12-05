FROM node:16.18.0

WORKDIR /node-app-2

COPY package*.json ./
RUN npm install --silent

COPY . ./

EXPOSE 5200

COPY . ./
