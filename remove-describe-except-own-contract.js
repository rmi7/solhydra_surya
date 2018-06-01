const fs = require('fs');

const filepath = process.argv[2];
const contractname = process.argv[3];

const describeOutput = fs.readFileSync(filepath, 'utf8');

const splittedLines = describeOutput.split('\n');

const indexOfThisContractStart = splittedLines.findIndex(line => (
  line.startsWith(` +  ${contractname} `)
));

fs.writeFileSync(filepath, splittedLines.slice(indexOfThisContractStart).join('\n'));
