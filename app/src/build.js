// Translated from https://github.com/wasdk/wasmexplorer-service/blob/master/web/build.php
// FIXME make me node.js friendly and async

const { llvmDir, wasmGCCmd, chiselCmd, wasmdisCmd, pychiselCmd, tempDir, sysroot } = require("../config");
const { mkdirSync, writeFileSync, existsSync, openSync, closeSync, readFileSync, unlinkSync } = require("fs");
const { deflateSync } = require("zlib");
const { dirname } = require("path");
const { execSync } = require("child_process");
const { Writable } = require("stream");
const { exec, joinCmd, exists } = require("./common.js");
const gcWasm = 'gcWasm.wasm';
const chiseledWasm = 'chiseledWasmFile.wasm';
const wasmDis = 'wasmDisFile.wat';


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
  // const clang_flags = `--target=wasm32-unknown-unknown-wasm --sysroot=${sysroot} -nostartfiles -Wl,--allow-undefined,--no-entry,--no-threads`;  // Yuri's code is not compatible for Varna
  const clang_flags = ` --target=wasm32-unknown-unknown-wasm --sysroot=${sysroot} -O3 -g -nostartfiles -Wl,--allow-undefined,--demangle,--no-entry,--no-threads -Wl,--export=_main -fvisibility=hidden `
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
  console.log("input: " + input + " output: " + output);
  const cmd = llvmDir + '/bin/clang ' + get_clang_options('-O3 -std=c99') + ' ' + input + ' -o ' + output;
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
  console.log("input: " + input + " output: " + output);
  const cmd = llvmDir + '/bin/clang++ ' + get_clang_options('-O3 -std=c++98') + ' ' + input + ' -o ' + output;
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
async function wasmGC(wasmFile) {
  if (!existsSync(wasmFile)) {
    throw new Error("Wasm file is not found")
  }
  try{
    await exec(joinCmd([wasmGCCmd, wasmFile, '-o', gcWasm]));
    console.log("Optimised Wasm File Name: " + gcWasm);
    return gcWasm;
  } catch(e){
    console.log(e.message);
  }
}

//  extension for chisel -> wasm-chisel is failed to produce proper output 
// async function chisel(optimisedWasmFile) {
//   if (!existsSync(optimisedWasmFile)) {
//     throw new Error("Wasm is not optimised")
//   }
//  try{
//   await exec(joinCmd([chiselCmd, optimisedWasmFile, chiseledWasm])); 
//   console.log("Chiseled File Name: " + chiseledWasm);
//   return chiseledWasm;
//   } catch (e){
//    return e.message;
//  }
// }

// extension for chisel using pywebassembly
async function chisel(optimisedWasmFile) {
  if (!existsSync(optimisedWasmFile)) {
    throw new Error("Wasm is not optimised")
  }
 try{
  await exec(joinCmd(['cd', pychiselCmd , '&& python3', 'ewasmify.py', "../../app/" + optimisedWasmFile]));
  return 'gcWasm_ewasmified.wasm';
  } catch(e){
    console.log(e);
    return e.message;
  }
}
  
//  extension for wasmdis
async function wasmdis(chiseledWasmFile) {
  if (!existsSync(chiseledWasmFile)) {
    throw new Error("Wat file is not found")
  }
  try {
  await exec(joinCmd([wasmdisCmd, chiseledWasmFile, '-o', wasmDis]));  
  console.log("Wasmdis File Name: " + wasmDis);
  } catch(e){
    return e.message;
  }
  let wasmDisFileContent;
  wasmDisFileContent = readFileSync(wasmDis, 'utf8');
  return wasmDisFileContent;
}


