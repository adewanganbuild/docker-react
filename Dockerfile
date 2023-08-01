FROM node:20-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# /app/build --- the folder which we care about
FROM nginx
# EXPOSE is for AWS Elastic Beanstalk.
# It does nothing on command line
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html
