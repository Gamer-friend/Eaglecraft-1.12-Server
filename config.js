const fs = require('fs');
const path = require('path');

const yarnLockPath = path.join(__dirname, 'yarn.lock');
const yarnLockJsPath = path.join(__dirname, 'yarn.lock.js');

fs.readFile(yarnLockPath, 'utf8', (err, data) => {
  if (err) {
    console.error('Error reading yarn.lock:', err);
    return;
  }

  const lines = data.split('\n');
  const yarnLockObject = {};
  let currentPackage = null;

  lines.forEach(line => {
    if (line.startsWith('"') && line.includes('@')) {
      currentPackage = line.trim().replace(/"/g, '');
      yarnLockObject[currentPackage] = {};
    } else if (currentPackage && line.trim()) {
      const [key, value] = line.trim().split(' ');
      yarnLockObject[currentPackage][key] = value.replace(/"/g, '');
    }
  });

  const output = `// yarn.lock.js\n\nconst yarnLock = ${JSON.stringify(yarnLockObject, null, 2)};\n\nmodule.exports = yarnLock;\n`;

  fs.writeFile(yarnLockJsPath, output, 'utf8', err => {
    if (err) {
      console.error('Error writing yarn.lock.js:', err);
    } else {
      console.log('yarn.lock.js has been created successfully.');
    }
  });
});