async function build_project_c(project, base) {
  const build_result = { };
  const dir = base + '.$';
  const result = base + '.wasm';
  const obj_files = [];
  const clang_cpp = false;

  const complete = (success, message) => {
    shell_exec("rm -rf " + dir);
    if (existsSync(result)) {
      unlinkSync(result);
    }
  
    build_result.success = success;
    build_result.message = message;
    return build_result;
  };

  if (!existsSync(dir)) {
    mkdirSync(dir);
  }
  build_result.console = '';
  let tasks = [];
  const compress = true;
  const name = "sourceFile.c"
  const fileName = dir + '/' + name;
    const subdir = dirname(fileName);
    if (!existsSync(subdir)) {
      mkdirSync(dir);
    }

  const code = project.code;
  writeFileSync(fileName, code);

  let success = true;
    const result_obj = {
      name: `building ${name}`,
      file: name
    };
 
  tasks.push(result_obj); 
  const type = "c";
  success = build_c_file(fileName, '-O3 -std=c99', fileName + '.o', dir, compress, result_obj);    
  obj_files.push(fileName + '.o');
  if (!success) {
    let message = build_result.message || '';
    return { success, message, console: tasks[0].console };
  }

  const link_options = project.link_options;
  const link_result_obj = {
    name: 'linking wasm'
  };

  tasks.push(link_result_obj); 
  if (!link_obj_files(obj_files, link_options, dir, clang_cpp, result, link_result_obj)) {
    return complete(false, 'Error during linking');
  }
 
 //  extension for wasmGC and chisel and wasmdis

  let test= readFileSync(result);
  writeFileSync('./clang.wasm',test);
  let wasmgcFile = await wasmGC(result);
  let chiseledFile = await chisel(wasmgcFile);
  let watFile = await wasmdis(chiseledFile);
  if(success)
  return { success, message: "", output: watFile };
  build_result.output = serialize_file_data(watFile, compress);
  return complete(true, 'Success');
}

async function build_project_cpp(project, base) {
  const build_result = { };
  const dir = base + '.$';
  const result = base + '.wasm';
  const clang_cpp = true;
  let success;
  const obj_files = [];

  const complete = (success, message) => {
    shell_exec("rm -rf " + dir);
    if (existsSync(result)) {
      unlinkSync(result);
    }
  
    build_result.success = success;
    build_result.message = message;
    return build_result;
  };
 
  if (!existsSync(dir)) {
    mkdirSync(dir);
  }
  build_result.console = '';
  let tasks = [];
  const compress = true;
  const name = "sourceFile.cpp"
  const fileName = dir + '/' + name;
    const subdir = dirname(fileName);
    if (!existsSync(subdir)) {
      mkdirSync(dir);
    }

  const code = project.code;
  writeFileSync(fileName, code);
    const result_obj = {
      name: `building ${name}`,
      file: name
    };
 
  tasks.push(result_obj); 
  const type = "cpp";
  success = build_cpp_file(fileName, '-O3 -std=c++98', fileName + '.o', dir, compress, result_obj);
  obj_files.push(fileName + '.o');
  if (!success) {
    let message = build_result.message || '';
    return { success, message, console: tasks[0].console };
  }
  const link_options = project.link_options;
  const link_result_obj = {
    name: 'linking wasm'
  };

  tasks.push(link_result_obj); 
  if (!link_obj_files(obj_files, link_options, dir, clang_cpp, result, link_result_obj)) {
    return complete(false, 'Error during linking');
  }
 
 //  extension for wasmGC and chisel and wasmdis

  let test= readFileSync(result);
  writeFileSync('./clang.wasm',test);
  let wasmgcFile = await wasmGC(result);
  let chiseledFile = await chisel(wasmgcFile);
  let watFile = await wasmdis(chiseledFile);
  if(success)
  return { success, message: "", output: watFile };

  build_result.output = serialize_file_data(watFile, compress);
  return complete(true, 'Success');
}

module.exports.build_c = async (input, callback) => {
  const baseName = tempDir + '/build_' + Math.random().toString(36).slice(2);
  try {
    console.log('Building in ', baseName);
    const result = await build_project_c(input, baseName);
    callback(null, result);
  } catch (ex) {
    callback(ex);
  }
};

module.exports.build_cpp = async (input, callback) => {
  const baseName = tempDir + '/build_' + Math.random().toString(36).slice(2);
  try {
    console.log('Building in ', baseName);
    const result = await build_project_cpp(input, baseName);
    callback(null, result);
  } catch (ex) {
    callback(ex);
  }
};
