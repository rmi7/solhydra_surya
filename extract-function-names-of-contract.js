const path = require('path');
const fs = require('fs');

const filename = process.argv[2];

const describeOutput = fs.readFileSync(path.join('/app/output/describe/', filename), 'utf8');

const functionNames = describeOutput
  .split('\n')
  .slice(1)
  .map(s => s.trim())
  .filter(s => s.startsWith('-'))
  .map(s => s.replace(/- \[[a-zA-Z]{3}\] /, ''))
  .filter(s => s !== '<fallback>')
  .map(s => s.match(/[a-zA-Z0-9_]+/gm)[0])
  .join(' ');

console.log(functionNames);
