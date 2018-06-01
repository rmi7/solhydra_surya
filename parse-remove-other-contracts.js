const fs = require('fs');

const filepath = process.argv[2];
const contractname = process.argv[3];

const parseOutput = fs.readFileSync(filepath, 'utf8');

const splittedLines = parseOutput.split('\n');

const regex = new RegExp(` name: ${contractname}$`);

const indexOfThisContractStart = splittedLines.findIndex(line => (
  regex.test(line)
));

const onlyThisContractLines = splittedLines.slice(indexOfThisContractStart - 1);

const numberOfPrependSpaces = onlyThisContractLines[0].indexOf('type');

const finalLines = onlyThisContractLines.map(line => (
  line.slice(numberOfPrependSpaces)
));

fs.writeFileSync(filepath, finalLines.join('\n'));
