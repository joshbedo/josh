FROM node:20 as build

WORKDIR /build

COPY . .

RUN npm install
RUN npm run build

FROM public.ecr.aws/lambda/nodejs:20

COPY --from=build /build/node_modules ${LAMBDA_TASK_ROOT}/node_modules
COPY --from=build /build/dist/ ${LAMBDA_TASK_ROOT}

CMD ["index.handler"]
