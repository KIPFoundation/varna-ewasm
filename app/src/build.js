// Translated from https://github.com/wasdk/wasmexplorer-service/blob/master/web/build.php
// FIXME make me node.js friendly and async

const { llvmDir, wasmGCCmd, chiselCmd, wasmdisCmd, tempDir, sysroot } = require("../config");
const { mkdirSync, writeFileSync, existsSync, openSync, closeSync, readFileSync, unlinkSync } = require("fs");
const { deflateSync } = require("zlib");
const { dirname } = require("path");
const { execSync } = require("child_process");
const { Writable } = require("stream");
const homeDir = process.env["HOME"];

const { exec, joinCmd, exists } = require("./common.js");

// Input: JSON in the following format
// {
//     output: "wasm",
//     files: [
//         {
//             type: "cpp",
//             name: "file.cpp",
//             options: "-O3 -std=c++98",
//             src: "puts(\"hi\")"
//         }
//     ],
//     link_options: "--import-memory"
// }
// Output: JSON in the following format
// {
//     success: true,
//     message: "Success",
//     output: "AGFzbQE.... =",
//     tasks: [
//         {
//             name: "building file.cpp",
//             file: "file.cpp",
//             success: true,
//             console: ""
//         },
//         {
//             name: "linking wasm",
//             success: true,
//             console: ""
//         }llvmDir
//     ]
// }

function sanitize_shell_output(out) {
  return out; // FIXME
}

function shell_exec(cmd, cwd = tempDir) {
  const out = openSync(cwd + '/out.log', 'w');
  let error = '';
  try {
    execSync(cmd, {cwd, stdio: [null, out, out],});
  } catch (ex) {
    error = ex.message;
  } finally {
    closeSync(out);
  }
  const result = readFileSync(cwd + '/out.log').toString() || error;
  return result;
}

function get_clang_options(options) {
  const clang_flags = `--target=wasm32-unknown-unknown-wasm --sysroot=${sysroot} -fdiagnostics-print-source-range-info -fno-exceptions`;
  if (!options) {
    return clang_flags;
  }
  const available_options = [
    '-O0', '-O1', '-O2', '-O3', '-O4', '-Os', '-fno-exceptions', '-fno-rtti',
    '-ffast-math', '-fno-inline', '-std=c99', '-std=c89', '-std=c++14',
    '-std=c++1z', '-std=c++11', '-std=c++98', '-g'
  ];
  let safe_options = '-c';
  for (let o of available_options) {
    if (options.includes(o)) {
      safe_options += ' ' + o;
    } else if (o.includes('-std=') && options.toLowerCase().includes(o)) {
      safe_options += ' ' + o;
    }
  }
  return clang_flags + ' ' + safe_options;
}


function get_lld_options(options) {
  const clang_flags = `--target=wasm32-unknown-unknown-wasm --sysroot=${sysroot} -nostartfiles -Wl,--allow-undefined,--no-entry,--no-threads`;
  if (!options) {
    return clang_flags;
  }
  const available_options = ['--import-memory', '-g'];
  let safe_options = '';
  for (let o of available_options) {
    if (options.includes(o)) {
      safe_options += ' -Wl,' + o;
    }
  }
  return clang_flags + safe_options;
}

function serialize_file_data(filename, compress) {
  let content = readFileSync(filename);
  if (compress) {
    content = deflateSync(content);
  }
  return content.toString("base64");   
}

function build_c_file(input, options, output, cwd, compress, result_obj) {
  const cmd = llvmDir + '/bin/clang ' + get_clang_options(options) + ' ' + input + ' -o ' + output;
  const out = shell_exec(cmd, cwd);
  result_obj.console = sanitize_shell_output(out);
  if (!existsSync(output)) {
    result_obj.success = false;
    return false;
  }
  result_obj.success = true;
  result_obj.output = serialize_file_data(output, compress);
  return true;
}

function build_cpp_file(input, options, output, cwd, compress, result_obj) {
  const cmd = llvmDir + '/bin/clang++ ' + get_clang_options(options) + ' ' + input + ' -o ' + output;
  const out = shell_exec(cmd, cwd);
  result_obj.console = sanitize_shell_output(out);
  if (!existsSync(output)) {
    result_obj.success = false;
    return false;
  }
  result_obj.success = true;
  result_obj.output = serialize_file_data(output, compress);
  return true;
}

