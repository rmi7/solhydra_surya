FROM node:8.7.0

RUN apt-get update && apt-get install -y graphviz

RUN npm install --quiet --no-progress --global surya

COPY extract-function-names-of-contract.js /app/extract-function-names-of-contract.js
COPY png-to-dataurl.js /app/png-to-dataurl.js
COPY get-last-contract-name.js /app/get-last-contract-name.js
COPY remove-describe-except-own-contract.js /app/remove-describe-except-own-contract.js
COPY parse-remove-other-contracts.js /app/parse-remove-other-contracts.js

COPY run.sh /app/run.sh

CMD ["sh", "/app/run.sh"]
