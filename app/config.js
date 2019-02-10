const fs = require('fs');
const { spawnSync } = require('child_process');
const onServer = !!process.env["DYNO"];
const homeDir = process.env["HOME"];
const wasmceptionDir = process.env["WASMCEPTION"] ||
    (__dirname + '/../wasmception');

let wasmBindgenRoot;
if (!onServer) {
  wasmBindgenRoot = __dirname + '/../target';
  let opts = {stdio: 'inherit'};
  let ret = spawnSync('cargo', ['build', '--target=wasm32-unknown-unknown', '--release'], opts);
  if (ret.error)
    throw ret.error;
  if (ret.status !== 0)
    throw new Error('cargo failed')
} else {
  wasmBindgenRoot = homeDir + '/wasm-bindgen';
}
const deps = wasmBindgenRoot + '/wasm32-unknown-unknown/release/deps';
exports.wasmBindgenDeps = [deps, wasmBindgenRoot + '/release/deps'];
exports.cargoCmd = homeDir + '/.cargo/bin/cargo';
exports.rustcCmd = homeDir + '/.cargo/bin/rustc';
exports.wasmBindgenCmd = homeDir + '/.cargo/bin/wasm-bindgen'; 
exports.rustfmtCmd = homeDir + '/.cargo/bin/rustfmt';
exports.sysroot = onServer ?
  homeDir + '/sysroot' :
  wasmceptionDir + '/sysroot';

exports.llvmDir = onServer ?
  homeDir + '/clang' :
  wasmceptionDir + '/dist';


//  extension command for wasmGC and chisel and wasmdis

exports.wasmGCCmd = homeDir + '/.cargo/bin/wasm-gc';

exports.chiselCmd = homeDir + '/.cargo/bin/chisel';

// exports.pychiselCmd = homeDir + '/codes/varna/pywebassembly/examples/';
exports.pychiselCmd = __dirname + '/../pywebassembly/examples/';

// exports.wasmdisCmd = homeDir + '/binaryen-1.37.35/bin/wasm-dis';
exports.wasmdisCmd = __dirname + '/../binaryen-1.37.35/bin/wasm-dis';


exports.tempDir = "/tmp";