function validate_filename(name) {
  if (!/^[0-9a-zA-Z\-_.]+(\/[0-9a-zA-Z\-_.]+)*$/.test(name)) {
    return false;
  }
  const parts = name.split(/\//g);
  for(let p of parts) {
    if (p == '.' || p == '..') {
      return false;
    }
  }
  return parts;
}

function link_obj_files(obj_files, options, cwd, has_cpp, output, result_obj) {
  const files = obj_files.join(' ');
  let clang;
  if (has_cpp) {
    clang = llvmDir + '/bin/clang++';
  } else {
    clang = llvmDir + '/bin/clang';    
  }
  const cmd = clang + ' ' + get_lld_options(options) + ' ' + files + ' -o ' + output;
  const out = shell_exec(cmd, cwd);
  result_obj.console = sanitize_shell_output(out);
  if (!existsSync(output)) {
    result_obj.success = false;
    return false;
  }
  result_obj.success = true;
  return true;
}

      //  extension for wasmGC 

async function wasmgc(wasmFile) {
  if (!await exists(wasmFile)) {
    throw new Error("wasm is not found")
  }
  await exec(joinCmd([wasmGCCmd,wasmFile]));
  return wasmFile;
}


 //  extension code for chisel
async function chisel(outputFile, callback) {
  if (!await exists(outputFile)) {
    throw new Error("wasm is not chiseled")
  }
  await exec(joinCmd([chiselCmd, outputFile]));
  return outputFile;
}

//  //  extension code for wasmdis
async function wasmdis(watFile, callback) {
  if (!await exists(watFile)) {
    throw new Error("wat is not found")
  }
  await exec(joinCmd([wasmdisCmd, watFile]));
  return watFile;
}

 async function build_project(project, base) {
  const output = project.output;
  const compress = project.compress;
  const build_result = { };
  const dir = base + '.$';
  const result = base + '.wasm';
  const abc =base +'.wat';

  const complete = (success, message) => {
    shell_exec("rm -rf " + dir);
    if (existsSync(result)) {
      unlinkSync(result);
    }
  
    build_result.success = success;
    build_result.message = message;
    return build_result;
  };
  if (output != 'wat') {
    return complete(false, 'Invalid output type ' + output);
  }

  if (!existsSync(dir)) {
    mkdirSync(dir);
  }
  build_result.tasks = [];
  const files = project.files;
  for (let file of files) {
    const name = file.name;
    if (!validate_filename(name)) {
      return complete(false, 'Invalid filename ' + name);
    }
    const fileName = dir + '/' + name;
    const subdir = dirname(fileName);
    if (!existsSync(subdir)) {
      mkdirSync(dir);
    }
   
    const src = file.src;
    writeFileSync(fileName, src);
    // console.log(readFileSync(fileName));
    writeFileSync('./aaa.c', src);
  }
  const obj_files = [];
  let clang_cpp = false;
  for (let file of files) {
    const name = file.name;
    const fileName = dir + '/' + name;
    const type = file.type;
    const options = file.options;
    let success = true;
    const result_obj = {
      name: `building ${name}`,
      file: name
    };
 
    build_result.tasks.push(result_obj);
    if (type == 'c') {
      success = build_c_file(fileName, options, fileName+'.o', dir, compress, result_obj);    
      obj_files.push(fileName + '.o');
    } else if (type == 'cpp') {
      clang_cpp = true;
      success = build_cpp_file(fileName, options, fileName + '.o', dir, compress, result_obj);
      obj_files.push(fileName + '.o');
    } 
    if (!success) {
      return complete(false, 'Error during build of ' + name);
    }
  }

  const link_options = project.link_options;
  const link_result_obj = {
    name: 'linking wat'
  };

  build_result.tasks.push(link_result_obj);
  if (!link_obj_files(obj_files, link_options, dir, clang_cpp, result, link_result_obj)) {
    return complete(false, 'Error during linking');
  }


  // build_result.output = chisel(wasmgc(serialize_file_data(result, compress)));
 
 //  extension for wasmGC and chisel and wasmdis

  // let a= serialize_file_data(result, compress);
  // console.log(result);
  let a= readFileSync(result);
  writeFileSync('./cBu.wasm',a);
  // let b = await wasmgc(a);
  // let c =await chisel(b);
  //   writeFileSync('./chisel.wasm',c);

  // let d =await wasmdis(c);
  // writeFileSync('./nww.wat', d)
  build_result.output = a.toString("base64");
  return complete(true, 'Success');
}

module.exports = async (input, callback) => {
  const baseName = tempDir + '/build_' + Math.random().toString(36).slice(2);
  try {
    console.log('Building in ', baseName);
    const result = await build_project(input, baseName);
    callback(null, result);
  } catch (ex) {
    callback(ex);
  }
};
