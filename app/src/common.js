const fs = require('fs');
const cp  = require('child_process');

function joinCmd(arr) {
  return arr.join(' ');
}

function exec(cmd, opts) {
  return new Promise((resolve, reject) => {
    cp.exec(cmd, opts, (err, stdout, stderr) => {
      if (err) {
        reject(err)
      } else {
        resolve(stdout + stderr)
      }
    });
  })
}

function exists(path) {
  return new Promise(function(resolve, reject) {
    fs.exists(path, (err, stats) => {
      resolve(!err)
    });
  });
}

module.exports = {joinCmd, exec, exists, readFile};
