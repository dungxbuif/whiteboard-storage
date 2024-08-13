FROM node:20-alpine As development
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
RUN yarn
COPY --chown=node:node . .
USER node
FROM node:20-alpine As build
WORKDIR /usr/src/app
COPY --chown=node:node package*.json ./
COPY --chown=node:node --from=development /usr/src/app/node_modules ./node_modules
COPY --chown=node:node . .
RUN yarn build
ENV NODE_ENV production
RUN yarn install --production && yarn cache clean
USER node
FROM node:20-alpine As production
COPY --chown=node:node --from=build /usr/src/app/node_modules ./node_modules
COPY --chown=node:node --from=build /usr/src/app/dist ./dist


ENTRYPOINT ["npm", "run", "start:prod"]
